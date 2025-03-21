const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

async function getIncludedIndices(getterFacet, modelName, instanceTest) {
  // Fetch the included array and convert elements to numbers
  let included = await getterFacet.getIncluded(modelName, instanceTest);
  included = included.map(value => Number(value));
  console.log("Included array:", included);

  // Find indices where the value is 1
  const indices = included
      .map((value, index) => value === 1 ? index : -1) // Map to index if value is 1, otherwise -1
      .filter(index => index !== -1); // Filter out -1s

  console.log("Indices of ones:", indices);
  return indices;
}

let modelName = "CandidatureProcesssing"

describe('mesureGasDiamond'+modelName, async function () {
    let diamondAddress
    let workflowExecution 
    let getterFacet
    let ModelFactoryFacet
    let instanceTest
    before(async function () {

    diamondAddress = await deployDiamond()
    workflowExecution = await ethers.getContractAt('ExecLogicFacet', diamondAddress)
    getterFacet = await ethers.getContractAt('GettersFacet', diamondAddress)
    ModelFactoryFacet = await ethers.getContractAt('ModelFactoryFacet',diamondAddress)
    
    const modelFilePath = path.resolve(__dirname, '../../eval/bpmnJSON', `${modelName}.json`);
    const data = JSON.parse(fs.readFileSync(modelFilePath, 'utf-8'));
    const modelData = data["outputGen"]
    const { activities, _tabChildrenOptim, _tabParentOptim, _msgInOptim, _msgOutOptim, _keyReplay, _valueReplay } = modelData;
    
    await ModelFactoryFacet.addModel(modelName,activities,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
    let tx = await ModelFactoryFacet.newInstance(modelName)
    let receipt = await tx.wait()
    const events = receipt.events;
    const id = events.find(event => event.event === 'instanceId');
    console.log(Number(id.args._id))
    instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{
      await workflowExecution.Invoke(11, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(21, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(12, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(0, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(22, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(0, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(41, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(42, modelName, instanceTest, "Admission office", "", "");

      await workflowExecution.Invoke(48, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(49, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(14, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(23, modelName, instanceTest, "Student", "", "");

      // await processus.Invoke(11, "Student", "", "");
      // await processus.Invoke(21, "Student", "", "");
      // await processus.Invoke(12, "Admission office", "", "");
      // await processus.Invoke(0, "Admission office", "", "");
      // await processus.Invoke(22, "Student", "", "");
      // await processus.Invoke(0, "Admission office", "", "");
      // await processus.Invoke(41, "Admission office", "", "");
      // await processus.Invoke(42, "Admission office", "", "");


      getIncludedIndices(getterFacet, modelName, instanceTest) 


      included = await getterFacet.getIncluded("CandidatureProcesssing",instanceTest)
      included = included.map(value => Number(value));
      console.log(included)
    })
})