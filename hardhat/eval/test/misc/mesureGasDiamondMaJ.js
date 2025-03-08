/* global describe it before ethers */
// Exemple de mise a jour de facet pour le Diamond InstanceOnly

const {
  getSelectors,
  FacetCutAction,
  removeSelectors,
  findAddressPositionInFacets
  } = require('../../scripts/libraries/diamond.js')
  
  const { deployDiamond } = require('../../scripts/deploy.js')
  
  const { assert } = require('chai')
  const { getCreate2Address, deepCopy } = require('ethers/lib/utils.js')
  
  describe('DiamondTest', async function () {
    let diamondAddress
    let diamondCutFacet
    let diamondLoupeFacet
    let ownershipFacet
    let getterFacet
    let gatesFacet 
    let childrenStratFacet 
    let logicStratFacet 
    let workflowExecution 
    let processus
    let tx
    let receipt
    let result
    const addresses = []
  
    before(async function () {
      diamondAddress = await deployDiamond()
      diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress)
      diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress)
      ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress)
      getterFacet = await ethers.getContractAt('GetterFacet', diamondAddress)
      gatesFacet = await ethers.getContractAt('GatesFacet',diamondAddress)
      childrenStratFacet = await ethers.getContractAt('ChildrenStratFacet', diamondAddress)
      logicStratFacet = await ethers.getContractAt('LogicStratFacet', diamondAddress)
      workflowExecution = await ethers.getContractAt('WorkflowExecutionFacet', diamondAddress)
      processus = await ethers.getContractAt('ProcessusFacet',diamondAddress)
    })

    it('test Rajout owner activity',async()=>{
    //   const LibUtils = await ethers.getContractFactory('LibUtils');
    //   console.log('Deploying LibUtils...');
    //   const libUtils = await LibUtils.deploy();
    //   await libUtils.deployed();
      
    //   let cutV2 =[]
    //   let selectors 

    //   //______________________Deploiment de WorkflowExecution avec la MaJ de Invoke LibDiamond et IProcessus et ajout des selecteurs au Cut en tant que Replace_____________________________________________________
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

    //   //_____________________Deploiment de Processus MaJ de addActivity LibDiamond et IProcessus______________________________________________________
    //   const ProcessV2 = await ethers.getContractFactory('ProcessusFacetV2')
    //   let processV2 = await ProcessV2.deploy()
    //   await processV2.deployed()
    //   // ajout des selecteurs de Processus hors addActivity au Cut en tant que Replace
    //   selectors = getSelectors(processV2).remove(['addActivity(uint256,uint8,string[],string[],string[],string[],string[],address)'])
    //   cutV2.push({
    //     facetAddress: processV2.address,
    //     action: FacetCutAction.Replace,
    //     functionSelectors: selectors
    //   })

    //   //_____________________Deploiment de Getter MaJ de getActivityFromId LibDiamond et IProcessus et ajout des selecteur au Cut en tant que Replace______________________________________________________
    //   const GetterV2 = await ethers.getContractFactory('GetterFacetV2')
    //   let getterV2 = await GetterV2.deploy()
    //   await getterV2.deployed()
    //   selectors = getSelectors(getterV2)
    //   cutV2.push({
    //     facetAddress: getterV2.address,
    //     action: FacetCutAction.Replace,
    //     functionSelectors: selectors
    //   })

    //   //ajout du selecteur de addActivity de ProcessusV2 au Cut en tant que Add
    //   selectors = getSelectors(processV2).get(['addActivity(uint256,uint8,string[],string[],string[],string[],string[],address)'])
    //   cutV2.push({
    //     facetAddress: processV2.address,
    //     action: FacetCutAction.Add,
    //     functionSelectors: selectors
    //   })

    //   //recuperation du selecteur de addActivity de ProcessusV1 et ajout au Cut en tant que remove
    //   let ProcessV1 = await ethers.getContractFactory('ProcessusFacet')
    //   let processV1 = await ProcessV1.deploy()
    //   await processV1.deployed()
    //   selectors = getSelectors(processV1).get(['addActivity(uint256,uint8,string,string,string,string,string,string,string[],string[],string[],string[])'])
    //   cutV2.push({
    //     facetAddress: ethers.constants.AddressZero,
    //     action: FacetCutAction.Remove,
    //     functionSelectors: selectors
    //   })
    //   let activity = await getterFacet.getActivityDataFromActivityId(7)
    //   console.log(activity)

    //   //____________________________Appel au diamondCut avec le Cut________________________________________________________________________________
    //   tx = await diamondCutFacet.diamondCut(
    //     cutV2,
    //     ethers.constants.AddressZero, '0x', { gasLimit: 800000 })
    //   receipt = await tx.wait()

    //   if (!receipt.status) {
    //     throw Error(`Diamond upgrade failed: ${tx.hash}`)
    //   }

    })
  })