const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')




describe('mesureGasDiamondPizza', async function () {
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
        xmlID:"Activity_1uou4p4", // XML ID 
        name:"DelierOrder", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    {
        id:1,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1up8jsn", // XML ID 
        name:"AssignDeliverer", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    {
        id:2,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0rezg6l", // XML ID 
        name:"Cancel", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    {
        id:3,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_06i8j16", // XML ID 
        name:"Confirm", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    {
        id:4,  //activity id
        nodeType:0, // activity type 
        xmlID:"StartEvent_1", // XML ID 
        name:"Start", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    {
        id:5,  //activity id
        nodeType:5, // activity type 
        xmlID:"Event_0eivwen", // XML ID 
        name:"ReceiveOrder", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    {
        id:6,  //activity id
        nodeType:3, // activity type 
        xmlID:"Event_01daf5m", // XML ID 
        name:"CreateOrder", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    {
        id:7,  //activity id
        nodeType:3, // activity type 
        xmlID:"Event_1kl5uog", // XML ID 
        name:"OrderDelivery", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    {
        id:8,  //activity id
        nodeType:3, // activity type 
        xmlID:"Event_0aj213h", // XML ID 
        name:"DeliveryOnRoad", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    {
        id:9,  //activity id
        nodeType:3, // activity type 
        xmlID:"Event_0npgfd4", // XML ID 
        name:"CollectPizza", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    {
        id:10,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_16ouu9t", // XML ID 
        name:"End", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    {
        id:11,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_00zp0ft", // XML ID 
        name:"End", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    {
        id:12,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_09ctmvb", // XML ID 
        name:"End", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    {
        id:13,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0s3h29o", // XML ID 
        name:"", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    {
        id:14,  //activity id
        nodeType:6, // activity type 
        xmlID:"Gateway_13dvwcj", // XML ID 
        name:"", // activity name 
        lane:"suplier", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"}
      ]
    //   const _tabChildrenOptim=     [[],                 [],                  [],                 [],                  [],               [],                 ["Event_0eivwen"],["Event_0npgfd4"],  [],                  [],             [],               [],                 [],                 []                                     ,[]]
    //   const _tabParentOptim=       [[],                 [],                  [],                 [],                  [],               [],                 ["Event_0eivwen"],["Event_0npgfd4"],  [],                  [],             [],               [],                 [],                 []                                     ,[]]
    //   const _msgInOptim=           [[],                 [],                  [],                 [],                  [],               [],                 ["Event_0eivwen"],["Event_0npgfd4"],  [],                  [],             [],               [],                 [],                 []                                     ,[]]

      const _tabChildrenOptim=[["Gateway_13dvwcj"],["Event_0aj213h"],   ["Event_09ctmvb"],  ["Activity_1up8jsn"],["Event_01daf5m"],["Gateway_0s3h29o"],[],               [],                 ["Activity_1uou4p4"],["Event_16ouu9t"],[],               [],                 [] ,                 ["Activity_0rezg6l", "Activity_06i8j16"],["Event_1kl5uog", "Event_00zp0ft"]]
      const _tabParentOptim=  [["Event_0aj213h"],  ["Activity_06i8j16"],["Gateway_0s3h29o"],["Gateway_0s3h29o"], [],               [],                 ["StartEvent_1"], ["Gateway_13dvwcj"],["Activity_1up8jsn"],[]               ,["Event_0npgfd4"],["Gateway_13dvwcj"],["Activity_0rezg6l"],["Event_0eivwen"]                       ,["Activity_1uou4p4"]]
      const _msgInOptim=      [[],                 [],                  [],                 [],                  [],               ["Event_01daf5m"],  [],               [],                 [],                  ["Event_1kl5uog"],[],               [],                 [] ,                 [],                                      []]
      const _msgOutOptim=     [[],                 [],                  [],                 [],                  [],               [],                 ["Event_0eivwen"],["Event_0npgfd4"],  [],                  []               ,[],               [],                 [] ,                 [],                                      []]
      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('Pizza',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      let tx = await ModelFactoryFacet.newInstance('Pizza')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{


        await workflowExecution.Invoke(4,"Pizza",instanceTest,"Role","","")
        await workflowExecution.Invoke(6,"Pizza",instanceTest,"Role","","")
        await workflowExecution.Invoke(13,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(3,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(1,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(8,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(0,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(14,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(7,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(11,"Pizza",instanceTest,"suplier","","")
        await workflowExecution.Invoke(10,"Pizza",instanceTest,"Role","","")



        // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

        included = await getterFacet.getIncluded("Pizza",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})