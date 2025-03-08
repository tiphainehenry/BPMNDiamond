const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')

describe('mesureGasDiamondBulkBuyer', async function () {
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
      {
        "id": 0,
        "nodeType": 4,
        "xmlID": "Activity_178wke6",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 1,
        "nodeType": 4,
        "xmlID": "Activity_1mrdk79",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 2,
        "nodeType": 4,
        "xmlID": "Activity_0ovq3ir",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 3,
        "nodeType": 4,
        "xmlID": "Activity_0vlpyy8",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 4,
        "nodeType": 0,
        "xmlID": "Event_0pcb7d6",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 5,
        "nodeType": 0,
        "xmlID": "Event_0iwx1uw",
        "name": "",
        "lane": "Middleman",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 6,
        "nodeType": 0,
        "xmlID": "Event_1q8uj2b",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 7,
        "nodeType": 0,
        "xmlID": "Event_0jqvh7b",
        "name": "",
        "lane": "SpecialCarrier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 8,
        "nodeType": 0,
        "xmlID": "StartEvent_1lkfg28",
        "name": "",
        "lane": "BulkBuyer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 9,
        "nodeType": 3,
        "xmlID": "Event_0n62fcs",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 10,
        "nodeType": 3,
        "xmlID": "Event_1jqivmy",
        "name": "",
        "lane": "Middleman",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 11,
        "nodeType": 3,
        "xmlID": "Event_13wma2m",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 12,
        "nodeType": 3,
        "xmlID": "Event_17eoxje",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 13,
        "nodeType": 3,
        "xmlID": "Event_0fot2yq",
        "name": "",
        "lane": "SpecialCarrier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 14,
        "nodeType": 3,
        "xmlID": "Event_06rrlqx",
        "name": "",
        "lane": "BulkBuyer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 15,
        "nodeType": 3,
        "xmlID": "Event_1prk2c6",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 16,
        "nodeType": 3,
        "xmlID": "Event_17exiyo",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 17,
        "nodeType": 3,
        "xmlID": "Event_0nt2tgj",
        "name": "",
        "lane": "SpecialCarrier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 18,
        "nodeType": 3,
        "xmlID": "Event_16mfcnh",
        "name": "",
        "lane": "SpecialCarrier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 19,
        "nodeType": 3,
        "xmlID": "Event_0gfzx5o",
        "name": "",
        "lane": "BulkBuyer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 20,
        "nodeType": 3,
        "xmlID": "Event_041xu64",
        "name": "",
        "lane": "BulkBuyer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 21,
        "nodeType": 1,
        "xmlID": "Event_13ln24e",
        "name": "",
        "lane": "Supplier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 22,
        "nodeType": 1,
        "xmlID": "Event_0djujna",
        "name": "",
        "lane": "Middleman",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 23,
        "nodeType": 1,
        "xmlID": "Event_06fjnih",
        "name": "",
        "lane": "Manufactturer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 24,
        "nodeType": 1,
        "xmlID": "Event_18n5vxd",
        "name": "",
        "lane": "SpecialCarrier",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 25,
        "nodeType": 1,
        "xmlID": "Event_0ozw3la",
        "name": "",
        "lane": "BulkBuyer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      }
    ]
      

      const _tabChildrenOptim=[
        [
          "Event_1prk2c6"
        ],
        [
          "Activity_178wke6"
        ],
        [
          "Event_06fjnih"
        ],
        [
          "Event_17eoxje"
        ],
        [
          "Activity_1mrdk79"
        ],
        [
          "Event_1jqivmy"
        ],
        [
          "Activity_0vlpyy8"
        ],
        [
          "Event_0fot2yq"
        ],
        [
          "Event_06rrlqx"
        ],
        [
          "Event_13ln24e"
        ],
        [
          "Event_0djujna"
        ],
        [
          "Activity_0ovq3ir"
        ],
        [
          "Event_17exiyo"
        ],
        [
          "Event_0nt2tgj"
        ],
        [
          "Event_041xu64"
        ],
        [
          "Event_0n62fcs"
        ],
        [
          "Event_13wma2m"
        ],
        [
          "Event_16mfcnh"
        ],
        [
          "Event_18n5vxd"
        ],
        [
          "Event_0ozw3la"
        ],
        [
          "Event_0gfzx5o"
        ],
        [],
        [],
        [],
        [],
        []
      ]
      const _tabParentOptim= [
        [
          "Activity_1mrdk79"
        ],
        [
          "Event_0pcb7d6"
        ],
        [
          "Event_13wma2m"
        ],
        [
          "Event_1q8uj2b"
        ],
        [],
        [],
        [],
        [],
        [],
        [
          "Event_1prk2c6"
        ],
        [
          "Event_0iwx1uw"
        ],
        [
          "Event_17exiyo"
        ],
        [
          "Activity_0vlpyy8"
        ],
        [
          "Event_0jqvh7b"
        ],
        [
          "StartEvent_1lkfg28"
        ],
        [
          "Activity_178wke6"
        ],
        [
          "Event_17eoxje"
        ],
        [
          "Event_0fot2yq"
        ],
        [
          "Event_0nt2tgj"
        ],
        [
          "Event_041xu64"
        ],
        [
          "Event_06rrlqx"
        ],
        [
          "Event_0n62fcs"
        ],
        [
          "Event_1jqivmy"
        ],
        [
          "Activity_0ovq3ir"
        ],
        [
          "Event_16mfcnh"
        ],
        [
          "Event_0gfzx5o"
        ]
      ]
      const _msgInOptim = [
        [],
        [],
        [],
        [],
        [
          "Event_1jqivmy"
        ],
        [
          "Event_17eoxje"
        ],
        [
          "Event_06rrlqx"
        ],
        [
          "Event_0djujna"
        ],
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        [
          "Event_0fot2yq"
        ],
        [
          "Event_18n5vxd"
        ],
        [
          "Event_0n62fcs"
        ],
        [
          "Event_13ln24e"
        ],
        [
          "Event_06fjnih"
        ],
        [
          "Event_13wma2m"
        ],
        [],
        [],
        [],
        [],
        []
      ]
      const _msgOutOptim = [
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
          "Event_0nt2tgj"
        ],
        [
          "Event_0pcb7d6"
        ],
        [
          "Event_041xu64"
        ],
        [
          "Event_0iwx1uw"
        ],
        [
          "Event_1prk2c6"
        ],
        [
          "Event_1q8uj2b"
        ],
        [],
        [],
        [],
        [],
        [],
        [],
        [
          "Event_16mfcnh"
        ],
        [
          "Event_0jqvh7b"
        ],
        [
          "Event_0gfzx5o"
        ],
        [
          "Event_17exiyo"
        ],
        []
      ]

      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('BulkBuyer',activity,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      let tx = await ModelFactoryFacet.newInstance('BulkBuyer')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)
    })
    it('mesure de Gas avec Abi facet entiere', async () =>{
        let included = await getterFacet.getIncluded("BulkBuyer",instanceTest)
        let executed = await getterFacet.getExecuted("BulkBuyer",instanceTest)
        let pending = await getterFacet.getPending("BulkBuyer",instanceTest)
        included = included.map(value => Number(value));
        executed = executed.map(value => Number(value));
        pending = pending.map(value => Number(value));

        await workflowExecution.Invoke(8,"BulkBuyer",instanceTest,"BulkBuyer","","")
        // sendOrder
        await workflowExecution.Invoke(14,"BulkBuyer",instanceTest,"BulkBuyer","","")
        // production start
        await workflowExecution.Invoke(20,"BulkBuyer",instanceTest,"BulkBuyer","","")
        // productionend*
        await workflowExecution.Invoke(19,"BulkBuyer",instanceTest,"BulkBuyer","","")
        // end
        await workflowExecution.Invoke(25,"BulkBuyer",instanceTest,"BulkBuyer","","")

        ////// Manufacturer /////
        // orderfromBulkB
        await workflowExecution.Invoke(6,"BulkBuyer",instanceTest,"Manufactturer","","")
        //cakculate demand
        await workflowExecution.Invoke(3,"BulkBuyer",instanceTest,"Manufactturer","","")
        // place order
        await workflowExecution.Invoke(12,"BulkBuyer",instanceTest,"Manufactturer","","")
        // receive order
        await workflowExecution.Invoke(16,"BulkBuyer",instanceTest,"Manufactturer","","")
        //reportstart
        await workflowExecution.Invoke(11,"BulkBuyer",instanceTest,"Manufactturer","","")
        //produce
        await workflowExecution.Invoke(2,"BulkBuyer",instanceTest,"Manufactturer","","")
        // msg end
        await workflowExecution.Invoke(23,"BulkBuyer",instanceTest,"Manufactturer","","")

        //////// Middleman/////
        // order form manu
        await workflowExecution.Invoke(5,"BulkBuyer",instanceTest,"Middleman","","")
        // fwdorder
        await workflowExecution.Invoke(10,"BulkBuyer",instanceTest,"Middleman","","")
        // ordertransport
        await workflowExecution.Invoke(22,"BulkBuyer",instanceTest,"Middleman","","")


        //////// Special Carrier/////
        // order transport
        await workflowExecution.Invoke(7,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        // request
        await workflowExecution.Invoke(13,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        // receivedetail
        await workflowExecution.Invoke(17,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        //receivewayb
        await workflowExecution.Invoke(18,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        // deliver order
        await workflowExecution.Invoke(24,"BulkBuyer",instanceTest,"SpecialCarrier","","")

        //////// Supplier/////
        // order suply
        await workflowExecution.Invoke(4,"BulkBuyer",instanceTest,"Supplier","","")
        // produce
        await workflowExecution.Invoke(1,"BulkBuyer",instanceTest,"Supplier","","")
        // prepare transport
        await workflowExecution.Invoke(0,"BulkBuyer",instanceTest,"Supplier","","")
        // receive req
        await workflowExecution.Invoke(15,"BulkBuyer",instanceTest,"Supplier","","")
        // provide details
        await workflowExecution.Invoke(9,"BulkBuyer",instanceTest,"Supplier","","")
        await workflowExecution.Invoke(21,"BulkBuyer",instanceTest,"Supplier","","")        
        await workflowExecution.Invoke(18,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        await workflowExecution.Invoke(24,"BulkBuyer",instanceTest,"SpecialCarrier","","")
        await workflowExecution.Invoke(11,"BulkBuyer",instanceTest,"Manufactturer","","")
        await workflowExecution.Invoke(19,"BulkBuyer",instanceTest,"BulkBuyer","","")
        await workflowExecution.Invoke(25,"BulkBuyer",instanceTest,"BulkBuyer","","")

        included = await getterFacet.getIncluded("BulkBuyer",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)

    })
})