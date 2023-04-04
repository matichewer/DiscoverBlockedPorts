#!/bin/bash

START_TIME=$(date +%s)  # obtener la hora actual en segundos

ejecutar_curl() {
    START_PORT="$1"
    END_PORT="$2" # Se cambia el límite superior del rango
    CANT_PORTS=$((END_PORT - START_PORT + 1))
    seq $START_PORT $END_PORT | 
    xargs -I {} -P ${CANT_PORTS} bash -c \
        'PORT=$1;
        curl_output=$(curl --silent --connect-timeout 3 portquiz.net:${PORT});
        CODE=$?; 
        #echo "${PORT},${CODE}"; 
        if [ ${CODE} -eq 0 ]; then 
            echo "${PORT}" >> ports-curl-code-0.txt; 
        elif [ ${CODE} -eq 28 ]; then 
            echo "${PORT}" >> ports-curl-code-28.txt;
        elif [ ${CODE} -eq 7 ]; then 
            echo "${PORT}" >> ports-curl-code-7.txt; 
        else
            echo "${PORT},${CODE}" >> ports-curl-code-others.txt;
        fi; \
        ' _ {}
}

# Llama a la función con el puerto inicial que deseas utilizar
ejecutar_curl 1 65535

wait
END_TIME=$(date +%s)    # obtener la hora actual en segundos
TIME_ELAPSED=$((END_TIME - START_TIME))  # calcular el tiempo transcurrido
echo "Tiempo en testear 65535 puertos: ${TIME_ELAPSED} segundos"
                
echo
echo "Ordenando archivos..."
[ -f "ports-curl-code-0.txt" ] && sort -n -o ports-curl-code-0.txt ports-curl-code-0.txt
[ -f "ports-curl-code-28.txt" ] && sort -n -o ports-curl-code-28.txt ports-curl-code-28.txt
[ -f "ports-curl-code-7.txt" ] && sort -n -o ports-curl-code-7.txt ports-curl-code-7.txt
[ -f "ports-curl-code-others.txt" ] && sort -n -o ports-curl-code-others.txt ports-curl-code-others.txt
