#!/bin/bash

#scenario_names=('SeadmeteGarantii' 'Zad2Kolab' 'SPARKLogistics' 'BulkBuyer' 'IncidentManagement' 'Pizza' 'Procurement' 'OrderToCashV1' 'Certification' 'Circee' 'LCA' 'SecuRoutiere' 'CandidatureProcessing')
scenario_names=('ScanConsortium' )

#suffixes=('DF' 'Mono')
suffixes=('DF')

# function running a script with a given name
run_script() {
    local script_name=$1
    local script_path="$(pwd)/eval/Gas.sh"

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
for scenario in "${scenario_names[@]}"
do
    for suffix in "${suffixes[@]}"
    do
        script_name="${scenario}${suffix}"
        run_script "$script_name"
    done
done

