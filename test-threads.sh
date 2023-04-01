#!/bin/bash

rm archivo*

ejecutar_curl() {
    START_PORT="$1"
    END_PORT=$((START_PORT+28)) # Se cambia el límite superior del rango
    seq $START_PORT $END_PORT | xargs -I {} -P 29 bash -c 'port=$1; curl_output=$(curl --silent --connect-timeout 3 portquiz.net:$port); if [ $? -eq 0 ]; then echo $port >> archivo1.txt; else echo "$?,${port}" >> archivo2.txt; fi' _
}

# Llama a la función con el puerto inicial que deseas utilizar
ejecutar_curl 80

wait
sort -n -o archivo1.txt archivo1.txt
sort -n -o archivo2.txt archivo2.txt
