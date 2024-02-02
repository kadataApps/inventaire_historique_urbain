#!/bin/bash

# PostGIS database details
DB_HOST="localhost"
DB_PORT="5433"
DB_USER="postgres"
DB_NAME="ihu"
DB_PASSWORD="postgres"

# Directory to save the GeoJSON files
OUTPUT_DIR="./data"

# List of tables to export
declare -a GEOM_TABLES=("exploitants_occupants" "etudes_ssp" "sources_potentielles_pollution" "ouvrages_surveillance" "zones_depollution" "surfaces_occupation_sol_zan") 

declare -a ATTRIBUTE_TABLES=("versions_inventaire_historique_urbain" "sources_information" "type_activite_occupation" "type_icpe" "type_mission_ssp" "type_usage_compatible" "type_usage_remise_en_etat" "type_polluant" "type_ouvrage" "type_occupation_principale")

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Export each table
for TABLE in "${GEOM_TABLES[@]}"; do
    echo "Exporting $TABLE to GeoJSON..."
    ogr2ogr -f "GeoJSON" "$OUTPUT_DIR/$TABLE.geojson" \
            PG:"dbname='$DB_NAME' host='$DB_HOST' port='$DB_PORT' user='$DB_USER' password='$DB_PASSWORD'" \
            "$TABLE"
done

echo "Export geometry tables completed."

for TABLE in "${ATTRIBUTE_TABLES[@]}"; do
    echo "Exporting $TABLE to CSV..."
    PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" \
        -c "\COPY $TABLE TO '$OUTPUT_DIR/$TABLE.csv' CSV HEADER"
done

echo "Export csv tables completed."
