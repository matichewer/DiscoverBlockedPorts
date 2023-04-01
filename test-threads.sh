#!/bin/bash

ejecutar_curl() {
    START_PORT="$1"
    END_PORT=$((START_PORT+29))
    seq $START_PORT $END_PORT | 
    xargs -I {} -P 29 bash -c 'curl_output=$(curl --silent --connect-timeout "${TIMEOUT}" portquiz.net:{}); if [ $? -eq 0 ]; then echo "{}" >> archivo1.txt; else echo "{}" >> archivo2.txt; fi'
}

# Llama a la función con el puerto inicial que deseas utilizar
ejecutar_curl 80