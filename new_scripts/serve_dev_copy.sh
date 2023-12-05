#!/bin/bash
# Ask if demos should be served

echo "-- STARTING CAMUNDA --"
cd ..
bash -eo pipefail -c "java -jar engine/camunda/target/camunda_engine-0.0.2-SNAPSHOT.jar | awk '{print \"[CAM] \"\$0}'" &
cd new_scripts

echo "-- STARTING CAREGIVER APP --"
cd ..
bash -eo pipefail -c "python3 caregiver_application/main.py | awk '{print \"[CGA] \"\$0}'" &
cd new_scripts

# echo "-- STARTING MANAGEMENT DASHBOARD --"
# cd ..
# cd management_dashboard
# npm run start &
# cd ..
# cd new_scripts

sleep 10

echo "-- STARTING WFC --"
cd ..
if [ "$SERVE_DEMOS" == "y" ]; then
  bash -eo pipefail -c "java -jar workflow_capability_core/target/workflow_capability_core-0.0.2-SNAPSHOT.jar withAllDemos | awk '{print \"[WFC] \"\$0}'" &
else
  bash -eo pipefail -c "java -jar workflow_capability_core/target/workflow_capability_core-0.0.2-SNAPSHOT.jar | awk '{print \"[WFC] \"\$0}'" &
fi
cd new_scripts

read -n 1 -s -r -p "Press any key to continue..."