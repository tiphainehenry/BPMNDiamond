#!/bin/bash

# Array of scenario names
scenario_names=('BulkBuyer.json' 'CandidatureProcessing.json' 'Certification.json' 'Circee.json' 'LCA.json' 'OrderToCashV1.json' 'SeadmeteGarantii.json' 'SecuRoutiere.json' 'SPARKLogistics.json' 'Zad2Kolab.json')

# Function to run a script with a given name
run_script() {
    local script_name=$1
    local script_path="$(pwd)/eval/GasMultiProcess.sh"

    # Check if the script exists and is executable before running it
    if [ -x "$script_path" ]; then
        echo "Running script: $script_name"
        "$script_path" "$script_name"
    else
        echo "Error: $script_path not found or not executable"
        exit 1
    fi
}

# Iterate over each scenario name in the array
for scenario in "${scenario_names[@]}"; do
    run_script "$scenario"
done
