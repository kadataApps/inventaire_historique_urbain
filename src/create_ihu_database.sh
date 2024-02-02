#!/bin/bash

# Define your database and user details
DB_HOST="localhost"
DB_PORT="5433"
DB_USER="postgres"
DB_NAME="ihu"
DB_PASSWORD="postgres"

SQL_FILE="./src/create_ihu_model.sql"
SQL_FILE_POPULATE="./src/populate_ihu_model.sql"
# Create a new PostgreSQL database
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE $DB_NAME;"

# Execute the SQL file
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f $SQL_FILE
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f $SQL_FILE_POPULATE
