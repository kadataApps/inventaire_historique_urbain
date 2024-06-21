# Inventaire Historique Urbain - Modèle de données et projet QGIS d'aide à la saisie

Le renouvellement urbain et la reconstruction de la ville sur la ville sont des enjeux majeurs de l’urbanisme pour l’ensemble des acteurs de l’aménagement du territoire et en particulier les collectivités territoriales depuis déjà plusieurs années. Ils s’inscrivent désormais pleinement dans la démarche ZAN (Zéro Artificialisation Nette), mise en place en 2021 par la Loi Climat et Résilience, qui fixe comme objectif d’atteindre, en 2050, l’absence de toute artificialisation nette des sols.

Ces enjeux nécessitent la prise en compte des éventuels risques environnementaux et sanitaires liés à l’historique et au contexte environnemental de ces zones urbaines.

La démarche d’Inventaire Historique Urbain (IHU) a pour vocation de permettre aux collectivités locales de développer leur connaissance  des sites potentiellement pollués et des friches de leur territoire, d’anticiper les enjeux associés dans le cadre de leurs futurs projets d’aménagement, et, potentiellement, d’apporter aux porteurs de projet un premier niveau d’information relatif au risque de présence de pollution sur un site.

L’ADEME accompagne les collectivités locales dans ces démarches par un dispositif d’Aides à la Décision, se traduisant d’une part par des aides financières, et d’autre part par la mise à disposition d’outils et de méthodes pour améliorer les pratiques.

Dans ce cadre, l’ADEME met à disposition des collectivités, depuis 2021, un cahier des charges type pour l’élaboration d’un IHU. Dans cette continuité, elle a souhaité pouvoir proposer aux collectivités des outils complémentaires pour l’élaboration d’un IHU. Une base de données type et un modèle de saisie de données QGIS ont ainsi été créés.

La création de ces outils s’est appuyée sur l’interview de collectivités ou d’agences d’urbanisme en vue de recueillir leurs attentes et leurs retours d’expérience en matière d’IHU.

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
