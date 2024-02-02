
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

BEGIN;
DROP TABLE IF EXISTS exploitants_occupants_sources_information;
DROP TABLE IF EXISTS etudes_ssp_sources_information;
DROP TABLE IF EXISTS sources_potentielles_pollution_ponctuelles_sources_information;
DROP TABLE IF EXISTS sources_potentielles_pollution_surfaciques_sources_information;
DROP TABLE IF EXISTS ouvrages_surveillance_sources_information;

DROP TABLE IF EXISTS versions_inventaire_historique_urbain;
DROP TABLE IF EXISTS exploitants_occupants;
DROP TABLE IF EXISTS etudes_ssp;
DROP TABLE IF EXISTS sources_potentielles_pollution_ponctuelles;
DROP TABLE IF EXISTS sources_potentielles_pollution_surfaciques;
DROP TABLE IF EXISTS ouvrages_surveillance;
DROP TABLE IF EXISTS zones_depollution;
DROP TABLE IF EXISTS surfaces_occupation_sol_zan;
DROP TABLE IF EXISTS environnement_site;
DROP TABLE IF EXISTS sources_information;

DROP TABLE IF EXISTS type_activite_occupation;
DROP TABLE IF EXISTS type_icpe;
DROP TABLE IF EXISTS type_mission_ssp;
DROP TABLE IF EXISTS type_usage_compatible;
DROP TABLE IF EXISTS type_usage_remise_en_etat;
DROP TABLE IF EXISTS type_polluant;
DROP TABLE IF EXISTS type_ouvrage;
DROP TABLE IF EXISTS type_occupation_principale;

CREATE TABLE versions_inventaire_historique_urbain (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    date_debut_saisie TEXT,
    date_fin_saisie TEXT,
    bureau_etude TEXT,
    commentaire TEXT
);

CREATE TABLE exploitants_occupants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    siren_siret_exploitant TEXT,
    exploitant TEXT,
    type_icpe TEXT,
    est_dernier_exploitant_connu BOOLEAN,
    est_en_activite BOOLEAN,
    activite_occupation TEXT,
    type_activite_occupation TEXT,
    adresse TEXT,
    code_insee TEXT,
    commune TEXT,
    surface FLOAT,
    id_casias TEXT,
    id_basol TEXT,
    id_sis_sup TEXT,
    annee_debut_exploitation INTEGER,
    annee_fin_exploitation INTEGER,
    annee_cessation_activite INTEGER,
    recepisse_cessation_obtenu BOOLEAN,
    commentaire TEXT,
    documents TEXT
);
CREATE INDEX sidx_exploitants_occupants_geom ON exploitants_occupants USING GIST (geom);

CREATE TABLE etudes_ssp (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    id_etude_ssp TEXT,
    a_ete_consulte BOOLEAN,
    types_mission_ssp TEXT,
    date_etude TEXT,
    occupation_constatee TEXT,
    presence_batiments BOOLEAN,
    types_usages_compatibles TEXT,
    bureau_etude TEXT,
    maitre_ouvrage TEXT,
    commentaire TEXT,
    documents TEXT
);
CREATE INDEX sidx_etudes_ssp_geom ON etudes_ssp USING GIST (geom);

CREATE TABLE sources_potentielles_pollution_ponctuelles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(POINT, 4326),
    description_spp TEXT,
    est_enterree BOOLEAN,
    types_polluants TEXT,
    annee_installation INTEGER,
    annee_mise_en_securite INTEGER,
    commentaire TEXT,
    documents TEXT
);
CREATE INDEX sidx_sources_potentielles_pollution_ponctuelles_geom ON sources_potentielles_pollution_ponctuelles USING GIST (geom);

CREATE TABLE sources_potentielles_pollution_surfaciques (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    description_spp TEXT,
    est_enterree BOOLEAN,
    types_polluants TEXT,
    annee_installation INTEGER,
    annee_mise_en_securite INTEGER,
    commentaire TEXT,
    documents TEXT
);
CREATE INDEX sidx_sources_potentielles_pollution_surfaciques_geom ON sources_potentielles_pollution_surfaciques USING GIST (geom);

CREATE TABLE ouvrages_surveillance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(POINT, 4326),
    type_ouvrage TEXT,
    date_inspection TEXT,
    profondeur NUMERIC,
    commentaire TEXT,
    documents TEXT
);

CREATE TABLE zones_depollution (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    entreprise_travaux TEXT,
    date_travaux TEXT,
    maitre_ouvrage TEXT,
    amo_moe TEXT,
    seuils_de_coupure TEXT,
    types_usages_remise_en_etat TEXT,
    commentaire TEXT,
    documents TEXT
);



CREATE TABLE surfaces_occupation_sol_zan (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    surface NUMERIC,
    occupation_principale TEXT,
    surface_construite NUMERIC,
    surface_semi_permeable NUMERIC,
    surface_herbacee NUMERIC,
    surface_arboree NUMERIC,
    surface_eau NUMERIC,
    date_maj TEXT,
    sources_surfaces TEXT
);

CREATE TABLE environnement_site (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    eaux_surfaces TEXT,
    perimetre_aep TEXT,
    zones_naturelles TEXT,
    etablissements_sensibles TEXT,
    plu TEXT,
    bss TEXT,
    risques_naturels TEXT,
    risques_technologiques TEXT,
    commentaire TEXT
);


CREATE TABLE sources_information (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_dossier TEXT,
    uri TEXT,
    nom_source TEXT,
    a_ete_consulte BOOLEAN,
    commentaire TEXT
);

