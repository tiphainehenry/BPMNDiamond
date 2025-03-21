const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName = "SPARKLogistics"

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


describe('mesureGasDiamond' + modelName, async function () {
  let diamondAddress
  let workflowExecution
  let getterFacet
  let ModelFactoryFacet
  let instanceTest
  before(async function () {

    diamondAddress = await deployDiamond()
    workflowExecution = await ethers.getContractAt('ExecLogicFacet', diamondAddress)
    getterFacet = await ethers.getContractAt('GettersFacet', diamondAddress)
    ModelFactoryFacet = await ethers.getContractAt('ModelFactoryFacet', diamondAddress)
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
    instanceTest = Number(id.args._id)

  })
  it('mesure de Gas avec Abi facet entiere', async () => {

    await workflowExecution.Invoke(17, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(3, modelName, instanceTest, "SPARKS", "", "")
    await workflowExecution.Invoke(4, modelName, instanceTest, "SPARKS", "", "")
    await workflowExecution.Invoke(52, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(62, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(63, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(6, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(5, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(22, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(49, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(0, modelName, instanceTest, "Customer", "", "")
    await workflowExecution.Invoke(49, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(59, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(60, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(21, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(12, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(54, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(64, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(65, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(24, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(51, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(2, modelName, instanceTest, "Customer", "", "")
    await workflowExecution.Invoke(61, modelName, instanceTest, "Customer", "", "");
    await workflowExecution.Invoke(11, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(10, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(44, modelName, instanceTest, "SPARKS", "", "");
    await workflowExecution.Invoke(48, modelName, instanceTest, "External garage", "", "");

    getIncludedIndices(getterFacet, modelName, instanceTest)

  })
})