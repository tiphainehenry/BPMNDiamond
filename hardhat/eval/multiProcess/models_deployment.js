const { deployDiamond } = require('../../scripts/deployDiamondFactory.js');
const fs = require('fs');
const path = require('path');

describe('Measure Models Deployment', function () {
    let diamondAddress;
    let workflowExecution;
    let getterFacet;
    let ModelFactoryFacet;
    let instanceTest;

    console.log("HEEERE1");

    before(async function () {

        // Retrieve the JSON file path from process arguments
        const jsonFilePath = process.argv[process.argv.length - 1];
        if (!jsonFilePath || !jsonFilePath.endsWith('.json')) {
            throw new Error('Valid JSON file path is required');
        }

        // Read and parse JSON data
        const jsonData = await readJsonFile(jsonFilePath);
        let modelName = path.basename(jsonFilePath, '.json');

        //////////// DEPLOY CORE DIAMOND ////////////////
        diamondAddress = await deployDiamond();
        workflowExecution = await ethers.getContractAt('ExecLogicFacet', diamondAddress);
        getterFacet = await ethers.getContractAt('GettersFacet', diamondAddress);
        ModelFactoryFacet = await ethers.getContractAt('ModelFactoryFacet', diamondAddress);

        console.log("Diamond deployed at:", diamondAddress);

        //////////// DEPLOY MODELS SEQUENTIALLY ////////////////
        const activities = jsonData["outputGen"]['activities'];
        const _tabChildrenOptim = jsonData["outputGen"]['_tabChildrenOptim'];
        const _tabParentOptim = jsonData["outputGen"]['_tabParentOptim'];
        const _msgInOptim = jsonData["outputGen"]['_msgInOptim'];
        const _msgOutOptim = jsonData["outputGen"]['_msgOutOptim'];
        const _keyReplay = [];
        const _valueReplay = [[]];

        // Execute the model deployment 10 times
        for (let i = 0; i < 10; i++) {
            console.log(`Deploying model ${modelName} - Iteration ${i + 1}`);
            const tx = await ModelFactoryFacet.addModel(
                `${modelName}_iteration_${i + 1}`, // Optionally append iteration to the model name
                activities,
                _tabChildrenOptim,
                _tabParentOptim,
                _msgInOptim,
                _msgOutOptim,
                _keyReplay,
                _valueReplay
            );
            console.log(`Model deployment ${i + 1} completed`);
        }

    });

    it('should have run before hook', function () {
        console.log('Test executed: verification of before hook.');
    });
});

/**
 * Reads a JSON file and returns the parsed data.
 * @param {string} filePath - The path to the JSON file.
 * @returns {Promise<Object>} - A promise that resolves to the parsed JSON data.
 */
function readJsonFile(filePath) {
    return new Promise((resolve, reject) => {
        fs.readFile(filePath, 'utf8', (err, data) => {
            if (err) {
                console.error('Error reading the file:', err);
                return reject(err);
            }
            try {
                const jsonData = JSON.parse(data);
                resolve(jsonData);
            } catch (parseErr) {
                console.error('Error parsing JSON:', parseErr);
                reject(parseErr);
            }
        });
    });
}
