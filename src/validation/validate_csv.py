from frictionless import Schema, validate
from pathlib import Path

DATA_PATH = Path('./qgis/data')
CSV_SCHEMA_PATH = Path('./schemas/csv')


def validate_file(path_schema, path_file):
    schema = Schema(path_schema)
    file = validate(path_file, schema=schema)

    if file.valid:
        print("Le fichier CSV", path_file," est valide.")
    else:
        print("Le fichier CSV", path_file ," n'est pas valide. Erreurs:", file.flatten(["rowPosition", "fieldPosition", "code", "message"]))


def main():
    path_schema_versions_inventaire_historique_urbain = CSV_SCHEMA_PATH / 'schema_versions_inventaire_historique_urbain.json'
    path_file_versions_inventaire_historique_urbain = DATA_PATH / 'versions_inventaire_historique_urbain.csv'
    validate_file(path_schema_versions_inventaire_historique_urbain, path_file_versions_inventaire_historique_urbain)

    path_schema_sources_information = CSV_SCHEMA_PATH / 'schema_sources_information.json'
    path_file_sources_information = DATA_PATH / 'sources_information.csv'
    validate_file(path_schema_sources_information, path_file_sources_information)

if __name__ == "__main__":
    main()
