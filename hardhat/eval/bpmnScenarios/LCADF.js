const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName= "LCA"
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
    instanceTest =Number(id.args._id)
    })
    it('mesure de Gas avec Abi facet entiere', async () =>{ 

        await workflowExecution.Invoke(7,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(0,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(9,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(8,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(19,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(11,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(12,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(10,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(0,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(9,modelName,instanceTest,"LCA expert","","")


        included = await getterFacet.getIncluded(modelName,instanceTest)
        included = included.map(value => Number(value));
        console.log(included)

    })
})