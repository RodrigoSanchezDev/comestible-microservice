#!/bin/zsh
# Script para arrancar el microservicio con Oracle Wallet

export TNS_ADMIN="$(pwd)/wallet"
export DB_USER=ADMIN
export DB_PASS='$Itsanewday30'

./mvnw spring-boot:run
