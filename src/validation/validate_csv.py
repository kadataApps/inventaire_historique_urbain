from frictionless import validate, Schema

schema = Schema('./schemas/csv/schema_versions_inventaire_historique_urbain.json')
report = validate('./qgis_template/data/versions_inventaire_historique_urbain.csv', schema=schema)

if report.valid:
    print("Le fichier CSV est valide.")
else:
    print("Le fichier CSV n'est pas valide. Erreurs:", report.flatten(["rowPosition", "fieldPosition", "code", "message"]))
