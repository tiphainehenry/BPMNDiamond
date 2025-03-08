// /* global ethers */
// /* eslint prefer-const: "off" */

// const { getSelectors, FacetCutAction, getSelector } = require('./libraries/diamond.js')

// async function deployDiamond () {
//   const accounts = await ethers.getSigners()
//   const contractOwner = accounts[0]

//   // deploy DiamondCutFacet
//   const DiamondCutFacet = await ethers.getContractFactory('DiamondCutFacet')
//   const diamondCutFacet = await DiamondCutFacet.deploy()
//   await diamondCutFacet.deployed()
//   console.log('DiamondCutFacet deployed:', diamondCutFacet.address)

//   // deploy Diamond
//   const Diamond = await ethers.getContractFactory('Diamond')
//   const diamond = await Diamond.deploy(contractOwner.address, diamondCutFacet.address)
//   await diamond.deployed()
//   console.log('Diamond deployed:', diamond.address)

//   // deploy DiamondInit
//   // DiamondInit provides a function that is called when the diamond is upgraded to initialize state variables
//   // Read about how the diamondCut function works here: https://eips.ethereum.org/EIPS/eip-2535#addingreplacingremoving-functions
//   const DiamondInit = await ethers.getContractFactory('DiamondInit')
//   const diamondInit = await DiamondInit.deploy()
//   await diamondInit.deployed()
//   console.log('DiamondInit deployed:', diamondInit.address)

//   // deploy facets
//   console.log('')
//   console.log('Deploying facets')
//   const FacetNames = [
//     'DiamondLoupeFacet',
//     'OwnershipFacet',
//     'GetterFacet'
//   ]
//   const cut = []
//   for (const FacetName of FacetNames) {
//     const Facet = await ethers.getContractFactory(FacetName)
//     const facet = await Facet.deploy()
//     await facet.deployed()
//     console.log(`${FacetName} deployed: ${facet.address}`)
//     cut.push({
//       facetAddress: facet.address,
//       action: FacetCutAction.Add,
//       functionSelectors: getSelectors(facet)
//     })
//   }

//   console.log('')
//   console.log('Deploying facets')
//   const PFacetNames = [
//     'GatesFacet',
//     'ChildrenStratFacet',
//     'LogicStratFacet',
//     'WorkflowExecutionFacet'
//   ]

//   // // deploy LibUtils
//   // const LibUtils = await ethers.getContractFactory('LibUtils');
//   // console.log('Deploying LibUtils...');
//   // const libUtils = await LibUtils.deploy();
//   // await libUtils.deployed();
//   // console.log('LibUtils deployed to:', libUtils.address);

//   // deploy facet with LibUtils
//   for (const FacetName of PFacetNames) {
//     const Facet = await ethers.getContractFactory(FacetName,{
//       libraries: {
//         LibUtils: libUtils.address,
//       },
//     });
//     const facet = await Facet.deploy()
//     await facet.deployed()
//     console.log(`${FacetName} deployed: ${facet.address}`)
//     cut.push({
//       facetAddress: facet.address,
//       action: FacetCutAction.Add,
//       functionSelectors: getSelectors(facet)
//     })
//   }

//   // upgrade diamond with facets
//   console.log('')
//   console.log('Diamond Cut:', cut)
//   const diamondCut = await ethers.getContractAt('IDiamondCut', diamond.address)
//   let tx
//   let receipt

//   // call to init function
//   console.log('appelle diamond cut')
//   let functionCall = diamondInit.interface.encodeFunctionData('init')
//   tx = await diamondCut.diamondCut(cut, diamondInit.address, functionCall)
//   console.log('Diamond cut tx: ', tx.hash)

//   // upgrade & Init Processus
//   const Processus = await ethers.getContractFactory('ProcessusFacet')
//   const processus = await Processus.deploy()
//   await processus.deployed()
//   const facetProcessus = []
//   facetProcessus.push({
//     facetAddress: processus.address,
//     action: FacetCutAction.Add,
//     functionSelectors: getSelectors(processus)
//   })

//   console.log('appelle diamond cut pour processus')
//   let functionCallProcessus = diamondInit.interface.encodeFunctionData('initProcessus')
//   let txProcessus
//   let receiptProcessus
//   txProcessus = await diamondCut.diamondCut(facetProcessus, diamondInit.address, functionCallProcessus)
//   console.log('Diamond cut txProcessus: ', txProcessus.hash)

//   receipt = await tx.wait()
//   receiptProcessus = await txProcessus.wait()
//   for (const event of receiptProcessus.events) {
//     console.log(`Event ${event.event} with args ${event.args}`);
//   }

//   if (!receipt.status ||!receiptProcessus.status) {
//     throw Error(`Diamond upgrade failed: ${tx.hash}`)
//   }
  
//   console.log('Completed diamond cut')
//   return diamond.address
// }

// // We recommend this pattern to be able to use async/await everywhere
// // and properly handle errors.
// if (require.main === module) {
//   deployDiamond()
//     .then(() => process.exit(0))
//     .catch(error => {
//       console.error(error)
//       process.exit(1)
//     })
// }

// exports.deployDiamond = deployDiamond
