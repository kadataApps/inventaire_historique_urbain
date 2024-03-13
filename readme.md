# Inventaire Historique Urbain - Modèle de données et projet QGIS d'aide à la saisie

## Contenu du dépot

Ce dépot contient:

- les schémas de données relatifs à l'Inventaire Historique Urbain (dossier `schemas`)
  - les schémas relatifs aux données géographiques au format [json schema](https://json-schema.org/) et stockées au format [geojson](https://geojson.org/schema/FeatureCollection.json) (dans le répertoire `schemas/geojson`)
    - Exploitants et Occupants
    - Etudes SSP
    - Sources Potentielles de Pollution
    - Ouvrages de surveillance
    - Zones de dépollution
    - Occupation du sol
  - les schémas relatifs aux données tabulaires au format [table schema](https://specs.frictionlessdata.io/table-schema/) et stockées au format csv ( dans le répertoire `schemas/csv`)
    - Versions des inventaires historiques urbains
    - Sources d'informations
- des scripts permettant
  - la création d'une base de données postgresql avec le modèle de données de l'IHU
  - l'export des tables de base au format geojson (tables contenant des géométries) ou csv (tables attributaires uniquement)
- un projet QGIS permettant la saisie des données de l'IHU (dossier `qgis`)

La documentation du modèle de données (nomenclature) est disponible dans le dossier `doc`

**NB: le projet QGIS a été développé pour QGIS 3.28 (LTR)**

## Contexte


## Utilisation des scripts

### Création de la base de données

#### Dépendances

Le script nécessite `psql` ainsi qu'une base de données `postgresql` avec les extensions `postgis` et `uuid-ossp` installées.

Mettre à jour les variables env var dans `create_ihu_database.sh`, puis: 

`make create-db-with-model`

### Export des tables en geojson ou csv

Le script permet d'exporter les données de la base de données postgresql au format geojson ou csv.

`make db2files`

### Validation des donnéés

Les données au format csv seront validées selon leur conformité avec des shemas au format Table Schema. La validation est réalisée en python avec Frictionless et jsonschema.

#### Installation de poetry et des dépendances frictionless et jsonschema

```make setup-validation```

#### Validation des données créées

La commande `validate-ihu` permet de valider les données créées au format csv et geojson.
Les données doivent être placées dans le répertoire `qgis/data`.
```make validate-ihu```


## Licence

L'ensemble du projet, à savoir le modèle de données ainsi que la documentation et les annexes (données tests, scripts de validation...), est publié sous la licence MIT.
Les données produites ont pour vocation à être publiées sous [licence ouverte 2.0 (Etalab)](https://www.etalab.gouv.fr/licence-ouverte-open-licence/).
