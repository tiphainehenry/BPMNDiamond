const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName = "SecuRoutiere"
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


    await workflowExecution.Invoke(14, modelName, instanceTest, "CRIRC", "", "")
    // XOR        
    await workflowExecution.Invoke(22, modelName, instanceTest, "CRIRC", "", "")
    // Centraliser
    await workflowExecution.Invoke(2, modelName, instanceTest, "CRIRC", "", "")
    // Receptionner communiques
    await workflowExecution.Invoke(1, modelName, instanceTest, "CRIRC", "", "")
    // XOR        
    await workflowExecution.Invoke(23, modelName, instanceTest, "CRIRC", "", "")
    // Analyser situation 
    await workflowExecution.Invoke(0, modelName, instanceTest, "CRIRC", "", "")
    // XOR 
    await workflowExecution.Invoke(24, modelName, instanceTest, "CRIRC", "", "")
    // Renseigner
    await workflowExecution.Invoke(4, modelName, instanceTest, "CRIRC", "", "")
    // envoyer
    await workflowExecution.Invoke(3, modelName, instanceTest, "CRIRC", "", "")
    // informer
    await workflowExecution.Invoke(5, modelName, instanceTest, "CRIRC", "", "")
    // informerCellules
    await workflowExecution.Invoke(6, modelName, instanceTest, "CRIRC", "", "")
    // xor
    await workflowExecution.Invoke(25, modelName, instanceTest, "CRIRC", "", "")
    // end
    await workflowExecution.Invoke(18, modelName, instanceTest, "CRIRC", "", "")

    //// EMZDCOZ //// 
    // receive
    await workflowExecution.Invoke(17, modelName, instanceTest, "EMIZDCOZ", "", "")
    // receptionner
    await workflowExecution.Invoke(13, modelName, instanceTest, "EMIZDCOZ", "", "")
    // end
    await workflowExecution.Invoke(21, modelName, instanceTest, "EMIZDCOZ", "", "")

    //// cellule comm //// 
    // receive
    await workflowExecution.Invoke(15, modelName, instanceTest, "CelluleComPref35", "", "")
    // receotuinner
    await workflowExecution.Invoke(7, modelName, instanceTest, "CelluleComPref35", "", "")
    // xor 
    await workflowExecution.Invoke(26, modelName, instanceTest, "CelluleComPref35", "", "")
    // rediger comm 
    await workflowExecution.Invoke(8, modelName, instanceTest, "CelluleComPref35", "", "")
    //receptionner comm 
    await workflowExecution.Invoke(9, modelName, instanceTest, "CelluleComPref35", "", "")
    // xor 
    await workflowExecution.Invoke(27, modelName, instanceTest, "CelluleComPref35", "", "")
    // publier
    await workflowExecution.Invoke(10, modelName, instanceTest, "CelluleComPref35", "", "")
    // end
    await workflowExecution.Invoke(19, modelName, instanceTest, "CelluleComPref35", "", "")


    //// prefet zone //// 
    // receive
    await workflowExecution.Invoke(16, modelName, instanceTest, "PrefetZone", "", "")
    // receptionner comm
    await workflowExecution.Invoke(11, modelName, instanceTest, "PrefetZone", "", "")
    // valider comm 
    await workflowExecution.Invoke(12, modelName, instanceTest, "PrefetZone", "", "")
    // end
    await workflowExecution.Invoke(20, modelName, instanceTest, "PrefetZone", "", "")


    // await workflowExecution.Invoke(12,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(0,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(1,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(14,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(2,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(15,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(4,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(16,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(5,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(6,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(17,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(7,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(19,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(8,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(18,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(3,modelName,instanceTest,"Role","","")
    // await workflowExecution.Invoke(13,modelName,instanceTest,"Role","","")

    // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
    // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
    // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
    // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
    // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

    included = await getterFacet.getIncluded(modelName, instanceTest)
    included = included.map(value => Number(value));
    console.log(included)
  })
})