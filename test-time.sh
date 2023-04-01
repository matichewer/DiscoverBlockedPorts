#!/bin/bash

echo "Comenzando spam de chequeo de puertos..."

CANT_DE_PUERTOS=0
TIEMPO=9

while true; do
    
    curl --silent --connect-timeout 5 --output /dev/null portquiz.net:80
    CODE=$?
    
    if [[ ${CODE} -eq 0 ]]; then
        CANT_DE_PUERTOS=$((CANT_DE_PUERTOS + 1))
    elif [[ ${CODE} -eq 7 ]]; then
        START_TIME=$(date +%s)  # obtener la hora actual en segundos
        echo "Baneado! Cantidad de puertos escaneados: ${CANT_DE_PUERTOS}"
        echo

        while true; do    
            echo "CURL error code: ${CODE}. Sleep ${TIEMPO} seconds and retry..."
            echo
            sleep "${TIEMPO}"

            echo "Retry connection..."
            curl --silent --connect-timeout 2 --output /dev/null portquiz.net:3000
            CODE=$?
    
            if [[ ${CODE} -eq 0 ]]; then
                END_TIME=$(date +%s)    # obtener la hora actual en segundos
                TIME_ELAPSED=$((END_TIME - START_TIME))  # calcular el tiempo transcurrido
                echo "Desbaneado! Tiempo que tardaron en desbanearme: ${TIME_ELAPSED} segundos"
                exit
            fi
        done
    else
        echo "Error no capturado. Code error: ${CODE}"
    fi    
done
