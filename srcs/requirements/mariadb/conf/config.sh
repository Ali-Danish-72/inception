#! /usr/bin/env bash

mariadb -u root -e "create database $DB_NAME;
alter user 'root'@'localhost' identified by '$DB_ROOT_PASS';
grant all on $DB_NAME.* to '$DB_USER'@'%' identified by '$DB_PASS';
flush privileges;"
