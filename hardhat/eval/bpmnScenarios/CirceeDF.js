const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')

let modelName= "Circee"

async function getIncludedIndices(getterFacet, modelName, instanceTest) {
  // Fetch the included array and convert elements to numbers
  let included = await getterFacet.getIncluded(modelName, instanceTest);
  included = included.map(value => Number(value));
  console.log("Included array:", included);

  // Find indices where the value is 1
  const indices = included
      .map((value, index) => value === 1 ? index : -1) // Map to index if value is 1, otherwise -1
      .filter(index => index !== -1); // Filter out -1s

  console.log("Indices of ones:", indices);
  return indices;
}

describe('mesureGasDiamondCircee', async function () {
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

    const activities = [
      {
        "id": 0,
        "nodeType": 4,
        "xmlID": "Activity_1w37624",
        "name": "",
        "lane": "Presta_Lasers_type1",
        "dataIn": "{relevesLaserT1:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 1,
        "nodeType": 4,
        "xmlID": "Activity_1phykio",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "{tuyauterie_nuage_points:xxxx}",
        "timestamp": ""
      },
      {
        "id": 2,
        "nodeType": 4,
        "xmlID": "Activity_0q0i9ua",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "{MerkleTreeAnchoringInputs:xxxx}",
        "timestamp": ""
      },
      {
        "id": 3,
        "nodeType": 4,
        "xmlID": "Activity_0yy5yxi",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "{chargements_storage_EDFSP:xxxx}",
        "timestamp": ""
      },
      {
        "id": 4,
        "nodeType": 4,
        "xmlID": "Activity_04bqzb6",
        "name": "",
        "lane": "EDF",
        "dataIn": "{tuyauterie_nuage_points:xxxx}",
        "dataOut": "{Fichier_commande_piping_master:xxxx}",
        "timestamp": ""
      },
      {
        "id": 5,
        "nodeType": 4,
        "xmlID": "Activity_1r4z8q0",
        "name": "",
        "lane": "EDF",
        "dataIn": "{relevesLaserT1:xxxx,infosCentraleT1:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 6,
        "nodeType": 4,
        "xmlID": "Activity_0n6ybe3",
        "name": "",
        "lane": "EDF",
        "dataIn": "{relevesLaserT2:xxxx,infosCentraleT2:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 7,
        "nodeType": 4,
        "xmlID": "Activity_0qxkr87",
        "name": "",
        "lane": "EDF",
        "dataIn": "{chargements_storage_EDFSP:xxxx,MerkleTreeAnchoringInputs:xxxx,Fichier_commande_piping_master:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 8,
        "nodeType": 4,
        "xmlID": "Activity_14i49l1",
        "name": "",
        "lane": "EDF",
        "dataIn": "{Fichier_commande_piping_master:xxxx}",
        "dataOut": "{Fichier_commande_partiel:xxxx}",
        "timestamp": ""
      },
      {
        "id": 9,
        "nodeType": 4,
        "xmlID": "Activity_0wegxvj",
        "name": "",
        "lane": "EDF",
        "dataIn": "{ResultatsCalculFlex:xxxx,NoteCalcul:xxxx}",
        "dataOut": "{ResultatsCalculFlexArchive_storage_GED:xxxx,NoteCalculArchivee_storage_dossierEtude:xxxx}",
        "timestamp": ""
      },
      {
        "id": 10,
        "nodeType": 4,
        "xmlID": "Activity_0bqjss0",
        "name": "",
        "lane": "Presta_Lasers_2",
        "dataIn": "{relevesLaserT2:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 11,
        "nodeType": 4,
        "xmlID": "Activity_0b1xao9",
        "name": "",
        "lane": "BEP",
        "dataIn": "{optionsCalcul:xxxx,Fichier_commande_partiel:xxxx}",
        "dataOut": "{ResultatsCalculFlex:xxxx,NoteCalcul:xxxx}",
        "timestamp": ""
      },
      {
        "id": 12,
        "nodeType": 4,
        "xmlID": "Activity_1qd5ddw",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "{NoteCalculArchivee_storage_dossierEtude:xxxx,ResultatsCalculFlexArchive_storage_GED:xxxx}",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 13,
        "nodeType": 4,
        "xmlID": "Activity_0u6d2a9",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "",
        "dataOut": "{CertificatEtude:xxxx}",
        "timestamp": ""
      },
      {
        "id": 14,
        "nodeType": 4,
        "xmlID": "Activity_1btjbfw",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 15,
        "nodeType": 0,
        "xmlID": "Event_0ingiww",
        "name": "",
        "lane": "Presta_Lasers_type1",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 16,
        "nodeType": 0,
        "xmlID": "Event_0t2k2yb",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 17,
        "nodeType": 0,
        "xmlID": "Event_1m8nrx4",
        "name": "",
        "lane": "Presta_Lasers_2",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 18,
        "nodeType": 0,
        "xmlID": "Event_03x3hs9",
        "name": "",
        "lane": "BEP",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 19,
        "nodeType": 0,
        "xmlID": "Event_1l1eu2i",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 20,
        "nodeType": 3,
        "xmlID": "Event_129q8un",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 21,
        "nodeType": 3,
        "xmlID": "Event_10iqpl6",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 22,
        "nodeType": 3,
        "xmlID": "Event_1wkuekg",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 23,
        "nodeType": 3,
        "xmlID": "Event_0g3nqpl",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 24,
        "nodeType": 3,
        "xmlID": "Event_1yw4jv6",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 25,
        "nodeType": 3,
        "xmlID": "Event_1dc7pwe",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 26,
        "nodeType": 3,
        "xmlID": "Event_095bjm0",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 27,
        "nodeType": 1,
        "xmlID": "Event_1bzza4i",
        "name": "",
        "lane": "Presta_Lasers_type1",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 28,
        "nodeType": 1,
        "xmlID": "Event_0mvm5x8",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 29,
        "nodeType": 1,
        "xmlID": "Event_0fnhvh2",
        "name": "",
        "lane": "Presta_Lasers_2",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 30,
        "nodeType": 1,
        "xmlID": "Event_1b8l7ac",
        "name": "",
        "lane": "BEP",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 31,
        "nodeType": 1,
        "xmlID": "Event_1a716b4",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 32,
        "nodeType": 1,
        "xmlID": "Event_1oshbnx",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 33,
        "nodeType": 5,
        "xmlID": "Gateway_0emtvpg",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 34,
        "nodeType": 5,
        "xmlID": "Gateway_0dfbndb",
        "name": "",
        "lane": "ASN_ou_Organisme_Surete",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 35,
        "nodeType": 6,
        "xmlID": "Gateway_14bqcdn",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 36,
        "nodeType": 6,
        "xmlID": "Gateway_0azmwqm",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 37,
        "nodeType": 6,
        "xmlID": "Gateway_0duxwpz",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 38,
        "nodeType": 6,
        "xmlID": "Gateway_1f36shi",
        "name": "",
        "lane": "EDF",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      }
    ]
    const _tabChildrenOptim=[
        [
          "Event_1bzza4i"
        ],
        [
          "Activity_04bqzb6"
        ],
        [
          "Gateway_0azmwqm"
        ],
        [
          "Gateway_0azmwqm"
        ],
        [
          "Gateway_0azmwqm"
        ],
        [
          "Gateway_1f36shi"
        ],
        [
          "Gateway_1f36shi"
        ],
        [
          "Activity_14i49l1"
        ],
        [
          "Event_1wkuekg"
        ],
        [
          "Event_0g3nqpl"
        ],
        [
          "Event_0fnhvh2"
        ],
        [
          "Event_1b8l7ac"
        ],
        [
          "Gateway_0dfbndb"
        ],
        [
          "Event_1a716b4"
        ],
        [
          "Event_0mvm5x8"
        ],
        [
          "Activity_1w37624"
        ],
        [
          "Gateway_14bqcdn"
        ],
        [
          "Activity_0bqjss0"
        ],
        [
          "Activity_0b1xao9"
        ],
        [
          "Activity_1qd5ddw"
        ],
        [
          "Event_1yw4jv6"
        ],
        [
          "Event_1dc7pwe"
        ],
        [
          "Activity_0wegxvj"
        ],
        [
          "Gateway_0qdpemg"
        ],
        [
          "Activity_0n6ybe3"
        ],
        [
          "Activity_1r4z8q0"
        ],
        [
          "Gateway_0emtvpg"
        ],
        [],
        [],
        [],
        [],
        [],
        [],
        [
          "Activity_14i49l1",
          "Event_1wkuekg"
        ],
        [
          "Event_1oshbnx",
          "Activity_0u6d2a9"
        ],
        [
          "Gateway_0duxwpz",
          "Activity_0yy5yxi",
          "Activity_0q0i9ua"
        ],
        [
          "Activity_0qxkr87"
        ],
        [
          "Event_10iqpl6",
          "Event_129q8un"
        ],
        [
          "Activity_1phykio"
        ]
      ]
    const _tabParentOptim=  [
        [
          "Event_0ingiww"
        ],
        [
          "Gateway_1f36shi"
        ],
        [
          "Gateway_14bqcdn"
        ],
        [
          "Gateway_14bqcdn"
        ],
        [
          "Activity_1phykio"
        ],
        [
          "Event_1dc7pwe"
        ],
        [
          "Event_1yw4jv6"
        ],
        [
          "Gateway_0azmwqm"
        ],
        [
          "Activity_0qxkr87",
          "Gateway_0emtvpg"
        ],
        [
          "Event_1wkuekg"
        ],
        [
          "Event_1m8nrx4"
        ],
        [
          "Event_03x3hs9"
        ],
        [
          "Event_1l1eu2i"
        ],
        [
          "Gateway_0dfbndb"
        ],
        [
          "Gateway_0qdpemg"
        ],
        [],
        [],
        [],
        [],
        [],
        [
          "Gateway_0duxwpz"
        ],
        [
          "Gateway_0duxwpz"
        ],
        [
          "Activity_14i49l1",
          "Gateway_0emtvpg"
        ],
        [
          "Activity_0wegxvj"
        ],
        [
          "Event_129q8un"
        ],
        [
          "Event_10iqpl6"
        ],
        [
          "Gateway_0qdpemg"
        ],
        [
          "Activity_1w37624"
        ],
        [
          "Activity_1btjbfw"
        ],
        [
          "Activity_0bqjss0"
        ],
        [
          "Activity_0b1xao9"
        ],
        [
          "Activity_0u6d2a9"
        ],
        [
          "Gateway_0dfbndb"
        ],
        [
          "Event_095bjm0"
        ],
        [
          "Activity_1qd5ddw"
        ],
        [
          "Event_0t2k2yb"
        ],
        [
          "Activity_04bqzb6",
          "Activity_0q0i9ua",
          "Activity_0yy5yxi"
        ],
        [
          "Gateway_14bqcdn"
        ],
        [
          "Activity_1r4z8q0",
          "Activity_0n6ybe3"
        ]
      ]
    const _msgInOptim= [
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [
          "Event_1a716b4"
        ],
        [
          "Event_10iqpl6"
        ],
        [],
        [
          "Event_129q8un"
        ],
        [
          "Event_1wkuekg"
        ],
        [
          "Event_0g3nqpl"
        ],
        [],
        [],
        [],
        [],
        [
          "Event_0fnhvh2"
        ],
        [
          "Event_1bzza4i"
        ],
        [
          "Event_1oshbnx"
        ],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        []
      ]     
    const _msgOutOptim= [
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [
          "Event_1m8nrx4"
        ],
        [
          "Event_0ingiww"
        ],
        [
          "Event_03x3hs9"
        ],
        [
          "Event_1l1eu2i"
        ],
        [],
        [],
        [],
        [
          "Event_1dc7pwe"
        ],
        [],
        [
          "Event_1yw4jv6"
        ],
        [],
        [
          "Activity_1btjbfw"
        ],
        [
          "Event_095bjm0"
        ],
        [],
        [],
        [],
        [],
        [],
        []
      ]  
    const _keyReplay=[]
    const _valueReplay=[[]]

    await ModelFactoryFacet.addModel(modelName,activities,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)

    let tx = await ModelFactoryFacet.newInstance(modelName)
    let receipt = await tx.wait()
    const events = receipt.events;
    const id = events.find(event => event.event === 'instanceId');
    console.log(Number(id.args._id))
    instanceTest =Number(id.args._id)
    })
    it('mesure de Gas avec Abi facet entiere', async () =>{ 

      await workflowExecution.Invoke(15,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(16,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(17,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(18,modelName,instanceTest,"BEP","","")
      await workflowExecution.Invoke(19,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(0,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(10,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(12,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(35,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(27,modelName,instanceTest,"Presta_Lasers_type1","","")
      await workflowExecution.Invoke(37,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(5,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(20,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(21,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(29,modelName,instanceTest,"Presta_Lasers_2","","")
      await workflowExecution.Invoke(34,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(6,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(13,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(32,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(38,modelName,instanceTest,"EDF","","")
      await workflowExecution.Invoke(13,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(31,modelName,instanceTest,"ASN_ou_Organisme_Surete","","")
      await workflowExecution.Invoke(28,modelName,instanceTest,"EDF","","")

    })
})