-- -- Tables de liaison des sources d'information
-- CREATE TABLE exploitants_occupants_sources_information (
--     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     id_exploitant UUID references exploitants_occupants(id_exploitant),
--     id_source_information UUID references sources_information(id),
--     UNIQUE (id_exploitant, id_source_information)
-- );


-- CREATE TABLE etudes_ssp_sources_information (
--     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     id_etude_ssp UUID references etudes_ssp(id),
--     id_source_information UUID references sources_information(id),
--     UNIQUE (id_etude_ssp, id_source_information)
-- );


-- CREATE TABLE sources_potentielles_pollution_ponctuelles_sources_information (
--     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     id_spp UUID references sources_potentielles_pollution_ponctuelles(id_spp),
--     id_source_information UUID references sources_information(id),
--     UNIQUE (id_spp, id_source_information)
-- );


-- CREATE TABLE sources_potentielles_pollution_surfaciques_sources_information (
--     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     id_spp UUID references sources_potentielles_pollution_surfaciques(id_spp),
--     id_source_information UUID references sources_information(id),
--     UNIQUE (id_spp, id_source_information)
-- );


-- CREATE TABLE ouvrages_surveillance_sources_information (
--     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     id_ouvrage_surveillance UUID references ouvrages_surveillance(id),
--     id_source_information UUID references sources_information(id),
--     UNIQUE (id_ouvrage_surveillance, id_source_information)
-- );


-- Tables attributaires
CREATE TABLE type_activite_occupation (
    id INTEGER PRIMARY KEY,
    type_activite_occupation TEXT
);
INSERT INTO type_activite_occupation (id, type_activite_occupation) VALUES 
 (1, 'Inconnue'),
 (2, 'Aucune'),
 (3, 'Résidentielle'),
 (4, 'Agricole'),
 (5, 'Industrielle'),
 (6, 'Etablissement sensible'),
 (7, 'Autre (à définir dans le commentaire)');

CREATE TABLE type_icpe (
    id INTEGER PRIMARY KEY,
    type_icpe TEXT
);
INSERT INTO type_icpe (id, type_icpe) VALUES 
 (1, 'Aucune'),
 (2, 'Inconnue'),
 (3, 'Déclaration'),
 (4, 'Déclaration avec contrôle périodique'),
 (5, 'Enregistrement'),
 (6, 'Autorisation'),
 (7, 'SEVESO seuil bas'),
 (8, 'SEVESO seuil haut'),
 (9, 'Autre (à définir dans le commentaire)');

CREATE TABLE type_mission_ssp (
    id INTEGER PRIMARY KEY,
    type_mission_ssp TEXT);
INSERT INTO type_mission_ssp (id, type_mission_ssp) VALUES
  (1, 'Etude historique'),
  (2, 'Etude de vulnérabilité'),
  (3, 'Investigations sol'),
  (4, 'Investigations eaux souterraines'),
  (5, 'Investigations eaux superficielles'),
  (6, 'Investigations gaz des sols'),
  (7, 'Investigations air ambiant'),
  (8, 'EQRS'),
  (9, 'Analyse des risques résiduels'),
  (10, 'Plan de gestion'),
  (11, 'IEM'),
  (12, 'ATTES'),
  (13, 'Autre (à définir dans le commentaire)');
  

CREATE TABLE type_usage_compatible (
    id INTEGER PRIMARY KEY,
    type_usage_compatible TEXT);

INSERT INTO type_usage_compatible (id, type_usage_compatible) VALUES
  (1, 'Logements'),
  (2, 'Bureaux'),
  (3, 'Commerces'),
  (4, 'Administration'),
  (5, 'Industriel'),
  (6, 'Equipements publics'),
  (7, 'Espaces publics'),
  (8, 'Renaturation'),
  (9, 'Panneaux photovoltaïques'),
  (10,'Energie hors photovoltaïque'),
  (11,'Autre (à définir dans le commentaire)');

CREATE TABLE type_usage_remise_en_etat (
    id INTEGER PRIMARY KEY,
    type_usage_remise_en_etat TEXT);

INSERT INTO type_usage_remise_en_etat (id, type_usage_remise_en_etat) VALUES
  (1, 'Résidentiel'),
  (5, 'Industriel'),
  (11,'Autre (à définir dans le commentaire)');


CREATE TABLE type_polluant (
    id INTEGER PRIMARY KEY,
    type_polluant TEXT);
INSERT INTO type_polluant (id, type_polluant) VALUES
  (1, 'Inconnue'),
  (2, 'Pollution métallique'),
  (3, 'Pollution organique par des hydrocarbures'),
  (4, 'Pollution organique par des solvants'),
  (5,'Autre (à définir dans le commentaire)');

CREATE TABLE type_ouvrage (
    id INTEGER PRIMARY KEY,
    type_ouvrage TEXT);
INSERT INTO type_ouvrage (id, type_ouvrage) VALUES
  (1, 'Inconnu'),
  (2, 'Piézomètre'),
  (3, 'Puits'),
  (4, 'Piézair'),
  (5, 'Autre (à définir dans le commentaire)');
  
CREATE TABLE type_occupation_principale (
    id INTEGER PRIMARY KEY,
    type_occupation_principale TEXT);
INSERT INTO type_occupation_principale (id, type_occupation_principale) VALUES
    (1, 'Surface construite'),
    (2, 'Surface semi-perméable'),
    (3, 'Surface herbacée'),
    (4, 'Surface arborée'),
    (5, 'Surface eau');

COMMIT;