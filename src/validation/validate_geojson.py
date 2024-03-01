import json
from jsonschema import validate
from jsonschema.exceptions import ValidationError

def load_json_file(filename):
    """Load a JSON file and return its content."""
    with open(filename, 'r') as file:
        return json.load(file)

def load_and_validate_geojson(geojson_file, schema_file):
    """Validate GeoJSON data against the schema."""
    print(f"Validation du fichier GeoJSON {geojson_file} contre le schéma {schema_file}...")

    try:
        geojson_data = load_json_file(geojson_file)
        schema = load_json_file(schema_file)
    except FileNotFoundError as e:
        print("Fichier non trouvé. Error:", e)
        return

    try:
        validate(instance=geojson_data, schema=schema)
        print("Le fichier GeoJSON respecte le schéma de données.")
    except ValidationError as e:
        print("Le fichier GeoJSON n'est pas valide. Erreur:", e)



def main():

    """SPP"""
    spp_geojson_file = './qgis_template/data/sources_potentielles_pollution.geojson'  # Update this path
    spp_schema_file = './schemas/geojson/schema_sources_potentielles_pollution.json'       # Update this path
    
    load_and_validate_geojson(spp_geojson_file, spp_schema_file)

    """Etudes SSP"""
    etudes_spp_geojson_file = './qgis_template/data/etudes_ssp.geojson'  # Update this path
    etudes_spp_schema_file = './schemas/geojson/schema_etudes_ssp.json'       # Update this path

    load_and_validate_geojson(etudes_spp_geojson_file, etudes_spp_schema_file)

    """Ouvrages de surveillance"""
    ouvrages_geojson_file = './qgis_template/data/ouvrages_surveillance.geojson'  # Update this path
    ouvrages_schema_file = './schemas/geojson/schema_ouvrages_surveillance.json'       # Update this path

    load_and_validate_geojson(ouvrages_geojson_file, ouvrages_schema_file)

    """Surfaces Occupation du sol ZAN"""
    surfaces_zan_geojson_file = './qgis_template/data/surfaces_occupation_sol_zan.geojson'  # Update this path
    surfaces_zan_schema_file = './schemas/geojson/schema_surfaces_occupation_sol_zan.json'       # Update this path

    load_and_validate_geojson(surfaces_zan_geojson_file, surfaces_zan_schema_file)

    """Zones de dépollution"""
    zones_dep_geojson_file = './qgis_template/data/zones_depollution.geojson'  # Update this path
    zones_dep_schema_file = './schemas/geojson/schema_zones_depollution.json'       # Update this path

    load_and_validate_geojson(zones_dep_geojson_file, zones_dep_schema_file)

if __name__ == "__main__":
    main()
