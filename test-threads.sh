#!/bin/bash

rm arch*

ejecutar_curl() {
    START_PORT="$1"
    END_PORT=$((START_PORT+4)) # Se cambia el límite superior del rango
    seq $START_PORT $END_PORT | xargs -I {} -P 5 bash -c 'port=$1; curl_output=$(curl --silent --connect-timeout 3 portquiz.net:${port}); CODE=$?; echo "${CODE},${port}"; if [ ${CODE} -eq 0 ]; then echo ${port} >> archivo1.txt; else echo "$?,$port" >> archivo2.txt; fi' _ {}
}

# Llama a la función con el puerto inicial que deseas utilizar
ejecutar_curl 80
echo
ejecutar_curl 85
echo
ejecutar_curl 90
echo
ejecutar_curl 95
echo
ejecutar_curl 100
echo
ejecutar_curl 105


wait
sort -n -o archivo1.txt archivo1.txt
sort -n -o archivo2.txt archivo2.txt
