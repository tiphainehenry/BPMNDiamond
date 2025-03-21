const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName= "Circee"

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

      await workflowExecution.Invoke(15,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(16,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(17,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(18,modelName,instanceTest,"BEP","","")
      await workflowExecution.Invoke(19,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(0,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(10,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(12,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(35,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(27,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(37,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(5,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(20,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(21,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(29,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(34,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(6,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(13,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(32,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(38,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(13,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(31,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(28,modelName,instanceTest,"EDF","","")

    })


    it('Measure Gas for Replace Operation', async () => {
      const replacedActivity = [
          {
              id: 1, // The activity being replaced
              nodeType: 0,
              xmlID: "Activity_1mrdk79",
              name: "Replaced Activity",
              lane: "Supplier",
              dataIn: "OrderDetails",
              dataOut: "ProductionDetails",
              timestamp: "2025-03-19T00:00:00Z"
          }
      ];
      
      const newChildrenOptimReplace = [["Activity_178wke6"]];
      const newParentsOptimReplace = [["Activity_1mrdk79"]];
      const newMsgInOptimReplace = [["Event_1jqivmy"]];
      const newMsgOutOptimReplace = [["Event_0nt2tgj"]];
      
      const txReplace = await ModelFactoryFacet.updateModel(
        modelName,
        "replace",
        0,
        replacedActivity,
        newChildrenOptimReplace,
        newParentsOptimReplace,
        newMsgInOptimReplace,
        newMsgOutOptimReplace
      );
      
      const receiptReplace = await txReplace.wait();
      console.log("Gas used for Replace Operation: ", receiptReplace.gasUsed.toString());
  });

    it('Measure Gas for Add Operation', async () => {
        const newActivitiesAdd = [
            {
                id: 2,
                nodeType: 0,
                xmlID: "Activity_2xvntj8",
                name: "New Activity Added",
                lane: "Manufacturer",
                dataIn: "OrderConfirmation",
                dataOut: "ProductionDetails",
                timestamp: "2025-03-20T00:00:00Z"
            }
        ];
        const newChildrenOptimAdd = [["Activity_178wke6"]];
        const newParentsOptimAdd = [["Activity_2xvntj8"]];
        const newMsgInOptimAdd = [["Event_1jqivmy"]];
        const newMsgOutOptimAdd = [["Event_0nt2tgj"]];
        
        const txAdd = await ModelFactoryFacet.updateModel(
          modelName,
          "add",
          0,
          newActivitiesAdd,
          newChildrenOptimAdd,
          newParentsOptimAdd,
          newMsgInOptimAdd,
          newMsgOutOptimAdd
        );
        
        const receiptAdd = await txAdd.wait();
        console.log("Gas used for Add Operation: ", receiptAdd.gasUsed.toString());
    });

    it('Measure Gas for Remove Operation (Deactivate)', async () => {
        
        // Simulate deactivation or removal of an activity (e.g., clearing dependencies)
        const txRemove = await ModelFactoryFacet.updateModel(
            modelName,
            "remove", 
            0,
            [], // No new activities
            [], // No new children
            [], // No new parents
            [], // No new msgIn
            []  // No new msgOut
        );
        
        const receiptRemove = await txRemove.wait();
        console.log("Gas used for Remove Operation (Deactivate): ", receiptRemove.gasUsed.toString());
    });


})