const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName = "Procurement"

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


        await workflowExecution.Invoke(6,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(0,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(1,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(9,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(5,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(10,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(3,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(4,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(11,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(2,modelName,instanceTest,"Buyer","","")
        await workflowExecution.Invoke(7,modelName,instanceTest,"Buyer","","")

        included = await getterFacet.getIncluded(modelName,instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})