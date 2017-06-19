#!/bin/sh
MYSQLSTORAGE=~/Docker/mysqlStorage
COMPOSE_FILE="vendor/notonpaper/docker/docker-compose.yml"

# Check if the MySQL Storage exists, if not create the directory
if [ ! -d $MYSQLSTORAGE ]; then
  mkdir -p $MYSQLSTORAGE
  echo "Mysql local storage has been created"
fi

# Get the current directory name without the fullpath
DIR=${PWD##*/}
PROJECT="${DIR//-}"
UP_MESSAGE="\nOpen the site for $DIR on http://localhost:8080"

# Now define which options we want to provide
case $1 in
    up)
        echo "-- Starting Docker --"
        docker-compose -f $COMPOSE_FILE -p $PROJECT up -d

        echo $UP_MESSAGE
        ;;
    down)
        echo "-- Stopping Docker --"
        docker-compose -f $COMPOSE_FILE -p $PROJECT down
        ;;
    rebuild)
        echo "-- Rebuilding Docker --"
        docker-compose -f $COMPOSE_FILE -p $PROJECT kill \
        && docker-compose -f $COMPOSE_FILE -p $PROJECT build \
        && docker-compose -f $COMPOSE_FILE -p $PROJECT up -d

        echo $UP_MESSAGE
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

