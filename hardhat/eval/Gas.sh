#!/bin/bash

# Vérifiez si le nom du test est fourni en argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <test_name>"
  exit 1
fi

# Nom du test
test_name=$1

# Lancez le test
npx hardhat test ./eval/bpmnScenarios/$test_name.js #--network localhost

# Renommez le fichier contenant le rapport de gaz
mv ../data/gasReport.md ../data/MarkDown/gasReport_$test_name.md
mv ../data/gas.json ../data/Json/gasReport_$test_name.json

