# Inventaire Historique Urbain - Modèle de données et projet QGIS d'aide à la saisie

## Contenu du dépot

Ce dépot contient:

- des scripts permettant
  - la création d'une base de données postgresql avec le modèle de données de l'IHU
  - l'export des tables de base au format geojson (tables contenant des géométries) ou csv (tables attributaires uniquement)
- un projet QGIS permettant la saisie des données de l'IHU (dossier `qgis_template`)

La documentation du modèle de données (nomenclature) est disponible dans le dossier `doc`

**NB: le projet QGIS a été développé pour QGIS 3.28 (LTR)**

## Utilisation des scripts

### Dépendances

- psql

### Création de la base de données

Mettre à jour les variables env var dans `create_ihu_database.sh`

`make create-db-with-model`

## Export des tables en geojson ou csv

`make db2files`

## Validation des donnéés

Les données au format csv seront validées selon leur conformité avec des shemas au format Table Schema. La validation est réalisée en python avec Frictionless et jsonschema.

### Installation de poetry et des dépendances frictionless et jsonschema

```make setup-validation```

### Validation des données

```make validate-ihu```
