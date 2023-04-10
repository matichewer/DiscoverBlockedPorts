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
    seq "$START_PORT" "$END_PORT" | 
    xargs -I {} -P "${CANT_PORTS}" bash -c ' \
        PORT="$1";
        curl --silent --connect-timeout 3 portquiz.net:${PORT}
        CODE=$?; 
        i=0
        if [ ${CODE} -eq 0 ]; then 
            echo "${PORT}" >> "$FILE_CURL_0"; 
        elif [ ${CODE} -eq 28 ]; then 
            echo "${PORT}" >> "$FILE_CURL_28";
        else
            echo "${PORT},${CODE}" >> "$FILE_CURL_OTHERS_ERRORS";
        fi; \

        # Calculate and show the porcentage
        i=$((i+1));
        percentage=$((100*i/CANT_PORTS));
        echo -ne "Progress: ${percentage}%\r"; \
        ' _ {}
}

START_TIME=$(date +%s) # to calculate the time it will take to finish the script
test_ports 1 65535
wait # wait all curl threads
END_TIME=$(date +%s)
TIME_ELAPSED=$((END_TIME - START_TIME))
echo -e "\nTime to test 65535 ports: ${TIME_ELAPSED} seconds\n"

if [ -f "$FILE_CURL_0" ]; then
    echo "Accessible ports saved in file ${FILE_CURL_0}"
    sort -n -o "$FILE_CURL_0" "$FILE_CURL_0"
elif [ -f "$FILE_CURL_28" ]; then
    echo "Blocked ports saved in file ${FILE_CURL_28}"
    sort -n -o "$FILE_CURL_28" "$FILE_CURL_28"
elif [ -f "$FILE_CURL_OTHERS_ERRORS" ]; then
    echo "Some ports could not be tested, which have been saved in ${FILE_CURL_OTHERS_ERRORS}"
    sort -n -o "$FILE_CURL_OTHERS_ERRORS" "$FILE_CURL_OTHERS_ERRORS"
fi
