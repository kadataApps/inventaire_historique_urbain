run-gdal:
	docker run -v "$$(pwd)"/data/:/data/ -it ghcr.io/osgeo/gdal:ubuntu-small-3.7.1 bash

# Model & Template Data
.PHONY: create-db-with-model db2files
create-db-with-model:
	@./src/scripts/create_ihu_database.sh

db2files:
	@./src/scripts/export_ihu_tables.sh


# Validation
.PHONY: setup-validation validate-csv validate-geojson validate-ihu
setup-validation:
	@./src/scripts/setup_validation.sh

validate-csv:
	poetry run python src/validation/validate_csv.py

validate-geojson:
	poetry run python src/validation/validate_geojson.py

validate-ihu: validate-csv validate-geojson