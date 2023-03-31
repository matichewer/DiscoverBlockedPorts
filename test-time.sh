#!/bin/bash

CANT_DE_PUERTOS=0

while true; do
    
    curl --silent --connect-timeout 5 --output /dev/null portquiz.net:80
    CODE=$?
    
    if [[ ${CODE} -eq 0 ]]; then
        CANT_DE_PUERTOS=$((CANT_DE_PUERTOS + 1))
    elif [[ ${CODE} -eq 7 ]]; then
        START_TIME=$(date +%s)  # obtener la hora actual en segundos
        date
        echo "Cantidad de puertos escaneados hasta que me dieron ban: ${CANT_DE_PUERTOS}"

        while true; do    
            curl --silent --connect-timeout 3 portquiz.net:80
            CODE=$?

            if [[ ${CODE} -eq 0 ]]; then
                END_TIME=$(date +%s)    # obtener la hora actual en segundos
                TIME_ELAPSED=$((END_TIME - START_TIME))  # calcular el tiempo transcurrido
                echo "Tiempo que tardaron en desbanearme ${TIME_ELAPSED}"
                exit
            fi
        done
    else
        echo "Error no capturado. Code error: ${CODE}"
    fi    
done
