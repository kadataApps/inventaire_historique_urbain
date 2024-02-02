run-gdal:
	docker run -v "$$(pwd)"/data/:/data/ -it ghcr.io/osgeo/gdal:ubuntu-small-3.7.1 bash

create-db-with-model:
	./src/create_ihu_database.sh

db2files:
	./src/export_ihu_tables.sh
