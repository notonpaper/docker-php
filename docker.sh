#!/bin/sh
MYSQLSTORAGE=~/Docker/mysqlStorage

# Check if the MySQL Storage exists, if not create the directory
if [ ! -d $MYSQLSTORAGE ]; then
  mkdir -p $MYSQLSTORAGE
  echo "Mysql local storage has been created"
fi

# Get the current directory name without the fullpath
DIR=${PWD##*/}
PROJECT="${DIR//-}"

# Now define which options we want to provide
case $1 in
    up)
        echo "-- Starting Docker --"
        docker-compose up -d
        ;;
    down)
        echo "-- Stopping Docker --"
        docker-compose down
        ;;
    rebuild)
        echo "-- Rebuilding Docker --"
        docker-compose kill && docker-compose build && docker-compose up -d
        ;;
    artisan)
        CONTAINER="_php_1"
        docker exec $PROJECT$CONTAINER php artisan $2 $3 $4
        ;;
    *)
        echo $"Usage: $0 {up|down|rebuild|artisan}"
        exit 1
        ;;
esac

