#!/bin/bash

# Set file names
FILE_CURL_0="accessible-ports.txt"
FILE_CURL_28="blocked-ports.txt"
FILE_CURL_OTHERS_ERRORS="ports-with-other-problems.txt"

# Test parallel access to all ports between the 2 input variables
# Takes two arguments: start port and end port
test_ports() {
    START_PORT="$1"
    END_PORT="$2"
    CANT_PORTS=$((END_PORT - START_PORT + 1))
    i=0
    seq "$START_PORT" "$END_PORT" | 
    xargs -I {} -P ${CANT_PORTS} bash -c ' \
        PORT="$1" 
        START_PORT="$2"
        END_PORT="$3"
        FILE_CURL_0="$4"
        FILE_CURL_28="$5"
        FILE_CURL_OTHERS_ERRORS="$6"

        curl --silent --connect-timeout 3 portquiz.net:${PORT} > /dev/null
        CODE=$?
        if [ ${CODE} -eq 0 ]; then 
            echo ${PORT} >> ${FILE_CURL_0}
        elif [ ${CODE} -eq 28 ]; then 
            echo ${PORT} >> ${FILE_CURL_28}
        else
            echo ${PORT},${CODE} >> "${FILE_CURL_OTHERS_ERRORS}"
        fi \

        echo -ne "Testing port: ${PORT}\r"
        ' _ {} "${START_PORT}" "${END_PORT}" "${FILE_CURL_0}" "${FILE_CURL_28}" "${FILE_CURL_OTHERS_ERRORS}"
}

START_TIME=$(date +%s) # to calculate the time it will take to finish the script
test_ports 1 65535
wait # wait all curl threads
END_TIME=$(date +%s)
TIME_ELAPSED=$((END_TIME - START_TIME))
echo -e "\n\nAll ports tested! Time spent: ${TIME_ELAPSED} seconds\n"

if [ -f "$FILE_CURL_0" ];
then
    echo "Accessible ports saved in file ${FILE_CURL_0}"
    sort -n -o "$FILE_CURL_0" "$FILE_CURL_0"
fi

if [ -f "$FILE_CURL_28" ];
then
    echo "Blocked ports saved in file ${FILE_CURL_28}"
    sort -n -o "$FILE_CURL_28" "$FILE_CURL_28"
fi

if [ -f "$FILE_CURL_OTHERS_ERRORS" ];
then
    echo "Some ports could not be tested, which have been saved in ${FILE_CURL_OTHERS_ERRORS}"
    sort -n -o "$FILE_CURL_OTHERS_ERRORS" "$FILE_CURL_OTHERS_ERRORS"
fi
