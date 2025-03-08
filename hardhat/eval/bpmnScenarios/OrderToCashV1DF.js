const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')




describe('mesureGasDiamondOrderToCashV1', async function () {
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
        xmlID:"Activity_06jr76a", // XML ID 
        name:"SubmitPO", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    {
        id:1,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0afj5f0", // XML ID 
        name:"ValidatePO", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    {
        id:2,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0py34ep", // XML ID 
        name:"GoodsShipment", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    {
        id:3,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_01mcchs", // XML ID 
        name:"IssueInvoiceForCustomer", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    {
        id:4,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1342vob", // XML ID 
        name:"ApprovenvoiceFromSupplier", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    {
        id:5,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1wotldy", // XML ID 
        name:"ResendInvoiceToCustomer", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    {
        id:6,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0gs4s74", // XML ID 
        name:"IssueInvoiceForSupplier", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    {
        id:7,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1ecrq3k", // XML ID 
        name:"ApproveInvoiceFromCarrier", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    {
        id:8,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_188t2ez", // XML ID 
        name:"ResendInvoiceToSupplier", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    {
        id:9,  //activity id
        nodeType:0, // activity type 
        xmlID:"Event_05gs6aw", // XML ID 
        name:"POCreated", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    {
        id:10,  //activity id
        nodeType:3, // activity type 
        xmlID:"Event_05hixq0", // XML ID 
        name:"PoCancellationReceived", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    {
        id:11,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_1887ijy", // XML ID 
        name:"PORejected", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    {
        id:12,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_0ezfrxl", // XML ID 
        name:"InvoiceAccepted", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    {
        id:13,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_0wcdtw2", // XML ID 
        name:"InvoicePaidBySupplier", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    {
        id:14,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_1y02fja", // XML ID 
        name:"POCancelled", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    {
        id:15,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_1jl22kw", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    {
        id:16,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0cfeuh4", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    {
        id:17,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_10tv0zx", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    {
        id:18,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_06v546f", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    {
        id:19,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_114cbge", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 20     
    ///////////////////////////////      
    {
        id:20,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0noqmrl", // XML ID 
        name:"", // activity name 
        lane:"OrderTOCash", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"}
      ]

      const _tabChildrenOptim=[["Activity_0afj5f0"],["Gateway_1jl22kw"], ["Gateway_0cfeuh4"],["Gateway_10tv0zx"],["Gateway_06v546f"],["Gateway_10tv0zx"],["Gateway_114cbge"],["Gateway_0noqmrl"],["Gateway_114cbge"],["Activity_06jr76a"],["Event_1y02fja"],[],                 [],                 [],                 [],               ["Event_1887ijy", "Activity_0py34ep"],["Activity_01mcchs", "Activity_0gs4s74"],["Activity_1342vob"],                    ["Event_0ezfrxl", "Activity_1wotldy"],["Activity_1ecrq3k"],                    ["Event_0wcdtw2", "Activity_188t2ez"]]
      const _tabParentOptim=  [["Event_05gs6aw"],   ["Activity_06jr76a"],["Gateway_1jl22kw"],["Gateway_0cfeuh4"],["Gateway_10tv0zx"],["Gateway_06v546f"],["Gateway_0cfeuh4"],["Gateway_114cbge"],["Gateway_0noqmrl"],[],                  [],               ["Gateway_1jl22kw"],["Gateway_06v546f"],["Gateway_0noqmrl"],["Event_05hixq0"],["Activity_0afj5f0"],                 ["Activity_0py34ep"],                    ["Activity_01mcchs", "Activity_1wotldy"],["Activity_1342vob"],                 ["Activity_0gs4s74", "Activity_188t2ez"],["Activity_1ecrq3k"]]
      const _msgInOptim=      [[],                  [],                  [],                 [],                 [],                 [],                 [],                 [],                 [],                 [],                  [],               [],                 [],                 [],                 [],               [],                                   [],                                      [],                                      [],                                   [],                                      []]
      const _msgOutOptim=     [[],                  [],                  [],                 [],                 [],                 [],                 [],                 [],                 [],                 [],                  [],               [],                 [],                 [],                 [],               [],                                   [],                                      [],                                      [],                                   [],                                      []]
      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('OrderToCashV1',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      let tx = await ModelFactoryFacet.newInstance('OrderToCashV1')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{


        await workflowExecution.Invoke(15,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(9,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(0,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(1,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(15,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(2,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(16,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(3,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(17,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(4,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(18,"OrderToCashV1",instanceTest,"OrderTOCash","","")
        await workflowExecution.Invoke(5,"OrderToCashV1",instanceTest,"OrderTOCash","","")

        // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

        included = await getterFacet.getIncluded("OrderToCashV1",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})