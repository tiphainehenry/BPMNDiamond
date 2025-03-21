const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName = "IncidentManagement"

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


        await workflowExecution.Invoke(12, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(0, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(1, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(14, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(2, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(15, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(4, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(16, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(5, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(6, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(17, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(7, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(19, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(8, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(18, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(3, "IncidentManagement", instanceTest, "Role", "", "")
        await workflowExecution.Invoke(13, "IncidentManagement", instanceTest, "Role", "", "")

        // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

        included = await getterFacet.getIncluded("IncidentManagement", instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})