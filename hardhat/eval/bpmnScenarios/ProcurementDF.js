const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')




describe('mesureGasDiamondProcurement', async function () {
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
    const activity = [
        //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
   {
    id:0,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1fe8pzt", // XML ID 
        name:"HandleQuotations", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
   {
    id:1,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_05ueiw1", // XML ID 
        name:"ApprooveOrder", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
   {
    id:2,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0xl1d3e", // XML ID 
        name:"ReviewOrder", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
   {
    id:3,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0t6mu1f", // XML ID 
        name:"HandleOrder", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
   {
    id:4,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0n8vr3k", // XML ID 
        name:"HandleShipment", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
   {
    id:5,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_028pcds", // XML ID 
        name:"Tpr", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
   {
    id:6,  //activity id
        nodeType:0, // activity type 
        xmlID:"StartEvent_1", // XML ID 
        name:"Start", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
   {
    id:7,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_0oltqoi", // XML ID 
        name:"EndFinal", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
   {
        id:8,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_1y57ids", // XML ID 
        name:"End", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
   {
        id:9,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0gj4h8v", // XML ID 
        name:"", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
   {
        id:10,  //activity id
        nodeType:6, // activity type 
        xmlID:"Gateway_09g2cgp", // XML ID 
        name:"", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
   {
        id:11,  //activity id
        nodeType:6, // activity type 
        xmlID:"Gateway_1fet496", // XML ID 
        name:"", // activity name 
        lane:"Buyer", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"}
      ]

      const _tabChildrenOptim=[["Activity_05ueiw1"],["Gateway_0gj4h8v"], ["Event_0oltqoi"],  ["Gateway_1fet496"],["Gateway_1fet496"],["Gateway_09g2cgp"],["Activity_1fe8pzt"],[],                  [],                 ["Event_1y57ids", "Activity_028pcds"] ,["Activity_0t6mu1f", "Activity_0n8vr3k"],["Activity_0xl1d3e"]]
      const _tabParentOptim=  [["Activity_05ueiw1"],["Activity_1fe8pzt"],["Gateway_1fet496"],["Gateway_09g2cgp"],["Gateway_09g2cgp"],["Gateway_0gj4h8v"],[],                  ["Activity_0xl1d3e"],["Gateway_0gj4h8v"],["Activity_05ueiw1"]                  ,["Activity_028pcds"],                    ["Activity_0t6mu1f", "Activity_0n8vr3k"]]
      const _msgInOptim=      [[],                  [],                  [],                 [],                 [],                 [],                 [],                  [],                  [],                 []                                    ,[],                                      []]
      const _msgOutOptim=     [[],                  [],                  [],                 [],                 [],                 [],                 [],                  [],                  [],                 []                                    ,[],                                      []]
      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('Procurement',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      let tx = await ModelFactoryFacet.newInstance('Procurement')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{


        await workflowExecution.Invoke(6,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(0,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(1,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(9,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(5,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(10,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(3,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(4,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(11,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(2,"Procurement",instanceTest,"Buyer","","")
        await workflowExecution.Invoke(7,"Procurement",instanceTest,"Buyer","","")

        included = await getterFacet.getIncluded("Procurement",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})