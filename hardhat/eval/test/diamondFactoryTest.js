/* global describe it before ethers */

const {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets
  } = require('../scripts/libraries/diamond.js')
  
  const { deployDiamond } = require('../scripts/deployDiamondFactory.js')
  
  const { assert } = require('chai')
  const { getCreate2Address, deepCopy } = require('ethers/lib/utils.js')
  
  describe('DiamondTest', async function () {
    let diamondAddress
    let diamondCutFacet
    let diamondLoupeFacet
    let ownershipFacet
    let getterFacet
    let ExecLogicFacet
    let ModelFactoryFacet
    let result
    let instanceTest
    const addresses = []



  
    before(async function () {
      diamondAddress = await deployDiamond()
      diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress)
      diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress)
      ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress)
      getterFacet = await ethers.getContractAt('GettersFacet', diamondAddress)
      ExecLogicFacet = await ethers.getContractAt('ExecLogicFacet',diamondAddress)
      ModelFactoryFacet = await ethers.getContractAt('ModelFactoryFacet',diamondAddress)

      const activity = [
        {
        id:0,
        nodeType:4,
        xmlID:"Activity_15n2fuv",
        name:"RealisationProjet",
        lane:"BureauEtude",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:1,
        nodeType:4,
        xmlID:"Activity_0jptkb4",
        name:"VerificationsN1",
        lane:"VerificateurN1",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:2,
        nodeType:0,
        xmlID:"Event_1m9jbqa",
        name:"startProject",
        lane:"BureauEtude",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:3,
        nodeType:2,
        xmlID:"Event_1xb2qil",
        name:"receiveNotif",
        lane:"VerificateurN1",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:4,
        nodeType:1,
        xmlID:"Event_1jryq1w",
        name:"notify",
        lane:"BureauEtude",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:5,
        nodeType:1,
        xmlID:"Event_07w16d4",
        name:"replay",
        lane:"VerificateurN1",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:6,
        nodeType:1,
        xmlID:"Event_0m90tu0",
        name:"finish",
        lane:"VerificateurN1",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        },
        {
        id:7,
        nodeType:5,
        xmlID:"Gateway_07qh5z4",
        name:"choose",
        lane:"VerificateurN1",
        dataIn:"",
        dataOut:"",
        timestamp:"12/31/2022"
        }
      ]

      const _tabChildrenOptim=[["Event_1jryq1w"],["Gateway_07qh5z4"],["Activity_15n2fuv"],["Activity_0jptkb4"],[],[],[],["Event_07w16d4","Event_0m90tu0"]]
      const _tabParentOptim=[["Event_1m9jbqa"],["Event_1xb2qil"],[],[],["Activity_15n2fuv"],["Gateway_07qh5z4"],["Activity_15n2fuv"],["Activity_0jptkb4"]]
      const _msgInOptim=[["Event_07w16d4"],[],[],["Event_1jryq1w"],[],[],[],[]]
      const _msgOutOptim=[[],[],[],[],["Event_1xb2qil"],["Activity_15n2fuv"],[],[]]
      const _keyReplay=["Event_07w16d4"]
      const _valueReplay=[["Event_1jryq1w","Event_1xb2qil","Activity_0jptkb4","Gateway_07qh5z4","Event_07w16d4","Event_0m90tu0"]]
      await ModelFactoryFacet.addModel('Taille8',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      let tx = await ModelFactoryFacet.newInstance('Taille8')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)


    })
  
    it('should have six facets -- call to facetAddresses function', async () => {
      for (const address of await diamondLoupeFacet.facetAddresses()) {
        addresses.push(address)
      }
      assert.equal(addresses.length, 6)
    })
  
    it('facets should have the right function selectors -- call to facetFunctionSelectors function', async () => {
      let selectors = getSelectors(diamondCutFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[0])
      assert.sameMembers(result, selectors)
  
      selectors = getSelectors(diamondLoupeFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[1])
      assert.sameMembers(result, selectors)
      
      selectors = getSelectors(ownershipFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[2])
      assert.sameMembers(result, selectors)
      
      selectors = getSelectors(getterFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[3])
      assert.sameMembers(result, selectors)
      
      selectors = getSelectors(ExecLogicFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[4])
      assert.sameMembers(result, selectors)
      
      selectors = getSelectors(ModelFactoryFacet)
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[5])
      assert.sameMembers(result, selectors)
    })
  
    it('selectors should be associated to facets correctly -- multiple calls to facetAddress function', async () => {
      assert.equal(
        addresses[0],
        await diamondLoupeFacet.facetAddress('0x1f931c1c')
      )
  
      assert.equal(
        addresses[1],
        await diamondLoupeFacet.facetAddress('0xcdffacc6')
      )
      
      assert.equal(
        addresses[1],
        await diamondLoupeFacet.facetAddress('0x01ffc9a7')
      )
      
      assert.equal(
        addresses[2],
        await diamondLoupeFacet.facetAddress('0xf2fde38b')
      )
    })
  
    it('test getters and InitProcessus', async ()=>{



      const tpr = await getterFacet.getNbInstance('Taille8')
      console.log(Number(tpr))

      let result =await  getterFacet.getIncluded('Taille8',instanceTest);
      result = result.map(value => Number(value));
      let expected =[0,0,1,0,0,0,0,0];
      assert.deepEqual(result,expected);
  
  
      result = await getterFacet.getPending('Taille8',instanceTest);
      result = result.map(value => Number(value));
      expected =[0,0,0,0,0,0,0,0];
      assert.deepEqual(result,expected);
  
      result = await getterFacet.getExecuted('Taille8',instanceTest);
      result = result.map(value => Number(value));
      assert.deepEqual(result,expected);
  
      // result = await getterFacet.getXORIds()
      // result = result.map(value => Number(value));
      // assert.deepEqual(result,[]);
  
  
      result = await getterFacet.getActivityDataFromActivityId(0, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x00"},{"type":"BigNumber","hex":"0x04"},"Activity_15n2fuv","RealisationProjet","","","BureauEtude","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(1, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x01"},{"type":"BigNumber","hex":"0x04"},"Activity_0jptkb4","VerificationsN1","","","VerificateurN1","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(2, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x02"},{"type":"BigNumber","hex":"0x00"},"Event_1m9jbqa","startProject","","","BureauEtude","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(3, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x03"},{"type":"BigNumber","hex":"0x02"},"Event_1xb2qil","receiveNotif","","","VerificateurN1","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(4, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x04"},{"type":"BigNumber","hex":"0x01"},"Event_1jryq1w","notify","","","BureauEtude","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(5, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x05"},{"type":"BigNumber","hex":"0x01"},"Event_07w16d4","replay","","","VerificateurN1","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getActivityDataFromActivityId(6, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x06"},{"type":"BigNumber","hex":"0x01"},"Event_0m90tu0","finish","","","VerificateurN1","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
      
      result = await getterFacet.getActivityDataFromActivityId(7, 'Taille8');
      expected=[{"type":"BigNumber","hex":"0x07"},{"type":"BigNumber","hex":"0x05"},"Gateway_07qh5z4","choose","","","VerificateurN1","12/31/2022"]
      expected = JSON.stringify(expected)
      result =JSON.stringify(result);
      console.log('actual',result);
      assert.equal(expected,result);
  
      result = await getterFacet.getReplaySegment("Event_07w16d4", 'Taille8')
      assert.deepEqual(result,["Event_1jryq1w","Event_1xb2qil","Activity_0jptkb4","Gateway_07qh5z4","Event_07w16d4","Event_0m90tu0"])

    })
  
    it('test gates', async ()=>{
      await ExecLogicFacet.executeXORGate(0,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      incActId = included[0]
      incActId = Number(incActId)
      assert.deepEqual(incActId,0)
  
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      console.log(executed)
      exeActId = executed[0]
      exeActId = Number(exeActId)
      assert.deepEqual(exeActId,1)
  
      incActId = included[4]
      incActId = Number(incActId)
      assert.deepEqual(incActId,1)
  
      // xorIds = await getterFacet.getXORIds()
      // xorIds = xorIds.map(value => Number(value));
      // assert.deepEqual(xorIds,[4])
  
      await ExecLogicFacet.executeANDGate(4,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      incActId = included[4]
      incActId = Number(incActId)
      assert.deepEqual(incActId,0)
  
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 1, 0, 0, 0])
    })
  
    it('test childrenStrat', async ()=>{

      await ExecLogicFacet.updateChildMarking("Taille8",instanceTest,"Activity_0jptkb4")
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      incActId = included[1]
      incActId = Number(incActId)
      assert.deepEqual(incActId,1)

      await ExecLogicFacet.updateInternalChildren(7,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));

      assert.deepEqual(executed,[1, 0, 0, 0, 1, 0, 0, 0])
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      pending = await getterFacet.getPending("Taille8",instanceTest)
      console.log("after InternalChild",included,executed,pending)
      
      await ExecLogicFacet.updateExternalChildren(4,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      console.log("after",included)
      assert.deepEqual(included, [0, 1, 1, 1, 0, 1, 1, 0])
  
      await ExecLogicFacet.updateChildren(7,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,  [0, 1, 1, 1, 0, 1, 1, 0])
  
      ////// rajout de la facet pcontenant les fonction specialement pour le test
      const FonctionTestFacet = await ethers.getContractFactory('FonctionTestFacetFactory')
      const fonctionTestFacet = await FonctionTestFacet.deploy()
      await fonctionTestFacet.deployed()
      const selectors = getSelectors(fonctionTestFacet)
      tx = await diamondCutFacet.diamondCut(
        [{
          facetAddress: fonctionTestFacet.address,
          action: FacetCutAction.Add,
          functionSelectors: selectors
        }],
        ethers.constants.AddressZero, '0x', { gasLimit: 800000 })
      receipt = await tx.wait()
      if (!receipt.status) {
       throw Error(`Diamond upgrade failed: ${tx.hash}`)
      }
      fonctionTest = await ethers.getContractAt('FonctionTestFacetFactory',diamondAddress)
      
      await fonctionTest.setIncluded([0, 0, 1, 1, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([1, 0, 0, 0, 1, 0, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.updateChildren(3,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,  [0, 1, 1, 1, 0, 1, 1, 0])
  
  
      await fonctionTest.setIncluded([0, 1, 1, 0, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([1, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      pending = await getterFacet.getPending("Taille8",instanceTest)
      console.log("before",included,executed,pending)
      await ExecLogicFacet.updateChildren(0,"Taille8",instanceTest)   
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 1, 1, 0, 1, 1, 1, 0],"ici")
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      pending = await getterFacet.getPending("Taille8",instanceTest)
      console.log("after",included,executed,pending)
  
    })
  
    it('test logicStrat', async ()=>{
  
      await fonctionTest.setIncluded([0, 0, 1, 1, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([1, 0, 0, 0, 1, 0, 0, 0],"Taille8",instanceTest)

      await ExecLogicFacet.handleIncomingMsgStart(3,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,  [0, 1, 1, 1, 0, 1, 1, 0])
  
      await fonctionTest.setExecuted([0, 0, 0, 0, 1, 0, 0, 0],"Taille8",instanceTest)

      await ExecLogicFacet.handleChildMarkings(5,"Taille8",instanceTest,"Activity_15n2fuv")
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 1, 0, 0, 0])
  
      await ExecLogicFacet.pendingNotarizationStart(0,"Taille8",instanceTest,true,"test")
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value))
      assert.deepEqual(pending,[1, 0, 0, 0, 0, 0, 0, 0])
      result = await getterFacet.getActivityDataFromActivityId(0,"Taille8")
      result = result[4]
      assert.deepEqual('test',result)
  
      await fonctionTest.setIncluded([1, 1, 1, 1, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([0, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await fonctionTest.setPending([1, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.pendingNotarizationEnd(0,"Taille8",instanceTest,"testPNE1","00/00/0000")
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 1, 1, 1, 1, 1, 1, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 0, 0, 0])
      result = await getterFacet.getActivityDataFromActivityId(0,"Taille8")
      result = result[5]
      assert.deepEqual('testPNE1',result)
  
      await fonctionTest.setIncluded([1, 1, 1, 1, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([0, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
  
      await ExecLogicFacet.pendingNotarizationEnd(5,"Taille8",instanceTest,"testPNE2","00/00/0000")
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[1, 1, 1, 1, 1, 0, 1, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 1, 0, 0])    
      result = await getterFacet.getActivityDataFromActivityId(5,"Taille8")
      result = result[5]
      assert.deepEqual('testPNE2',result)
  
    })
  
    it('test workflow: Task', async () =>{
      result = await ExecLogicFacet.isMsgOutOptimNotEmpty("Taille8",0)
      assert.isNotOk(result)
      result = await ExecLogicFacet.isMsgOutOptimNotEmpty("Taille8",4)
      assert.ok(result)
  
      result = await ExecLogicFacet.isMsgInOptimNotEmpty("Taille8",0)
      assert.ok(result)
      result = await ExecLogicFacet.isMsgInOptimNotEmpty("Taille8",1)
      assert.isNotOk(result)
  
      result = await ExecLogicFacet.isChildrenOptimNotEmpty("Taille8",0)
      assert.ok(result)
      result = await ExecLogicFacet.isChildrenOptimNotEmpty("Taille8",4)
      assert.isNotOk(result)
  
      result = await ExecLogicFacet.isParentOptimNotEmpty("Taille8",0)
      assert.ok(result)
      result = await ExecLogicFacet.isParentOptimNotEmpty("Taille8",2)
      assert.isNotOk(result)
  
      result = await ExecLogicFacet.getPosFromXML("Taille8","Activity_15n2fuv")
      result = Number(result)
      assert.deepEqual(result, 0)
  
      result = await ExecLogicFacet.getPosFromXML("Taille8","erreur")
      result = Number(result)
      assert.deepEqual(result, 404)
  
      result = await ExecLogicFacet.checkIncomingMsgExecuted(0,"Taille8",instanceTest)
      assert.ok(result)
      result = await ExecLogicFacet.checkIncomingMsgExecuted(3,"Taille8",instanceTest)
      assert.isNotOk(result)
  
      await fonctionTest.setIncluded([1, 1, 1, 1, 0, 0, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([0, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await fonctionTest.setPending([1, 0, 0, 0, 0, 1, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.execTask(0,"Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 1, 1, 1, 1, 0, 1, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 1, 0, 0])
  
      await ExecLogicFacet.setActivitiesSegment("Event_1m9jbqa","Event_07w16d4","Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 0, 1, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 0, 0, 0])
    })
    it('test workflow : Update', async() =>{
  
      await fonctionTest.setIncluded([0, 0, 0, 0, 1, 0, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.disableConcurrentActivities("Taille8",instanceTest)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 0, 0, 0, 0, 0, 0, 0])
      // xorIds = await getterFacet.getXORIds()
      // xorIds = xorIds.map(value =>Number(value))
      // assert.deepEqual(xorIds,[])
  
      await ExecLogicFacet.handleNoDataOut(5,"Taille8",instanceTest,"testHNDO1","00/00/0000",true)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[1, 0, 0, 0, 0, 0, 0, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[0, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 0, 0, 0])
      result = await getterFacet.getActivityDataFromActivityId(5,"Taille8")
      result = result[4]
      assert.deepEqual(result,"testHNDO1")
  
      await fonctionTest.setIncluded([1, 1, 1, 1, 0, 0, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([0, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await fonctionTest.setPending([1, 0, 0, 0, 0, 1, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.handleNoDataOut(0,"Taille8",instanceTest,"","",false)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 1, 1, 1, 1, 0, 1, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 1, 0, 0])
  
      await ExecLogicFacet.handleDataOut(0,"Taille8",instanceTest,"testHDO","",true)
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value))
      assert.deepEqual(pending,[1, 0, 0, 0, 0, 1, 0, 0])
      result = await getterFacet.getActivityDataFromActivityId(0,"Taille8")
      result = result[4]
      assert.deepEqual('testHDO',result)
  
      await fonctionTest.setIncluded([1, 1, 1, 1, 0, 1, 1, 0],"Taille8",instanceTest)
      await fonctionTest.setExecuted([0, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await fonctionTest.setPending([1, 0, 0, 0, 0, 0, 0, 0],"Taille8",instanceTest)
      await ExecLogicFacet.handleDataOut(0,"Taille8",instanceTest,"testHD1","",true)
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      assert.deepEqual(included,[0, 1, 1, 1, 1, 1, 1, 0])
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      assert.deepEqual(executed,[1, 0, 0, 0, 0, 0, 0, 0])
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      assert.deepEqual(pending,[0, 0, 0, 0, 0, 0, 0, 0])
      result = await getterFacet.getActivityDataFromActivityId(0,"Taille8")
      result = result[5]
      assert.deepEqual('testHD1',result)
  
      await ExecLogicFacet.killProcess("Taille8",instanceTest)
      result = await getterFacet.getIncluded("Taille8",instanceTest)
      result = result.map(value =>Number(value))
      assert.deepEqual(result,[])
  
      included = await getterFacet.getIncluded("Taille8",instanceTest)
      included = included.map(value => Number(value));
      console.log('inclu before',included)
      executed = await getterFacet.getExecuted("Taille8",instanceTest)
      executed = executed.map(value => Number(value));
      console.log('execut before',executed)
      pending = await getterFacet.getPending("Taille8",instanceTest)
      pending = pending.map(value => Number(value));
      console.log('pending before',pending)
    })
  
    // it('test plusieur instance',async() =>{
    //   await fonctionTest.setIncluded([0, 0, 0, 0, 0, 0, 0, 0])
    //   await processus.addWorkflowInstance("myContract",8,[0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],["Event_07w16d4"],[["Event_1jryq1w","Event_1xb2qil","Activity_0jptkb4","Gateway_07qh5z4","Event_07w16d4","Event_0m90tu0"]])
    //   await processus.addActivity(
    //     8,  //activity id
    //     4, // activity type 
    //     "Activity_15n2fuv", // XML ID 
    //     "RealisationProjet", // activity name 
    //     "BureauEtude", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     ["Event_1jryq1w"],
    //     ["Event_1m9jbqa"],
    //     ["Event_07w16d4"],
    //     [])
    //   await processus.addActivity(
    //     9,  //activity id
    //     4, // activity type 
    //     "Activity_0jptkb4", // XML ID 
    //     "VerificationsN1", // activity name 
    //     "VerificateurN1", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     ["Gateway_07qh5z4"],
    //     ["Event_1xb2qil"],
    //     [],
    //     []
    //   );
  
    //   await processus.addActivity(
    //     10,  //activity id
    //     0, // activity type 
    //     "Event_1m9jbqa", // XML ID 
    //     "startProject", // activity name 
    //     "BureauEtude", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     ["Activity_15n2fuv"],
    //     [],
    //     [],
    //     []
    //   );
  
    //   await processus.addActivity(
    //     11,  //activity id
    //     2, // activity type 
    //     "Event_1xb2qil", // XML ID 
    //     "receiveNotif", // activity name 
    //     "VerificateurN1", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     ["Activity_0jptkb4"],
    //     [],
    //     ["Event_1jryq1w"],
    //     []
    //   );
  
    //   await processus.addActivity(
    //     12,  //activity id
    //     1, // activity type 
    //     "Event_1jryq1w", // XML ID 
    //     "notify", // activity name 
    //     "BureauEtude", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     [],
    //     ["Activity_15n2fuv"],
    //     [],
    //     ["Event_1xb2qil"]
    //   );
  
    //   await processus.addActivity(
    //     13,  //activity id
    //     1, // activity type 
    //     "Event_07w16d4", // XML ID 
    //     "replay", // activity name 
    //     "VerificateurN1", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     [],
    //     ["Gateway_07qh5z4"],
    //     [],
    //     ["Activity_15n2fuv"]
    //   );
  
    //   await processus.addActivity(
    //     14,  //activity id
    //     1, // activity type 
    //     "Event_0m90tu0", // XML ID 
    //     "finish", // activity name 
    //     "VerificateurN1", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     [],
    //     ["Activity_15n2fuv"],
    //     [],
    //     []
    //   );
  
    //   await processus.addActivity(
    //     15,  //activity id
    //     5, // activity type 
    //     "Gateway_07qh5z4", // XML ID 
    //     "choose", // activity name 
    //     "VerificateurN1", //lane
    //     "",
    //     "",
    //     "12/31/2022",
    //     ["Event_07w16d4","Event_0m90tu0"],
    //     ["Activity_0jptkb4"],
    //     [],
    //     []
    //   );
    //   result = await getterFacet.getNumWorkflow()
    //   result = Number(result)
    //   result = await getterFacet.getActivityIdsFromWorkflow(1)
    //   result = result.map(value => Number(value))
    //   await ExecLogicFacet.Invoke(10,"BureauEtude","","")
    //   await ExecLogicFacet.Invoke(8,"BureauEtude","","")
    //   await ExecLogicFacet.Invoke(12,"BureauEtude","","")
    //   await ExecLogicFacet.Invoke(9,"VerificateurN1","","")
    //   await ExecLogicFacet.Invoke(15,"VerificateurN1","","")
    //   await ExecLogicFacet.Invoke(14,"VerificateurN1","","")
    //   included = await getterFacet.getIncluded()
    //   included = included.map(value => Number(value));
    //   assert.deepEqual(included,[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
  
    // })
  
    // it('test Rajout owner activity',async()=>{
  
    //   console.log(await getterFacet.getAddress(getSelectors(workflowExecution).get(['Invoke(uint256,string,string,string)'])[0]))
  
    //   const LibUtils = await ethers.getContractFactory('LibUtils');
    //   console.log('Deploying LibUtils...');
    //   const libUtils = await LibUtils.deploy();
    //   await libUtils.deployed();
      
    //   let cutV2 =[]
    //   let selectors 
  
    //   const WfV2 = await ethers.getContractFactory('WorkflowExecutionFacetV2',{
    //     libraries: {
    //       LibUtils: libUtils.address,
    //     },
    //   })
    //   let wfV2 = await WfV2.deploy()
    //   await wfV2.deployed()
    //   selectors = getSelectors(wfV2)
    //   cutV2 =[]
    //   cutV2.push({
    //     facetAddress: wfV2.address,
    //     action: FacetCutAction.Replace,
    //     functionSelectors: selectors
    //   })
  
    //   const ProcessV2 = await ethers.getContractFactory('ProcessusFacetV2')
    //   let processV2 = await ProcessV2.deploy()
    //   await processV2.deployed()
    //   selectors = getSelectors(processV2).remove(['addActivity(uint256,uint8,string[],string[],string[],string[],string[],address)'])
    //   cutV2.push({
    //     facetAddress: processV2.address,
    //     action: FacetCutAction.Replace,
    //     functionSelectors: selectors
    //   })
  
    //   const GetterV2 = await ethers.getContractFactory('GetterFacetV2')
    //   let getterV2 = await GetterV2.deploy()
    //   await getterV2.deployed()
    //   selectors = getSelectors(getterV2)
    //   cutV2.push({
    //     facetAddress: getterV2.address,
    //     action: FacetCutAction.Replace,
    //     functionSelectors: selectors
    //   })
  
    //   selectors = getSelectors(processV2).get(['addActivity(uint256,uint8,string[],string[],string[],string[],string[],address)'])
    //   //console.log(selectors)
    //   cutV2.push({
    //     facetAddress: processV2.address,
    //     action: FacetCutAction.Add,
    //     functionSelectors: selectors
    //   })
  
    //   let ProcessV1 = await ethers.getContractFactory('ProcessusFacet')
    //   let processV1 = await ProcessV1.deploy()
    //   await processV1.deployed()
    //   selectors = getSelectors(processV1).get(['addActivity(uint256,uint8,string,string,string,string,string,string,string[],string[],string[],string[])'])
    //   cutV2.push({
    //     facetAddress: ethers.constants.AddressZero,
    //     action: FacetCutAction.Remove,
    //     functionSelectors: selectors
    //   })
    //   let activity = await getterFacet.getActivityDataFromActivityId(8)
    //   console.log(activity)
    //   tx = await diamondCutFacet.diamondCut(
    //     cutV2,
    //     ethers.constants.AddressZero, '0x', { gasLimit: 800000 })
    //   receipt = await tx.wait()
  
    //   if (!receipt.status) {
    //     throw Error(`Diamond upgrade failed: ${tx.hash}`)
    //   }
  
  
    //   const signer = await ethers.getSigner();
    //   const address = await signer.getAddress();
    //   let getterV2D = await ethers.getContractAt('GetterFacetV2', diamondAddress)
    //   console.log(await getterV2D.getAddress(getSelectors(wfV2).get(['Invoke(uint256,string,string,string)'])[0]))
    //   console.log(wfV2.address)
    //   console.log(await getterV2D.getAddress(getSelectors(getterV2).get(['getActivityDataFromActivityId(uint256)'])[0]))
    //   console.log(getterV2.address)
    //   console.log(await getterV2D.getAddress(getSelectors(processV2).get(['addWorkflowInstance(string ,uint256 ,uint[] ,uint[] ,uint[],string[],string[][])'])[0]))
    //   console.log(processV2.address)
    //   console.log(await getterV2D.getAddress(getSelectors(processV2).get(['addActivity(uint256 ,uint8,string[] ,string[] ,string[] ,string[] ,string[] ,address )'])[0]))
    //   console.log(processV2.address)
  
    //   processV2 = await ethers.getContractAt('ProcessusFacetV2', diamondAddress)
    //   wfV2 = await ethers.getContractAt('WorkflowExecutionFacetV2', diamondAddress)
    //   activity = await getterV2D.getActivityDataFromActivityId(8)
    //   //console.log(activity)
  
    //   function generateRandomAddress() {
    //     // Generate a random private key
    //     const randomPrivateKey = ethers.utils.randomBytes(32);
      
    //     // Create a Wallet instance from the private key
    //     const wallet = new ethers.Wallet(randomPrivateKey);
      
    //     // Return the address associated with the wallet
    //     return wallet.address;
    //   }
    //   await processV2.addActivity(
    //     8,  //activity id
    //     4, // activity type 
    //     ["Activity_15n2fuv","RealisationProjet","BureauEtude","","","12/31/2022"],
    //     ["Event_1jryq1w"],
    //     ["Event_1m9jbqa"],
    //     ["Event_07w16d4"],
    //     [],
    //     generateRandomAddress())
    //   console.log("adress : ",address)
    //   activity = await getterV2D.getActivityDataFromActivityId(8)
    //   console.log(activity)
    //   await wfV2.Invoke(8,"BureauEtude","","")
    //   // await wfV2.Invoke(12,"BureauEtude","","")
  
    //   //console.log(getSelectors(wfV2).get(['Invoke(uint256,string,string,string)'])[0])
  
  
  
  
    // })
  })
  