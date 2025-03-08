/* global ethers */
/* eslint prefer-const: "off" */

const { getSelectors, FacetCutAction, getSelector } = require('./libraries/diamond.js')

async function deployDiamond () {
  const accounts = await ethers.getSigners()
  const contractOwner = accounts[0]

  ///////////////////////////// 
  ///// deployment stage //////
  ///////////////////////////// 
    
  // ~~ ~~ facets ~~ ~~ //
  const FacetNames = [
    'DiamondLoupeFacet',
    'OwnershipFacet',
    'GettersFacet',
    'ExecLogicFacet',
    'ModelFactoryFacet'
  ]
  const cut = []
  for (const FacetName of FacetNames) {
    const Facet = await ethers.getContractFactory(FacetName)
    const facet = await Facet.deploy()
    await facet.deployed()
    
    console.log(`${FacetName} deployed: ${facet.address}`)
    cut.push({
      facetAddress: facet.address,
      action: FacetCutAction.Add,
      functionSelectors: getSelectors(facet)
    })
  }
  
  // ~~ ~~ DiamondCut ~~ ~~ //
  const DiamondCutFacet = await ethers.getContractFactory('DiamondCutFacet')
  const diamondCutFacet = await DiamondCutFacet.deploy()
  await diamondCutFacet.deployed()
  console.log('DiamondCutFacet deployed:', diamondCutFacet.address)

  // ~~ ~~ Diamond ~~ ~~ //
  const Diamond = await ethers.getContractFactory('Diamond')
  const diamond = await Diamond.deploy(contractOwner.address, diamondCutFacet.address)
  await diamond.deployed()
  console.log('Diamond deployed:', diamond.address)

  // ~~ ~~ DiamondInit ~~ ~~ //
  // DiamondInit provides a function that is called when the diamond is upgraded to initialize state variables
  const DiamondInit = await ethers.getContractFactory('DiamondInit')
  const diamondInit = await DiamondInit.deploy()
  await diamondInit.deployed()
  console.log('DiamondInit deployed:', diamondInit.address)

  ///////////////////////////// 
  ////// Linking stage ////////
  
  ///////////////////////////// 

  // upgrade diamond with facets
  console.log('')
  console.log('Diamond Cut:', cut)
  const DiamondCut = await ethers.getContractAt('IDiamondCut', diamond.address)
  let tx
  let receipt

  // call to init function
  console.log('Calling diamond cut')
  let functionCall = diamondInit.interface.encodeFunctionData('init')
  tx = await DiamondCut.diamondCut(cut, diamondInit.address, functionCall)
  console.log('Diamond cut tx: ', tx.hash)

  receipt = await tx.wait()

  if (!receipt.status ) {
    throw Error(`Diamond upgrade failed: ${tx.hash}`)
  }
  console.log('Completed diamond cut')

  // Upgrade the addModel function
  await upgradeAddModel(diamond.address)

  return diamond.address
}

// Upgrade only the addModel function
async function upgradeAddModel(diamondAddress) {
  console.log('\nUpgrading addModel function in ModelFactoryFacet...')

  // Deploy the updated ModelFactoryFacetV2
  const ModelFactoryFacetV2 = await ethers.getContractFactory('ModelFactoryFacetV2')
  const modelFactoryFacetV2 = await ModelFactoryFacetV2.deploy()
  await modelFactoryFacetV2.deployed()
  console.log('ModelFactoryFacetV2 deployed:', modelFactoryFacetV2.address)

  // Get the selector for the addModel function
  const selector = modelFactoryFacetV2.interface.getSighash('addModel')
  console.log('Selector for addModel:', selector)

  // Prepare the diamondCut for replacement
  const cut = [
    {
      facetAddress: modelFactoryFacetV2.address,
      action: FacetCutAction.Replace,
      functionSelectors: [selector]
    }
  ]

  // Execute the diamondCut
  const DiamondCut = await ethers.getContractAt('IDiamondCut', diamondAddress)
  const tx = await DiamondCut.diamondCut(cut, ethers.constants.AddressZero, '0x')
  console.log('DiamondCut tx for addModel update:', tx.hash)

  const receipt = await tx.wait()
  if (!receipt.status) {
    throw Error(`DiamondCut for addModel update failed: ${tx.hash}`)
  }
  console.log('addModel function upgraded successfully')
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
  deployDiamond()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error)
      process.exit(1)
    })
}

exports.deployDiamond = deployDiamond
