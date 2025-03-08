#!/bin/bash

# Directory containing the JSON files
json_directory="./eval/bpmnJSON"

# Loop through each JSON file in the directory
for json_file in "$json_directory"/*.json; do
  if [ -f "$json_file" ]; then
    base_name=$(basename "$json_file" .json)
    echo "Running test for $base_name..."

    # Pass the JSON file path as an argument
    npx hardhat test ./eval/multiProcess/models_deployment.js "$json_file"

    # Rename the gas report and JSON output for each test
    mv ../data/gasReport.md "../data/MarkDown/gasReport_multimodel_${base_name}.md"
    mv ../data/gas.json "../data/Json/gasReport_multimodel_${base_name}.json"

    echo "Test for $base_name completed."
  else
    echo "No JSON files found in $json_directory."
  fi
done
