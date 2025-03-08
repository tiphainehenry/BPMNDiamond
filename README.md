This repository contains the evaluation material for the paper "Leveraging the Diamond Standard for Scalable and Upgradeable Blockchain-Based Business Process Management Applications" 
* The diamond code is stored in the hardhat/ repository. 
* BPMNs and raw gas reports are stored in the data/ repository. 
* reports/ contains the source files to generate the figures. 

# Running experiments

To run the experiments, follow these steps:

1. Change to the `hardhat/` directory, install required dependencies and launch the test script.

   ```
   cd hardhat/
   npm install 
   sh launchExperiments.sh
   ```

Available test scripts are defined in test/bpmnScenarios.  
Select BPMN scenarios to be executed directly in launchExperiments.sh by updating the variable "scenario_names" accordingly. Gas reports will be saved in the `~/data/` directory.

# Processing the results
To process the results and generate plots and dataframes, follow these steps:
1. Change to the `reports` directory and install python dependencies. Then run the main script:
   ```
   cd processResults
   pip install -r requirements.txt
   python src/main.py
   ```

The generated plots will be saved in the `reports/plots/` directory, and the dataframes will be saved in the `~/data/` directory.

The setup for the reports (eg data input/ output paths and selected BPMNs) is set in reports_config.json
