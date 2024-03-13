import json
from jsonschema import validate
from jsonschema.exceptions import ValidationError
from pathlib import Path

DATA_PATH = Path('./qgis/data')
GEOJSON_SCHEMA_PATH = Path('./schemas/geojson')

def load_json_file(filename):
    """Load a JSON file and return its content."""
    with open(filename, 'r') as file:
        return json.load(file)

def load_and_validate_geojson(geojson_file, schema_file):
    """Validate GeoJSON data against the schema."""

    try:
        geojson_data = load_json_file(geojson_file)
        schema = load_json_file(schema_file)
    except FileNotFoundError as e:
        print("Fichier non trouvé. Error:", e)
        return

    try:
        validate(instance=geojson_data, schema=schema)
        print(f"Le fichier GeoJSON {Path(geojson_file).name} respecte le schéma de données.")
    except ValidationError as e:
        print(f"Validation du fichier GeoJSON {Path(geojson_file).name} contre le schéma {schema_file}...")
        print(f"Le fichier GeoJSON {Path(geojson_file).name} n'est pas valide. Erreur:", e)



def main():

    """Exploitant Occupant"""
    exploitant_occupant_geojson_file = DATA_PATH / 'exploitants_occupants.geojson'  # Update this path
    exploitant_occupant_schema_file = GEOJSON_SCHEMA_PATH / 'schema_exploitants_occupants.json'
    
    load_and_validate_geojson(exploitant_occupant_geojson_file, exploitant_occupant_schema_file)

    """SPP"""
    spp_geojson_file = DATA_PATH / 'sources_potentielles_pollution.geojson'  # Update this path
    spp_schema_file = GEOJSON_SCHEMA_PATH / 'schema_sources_potentielles_pollution.json'
    
    load_and_validate_geojson(spp_geojson_file, spp_schema_file)

    """Etudes SSP"""
    etudes_ssp_geojson_file = DATA_PATH / 'etudes_ssp.geojson'  # Update this path
    etudes_ssp_schema_file = GEOJSON_SCHEMA_PATH / 'schema_etudes_ssp.json'

    load_and_validate_geojson(etudes_ssp_geojson_file, etudes_ssp_schema_file)

    """Ouvrages de surveillance"""
    ouvrages_geojson_file = DATA_PATH / 'ouvrages_surveillance.geojson'  # Update this path
    ouvrages_schema_file = GEOJSON_SCHEMA_PATH / 'schema_ouvrages_surveillance.json'

    load_and_validate_geojson(ouvrages_geojson_file, ouvrages_schema_file)

    """Surfaces Occupation du sol ZAN"""
    surfaces_zan_geojson_file = DATA_PATH / 'surfaces_occupation_sol_zan.geojson'  # Update this path
    surfaces_zan_schema_file = GEOJSON_SCHEMA_PATH / 'schema_surfaces_occupation_sol_zan.json'

    load_and_validate_geojson(surfaces_zan_geojson_file, surfaces_zan_schema_file)

    """Zones de dépollution"""
    zones_dep_geojson_file = DATA_PATH / 'zones_depollution.geojson'  # Update this path
    zones_dep_schema_file = GEOJSON_SCHEMA_PATH / 'schema_zones_depollution.json'

    load_and_validate_geojson(zones_dep_geojson_file, zones_dep_schema_file)

if __name__ == "__main__":
    main()
