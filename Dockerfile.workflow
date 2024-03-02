# Dockerfile.workflow
FROM openjdk:17
WORKDIR /app

# Copy the wait-for-fhir-server.sh script and make it executable
COPY wait-for-fhir-server.sh /wait-for-fhir-server.sh
RUN chmod +x /wait-for-fhir-server.sh

# Copy the workflow capability core JAR
COPY ./workflow_capability_core/target/workflow_capability_core-0.0.2-SNAPSHOT.jar /app/

# Use the script to wait for the fhir-server and then start the workflow capability core
CMD /wait-for-fhir-server.sh http://fhir-server:8080/fhir/metadata && \
    if [ "$SERVE_DEMOS" = 'y' ]; then \
        java -jar workflow_capability_core-0.0.2-SNAPSHOT.jar withAllDemos | awk '{print "[WFC] "$0}'; \
    else \
        java -jar workflow_capability_core-0.0.2-SNAPSHOT.jar | awk '{print "[WFC] "$0}'; \
    fi
