#!/bin/bash

# Attendi che MySQL sia pronto
while ! mysqladmin ping -hlocalhost -P3306 --silent; do
    sleep 1
done

# Esegui il comando mysql per importare il file SQL
mysql --binary-mode -uroot -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/all-databases.sql

# Mantieni il servizio MySQL in esecuzione
wait $!