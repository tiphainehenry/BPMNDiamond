const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')




describe('mesureGasDiamond8', async function () {
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
        xmlID:"Activity_0ie1w76", // XML ID 
        name:"CustormerHasAProblem", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
        {
        id:1,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0bozc41", // XML ID 
        name:"GetProblemDescription", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
        {
        id:2,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0r128kw", // XML ID 
        name:"Ask1stLevelSUpport", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
        {
        id:3,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1dngsui", // XML ID 
        name:"ExplainSolution", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
        {
        id:4,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0adj04m", // XML ID 
        name:"Ask2ndLevelSupport", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
        {
        id:5,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_12idz9w", // XML ID 
        name:"AskDeveloper", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
        {
        id:6,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0q4892c", // XML ID 
        name:"ProvideFeedbackTo2ndLevelSupport", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
        {
        id:7,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0tk21ee", // XML ID 
        name:"ProvideFeedBackto1stLevelSupport", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
        {
        id:8,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_0ibhboc", // XML ID 
        name:"ProvideFeedBackForAccountManager", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
        {
        id:9,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1yi541v", // XML ID 
        name:"TPR1", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
        {
        id:10,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1mp27m4", // XML ID 
        name:"TPR2", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
        {
        id:11,  //activity id
        nodeType:4, // activity type 
        xmlID:"Activity_1w6vb4i", // XML ID 
        name:"TPR3", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
        {
        id:12,  //activity id
        nodeType:0, // activity type 
        xmlID:"StartEvent_1", // XML ID 
        name:"Start", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
        {
        id:13,  //activity id
        nodeType:1, // activity type 
        xmlID:"Event_0wky5ir", // XML ID 
        name:"end", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
        {
        id:14,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_1hznqhn", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
        {
        id:15,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_1agfqdl", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
        {
        id:16,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0kde6n8", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
        {
        id:17,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0yoy39t", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
        {
        id:18,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_0phs0y9", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"},
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
        {
        id:19,  //activity id
        nodeType:5, // activity type 
        xmlID:"Gateway_07nrjgr", // XML ID 
        name:"", // activity name 
        lane:"Role", //lane
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"}
      ]
    //   const _tabChildrenOptim=     [[],                  [],                  [],                 [],                 [],                 [],                  [],                  [],                 [],                 []                 ,[],                 [],                 [],                  []                  ,[],                                      [],                                      [],                                      [],                                      [],                                      []]
    //   const _tabParentOptim=     [[],                  [],                  [],                 [],                 [],                 [],                  [],                  [],                 [],                 []                 ,[],                 [],                 [],                  []                  ,[],                                      [],                                      [],                                      [],                                      [],                                      []]
      const _tabChildrenOptim=[["Activity_0bozc41"],["Gateway_1hznqhn"], ["Gateway_1agfqdl"],["Event_0wky5ir"],  ["Gateway_0kde6n8"],["Activity_0q4892c"],["Gateway_0yoy39t"], ["Gateway_07nrjgr"],["Gateway_0phs0y9"],["Gateway_0phs0y9"],["Gateway_07nrjgr"],["Gateway_0yoy39t"],["Activity_0ie1w76"],[]                 , ["Activity_0r128kw", "Activity_1yi541v"],["Activity_0adj04m", "Activity_1mp27m4"],["Activity_12idz9w", "Activity_1w6vb4i"],["Activity_0tk21ee"],                    ["Activity_1dngsui"],                    ["Activity_0ibhboc"]]
      const _tabParentOptim=  [["StartEvent_1"],    ["Activity_0ie1w76"],["Gateway_1hznqhn"],["Gateway_0phs0y9"],["Gateway_1agfqdl"],["Gateway_0kde6n8"], ["Activity_12idz9w"],["Gateway_0yoy39t"],["Gateway_07nrjgr"],["Gateway_1hznqhn"],["Gateway_1agfqdl"],["Gateway_0kde6n8"],[],                  ["Activity_1dngsui"],["Activity_0bozc41"],                    ["Activity_0r128kw"],                    ["Activity_0adj04m"],                    ["Activity_0q4892c", "Activity_1w6vb4i"],["Activity_0ibhboc", "Activity_1yi541v"],["Activity_0tk21ee", "Activity_1mp27m4"]]
      const _msgInOptim=      [[],                  [],                  [],                 [],                 [],                 [],                  [],                  [],                 [],                 []                 ,[],                 [],                 [],                  []                  ,[],                                      [],                                      [],                                      [],                                      [],                                      []]
      const _msgOutOptim=     [[],                  [],                  [],                 [],                 [],                 [],                  [],                  [],                 [],                 []                 ,[],                 [],                 [],                  []                  ,[],                                      [],                                      [],                                      [],                                      [],                                      []]
      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('IncidentManagement',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      
      let tx = await ModelFactoryFacet.newInstance('IncidentManagement')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{


        await workflowExecution.Invoke(12,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(0,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(1,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(14,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(2,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(15,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(4,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(16,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(5,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(6,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(17,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(7,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(19,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(8,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(18,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(3,"IncidentManagement",instanceTest,"Role","","")
        await workflowExecution.Invoke(13,"IncidentManagement",instanceTest,"Role","","")

        // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

        included = await getterFacet.getIncluded("IncidentManagement",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})