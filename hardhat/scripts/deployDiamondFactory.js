/* global ethers */
/* eslint prefer-const: "off" */

const { getSelectors, FacetCutAction, getSelector } = require('./libraries/diamond.js');

async function deployDiamond() {
  const accounts = await ethers.getSigners();
  const contractOwner = accounts[0];

  ///////////////////////////// 
  ///// Deployment Stage //////
  ///////////////////////////// 

  // ~~ ~~ Facets ~~ ~~ //
  const FacetNames = [
    'DiamondLoupeFacet',
    'OwnershipFacet',
    'GettersFacet', 
    'ExecLogicFacet', 
    'ModelFactoryFacet' // Update with new ModelFactoryFacetV2 that uses LibAppV2
  ];
  const cut = [];

  for (const FacetName of FacetNames) {
    const Facet = await ethers.getContractFactory(FacetName);
    const facet = await Facet.deploy();
    await facet.deployed();
    
    console.log(`${FacetName} deployed: ${facet.address}`);
    cut.push({
      facetAddress: facet.address,
      action: FacetCutAction.Add,
      functionSelectors: getSelectors(facet)
    });
  }

  // ~~ ~~ DiamondCutFacet ~~ ~~ //
  const DiamondCutFacet = await ethers.getContractFactory('DiamondCutFacet');
  const diamondCutFacet = await DiamondCutFacet.deploy();
  await diamondCutFacet.deployed();
  console.log('DiamondCutFacet deployed:', diamondCutFacet.address);

  // ~~ ~~ Diamond Contract ~~ ~~ //
  const Diamond = await ethers.getContractFactory('Diamond');
  const diamond = await Diamond.deploy(contractOwner.address, diamondCutFacet.address);
  await diamond.deployed();
  console.log('Diamond deployed:', diamond.address);

  // ~~ ~~ DiamondInit Contract ~~ ~~ //
  const DiamondInit = await ethers.getContractFactory('DiamondInit');
  const diamondInit = await DiamondInit.deploy();
  await diamondInit.deployed();
  console.log('DiamondInit deployed:', diamondInit.address);

  ///////////////////////////// 
  ////// Linking Stage ////////
  ///////////////////////////// 

  // Deploy and update LibAppV2
  const LibAppV2 = await ethers.getContractFactory('LibAppV2');
  const libAppV2 = await LibAppV2.deploy();
  await libAppV2.deployed();
  console.log('LibAppV2 deployed:', libAppV2.address);

  // Update Facets
  const ModelFactoryFacetV2 = await ethers.getContractFactory('ModelFactoryFacetV2');
  const modelFactoryFacetV2 = await ModelFactoryFacetV2.deploy(); 
  await modelFactoryFacetV2.deployed();
  console.log('ModelFactoryFacetV2 deployed:', modelFactoryFacetV2.address);

  const ExecLogicFacetV2 = await ethers.getContractFactory('ExecLogicFacetV2');
  const execLogicFacetV2 = await ExecLogicFacetV2.deploy();
  await execLogicFacetV2.deployed();
  console.log('ExecLogicFacetV2 deployed:', execLogicFacetV2.address);

  const GettersFacetV2 = await ethers.getContractFactory('GettersFacetV2');
  const gettersFacetV2 = await GettersFacetV2.deploy();
  await gettersFacetV2.deployed();
  console.log('GettersFacetV2 deployed:', gettersFacetV2.address);

  // Perform the diamond cut to replace the old facets with new ones
  console.log('Diamond Cut:', cut);
  const DiamondCut = await ethers.getContractAt('IDiamondCut', diamond.address);

  // Construct the function call data
  const functionCall = diamondInit.interface.encodeFunctionData('init');

  // Start the diamond cut process
  console.log('Starting diamond cut...');
  let tx = await DiamondCut.diamondCut(cut, diamondInit.address, functionCall);
  console.log('Diamond cut tx:', tx.hash);

  // Wait for transaction receipt
  let receipt = await tx.wait();
  if (!receipt.status) {
    throw Error(`Diamond upgrade failed: ${tx.hash}`);
  }
  console.log('Completed diamond cut');

  return diamond.address;
}

// Export the deployDiamond function
exports.deployDiamond = deployDiamond;

