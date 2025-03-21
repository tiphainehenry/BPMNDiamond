const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')
const fs = require('fs')
const path = require('path');

let modelName= "ScanConsortium"
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
        let included = await getterFacet.getIncluded("ModelSizeExpe_100",instanceTest)
        let executed = await getterFacet.getExecuted("ModelSizeExpe_100",instanceTest)
        let pending = await getterFacet.getPending("ModelSizeExpe_100",instanceTest)
        included = included.map(value => Number(value));
        executed = executed.map(value => Number(value));
        pending = pending.map(value => Number(value));

        // // await workflowExecution.Invoke(8,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")
        // // await workflowExecution.Invoke(14,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")
        // // await workflowExecution.Invoke(20,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")
        // // await workflowExecution.Invoke(19,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")
        // // await workflowExecution.Invoke(25,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")

        // ////// Manufacturer /////
        // // orderfromBulkB
        // await workflowExecution.Invoke(6,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // //cakculate demand
        // await workflowExecution.Invoke(3,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // // place order
        // await workflowExecution.Invoke(12,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // // receive order
        // await workflowExecution.Invoke(16,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // //reportstart
        // await workflowExecution.Invoke(11,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // //produce
        // await workflowExecution.Invoke(2,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // // msg end
        // await workflowExecution.Invoke(23,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")

        // //////// Middleman/////
        // // order form manu
        // await workflowExecution.Invoke(5,"ModelSizeExpe_100",instanceTest,"Middleman","","")
        // // fwdorder
        // await workflowExecution.Invoke(10,"ModelSizeExpe_100",instanceTest,"Middleman","","")
        // // ordertransport
        // await workflowExecution.Invoke(22,"ModelSizeExpe_100",instanceTest,"Middleman","","")


        // //////// Special Carrier/////
        // // order transport
        // await workflowExecution.Invoke(7,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // // request
        // await workflowExecution.Invoke(13,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // // receivedetail
        // await workflowExecution.Invoke(17,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // //receivewayb
        // await workflowExecution.Invoke(18,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // // deliver order
        // await workflowExecution.Invoke(24,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")

        // //////// Supplier/////
        // // order suply
        // await workflowExecution.Invoke(4,"ModelSizeExpe_100",instanceTest,"Supplier","","")
        // // produce
        // await workflowExecution.Invoke(1,"ModelSizeExpe_100",instanceTest,"Supplier","","")
        // // prepare transport
        // await workflowExecution.Invoke(0,"ModelSizeExpe_100",instanceTest,"Supplier","","")
        // // receive req
        // await workflowExecution.Invoke(15,"ModelSizeExpe_100",instanceTest,"Supplier","","")
        // // provide details
        // await workflowExecution.Invoke(9,"ModelSizeExpe_100",instanceTest,"Supplier","","")
        // await workflowExecution.Invoke(21,"ModelSizeExpe_100",instanceTest,"Supplier","","")        
        // await workflowExecution.Invoke(18,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // await workflowExecution.Invoke(24,"ModelSizeExpe_100",instanceTest,"SpecialCarrier","","")
        // await workflowExecution.Invoke(11,"ModelSizeExpe_100",instanceTest,"Manufactturer","","")
        // await workflowExecution.Invoke(19,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")
        // await workflowExecution.Invoke(25,"ModelSizeExpe_100",instanceTest,"ModelSizeExpe_100","","")

        included = await getterFacet.getIncluded("ModelSizeExpe_100",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)

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