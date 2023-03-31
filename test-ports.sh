#!/bin/bash

# Set timeout for testing each port
TIMEOUT=5

# Loop through all ports
for PORT in {1..65535}; do
    
    # Set flag variable to control the loop
    FLAG=true    
    while ${FLAG}; do
        
        # Try to connect to the current port
        OUTPUT=$(curl --silent --connect-timeout "${TIMEOUT}" portquiz.net:"${PORT}")
        CODE=$?
        
        if [ ${CODE} -eq 7 ]; then
            echo "cURL Code: ${CODE}. Port: ${PORT}. Wait 1 min..."
            sleep 1m
        else
            # Set flag variable to false to exit the loop
            FLAG=false
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
