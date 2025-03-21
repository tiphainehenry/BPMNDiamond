const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');


let modelName = "SeadmeteGarantii"
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

    await workflowExecution.Invoke(21, modelName, instanceTest, "Laojuhataja", "", "");
    await workflowExecution.Invoke(22, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(23, modelName, instanceTest, "Assistent", "", "");
    await workflowExecution.Invoke(5, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(17, modelName, instanceTest, "Assistent", "", "");
    await workflowExecution.Invoke(11, modelName, instanceTest, "Remonditehnik", "", "");
    await workflowExecution.Invoke(26, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(0, modelName, instanceTest, "Laojuhataja", "", "");
    await workflowExecution.Invoke(29, modelName, instanceTest, "Remonditehnik", "", "");
    await workflowExecution.Invoke(32, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(33, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(4, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(27, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(35, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(36, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(16, modelName, instanceTest, "Muugijuht", "", "");
    await workflowExecution.Invoke(6, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(1, modelName, instanceTest, "Laojuhataja", "", "");
    await workflowExecution.Invoke(7, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(19, modelName, instanceTest, "Tootja remondikeskus", "", "");
    await workflowExecution.Invoke(20, modelName, instanceTest, "Tootja remondikeskus", "", "");
    await workflowExecution.Invoke(3, modelName, instanceTest, "Laojuhataja", "", "");
    await workflowExecution.Invoke(9, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(8, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(28, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(31, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(34, modelName, instanceTest, "Tookoja juhataja", "", "");
    await workflowExecution.Invoke(24, modelName, instanceTest, "Laojuhataja", "", "");
    await workflowExecution.Invoke(24, modelName, instanceTest, "Laojuhataja", "", "");
    // getIncludedIndices(getterFacet, modelName, instanceTest)

  })
})