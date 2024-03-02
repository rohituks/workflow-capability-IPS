#!/bin/bash

# wait-for-fhir-server.sh

# The URL to test
URL="$1"

# Optional: The time in seconds between retries
RETRY_INTERVAL=${2:-10}

# Optional: The number of retries before giving up
MAX_RETRIES=${3:-12}

echo "Waiting for fhir-server to be available at $URL"

# Function to check the server's health
check_server() {
    curl --silent --fail "$URL" > /dev/null
    return $?
}

# Initial attempt
attempt=1
until check_server
do
    if [ ${attempt} -ge ${MAX_RETRIES} ]; then
        echo "fhir-server not available at $URL, giving up after ${MAX_RETRIES} attempts."
        exit 1
    fi

    echo "fhir-server not available at $URL, retrying in ${RETRY_INTERVAL}s..."
    sleep ${RETRY_INTERVAL}
    attempt=$((attempt+1))
done

echo "fhir-server is up at $URL, proceeding with service startup."
