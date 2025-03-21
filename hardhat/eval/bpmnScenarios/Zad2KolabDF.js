const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName = "Zad2Kolab"

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


    await ModelFactoryFacet.addModel(modelName, activities, _tabChildrenOptim, _tabParentOptim, _msgInOptim, _msgOutOptim, _keyReplay, _valueReplay)
    let tx = await ModelFactoryFacet.newInstance(modelName)
    let receipt = await tx.wait()
    const events = receipt.events;
    const id = events.find(event => event.event === 'instanceId');
    console.log(Number(id.args._id))
    instanceTest = Number(id.args._id)

  })
  it('mesure de Gas avec Abi facet entiere', async () => {

    await workflowExecution.Invoke(11, modelName, instanceTest, "Student", "", "");
    await workflowExecution.Invoke(12, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(13, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(14, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
    await workflowExecution.Invoke(8, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(10, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
    await workflowExecution.Invoke(44, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(3, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(4, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(36, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
    await workflowExecution.Invoke(42, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(9, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(34, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(35, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(43, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(2, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(21, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(22, modelName, instanceTest, "Menadzer", "", "");
    await workflowExecution.Invoke(32, modelName, instanceTest, "Student", "", "");
    await workflowExecution.Invoke(38, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(5, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(17, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(39, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(7, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(18, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(40, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(19, modelName, instanceTest, "Sluzbenik", "", "");
    await workflowExecution.Invoke(15, modelName, instanceTest, "Student", "", "");

    getIncludedIndices(getterFacet, modelName, instanceTest)


    included = await getterFacet.getIncluded(modelName, instanceTest)
    included = included.map(value => Number(value));
    console.log(included)
  })
})