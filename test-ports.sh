#!/bin/bash

# Set timeout for testing each port
TIMEOUT=3
TIME_SLEEP=11

# Loop through all ports
for PORT in {1..65535}; do
    
    # FLAG is false when we connect to PORT with no errors
    FLAG=true    
    while ${FLAG}; do
        
        # Try to connect to the current port
        echo "curl --silent --connect-timeout ${TIMEOUT} portquiz.net:${PORT}"
        OUTPUT=$(curl --silent --connect-timeout "${TIMEOUT}" portquiz.net:"${PORT}")
        CODE=$?
        echo "cURL Code: ${CODE}. Port: ${PORT}"

        if [[ ${CODE} -eq 7 ]]; then
            echo "cURL Code: ${CODE}. Port: ${PORT}. Wait 1 min..."
            sleep ${TIME_SLEEP}
        elif [[ ${CODE} -eq 0 ]]; then
            # Set flag variable to false to exit the loop
            FLAG=false
        elif [[ ${CODE} -eq 28 ]]; then
            FLAG=false
            echo "cURL Code: ${CODE}. Port: ${PORT}. Next..."
        fi
        
    done
    
    # Check if the connection was successful by searching for a specific string in the output
    # If the string is not found, the port is considered bad and is added to "bad-ports.txt"
    # Otherwise, the port is considered good and is added to "good-ports.txt"
    if ! echo "${OUTPUT}" | grep -q "Port test successful!"; then
        echo "${PORT}" >> bad-ports.txt
    else
        echo "${PORT}" >> good-ports.txt
    fi
    
done
