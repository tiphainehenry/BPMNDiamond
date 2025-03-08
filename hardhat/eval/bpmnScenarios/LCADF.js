const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')

let modelName= "LCA"
describe('mesureGasDiamondLCA', async function () {
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
        "xmlID": "Activity_1srhafj",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "{diagram:xxxx}",
        "timestamp": ""
      },
      {
        "id": 1,
        "nodeType": 4,
        "xmlID": "Activity_1u8dcz3",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "{dataForm:xxxx}",
        "timestamp": ""
      },
      {
        "id": 2,
        "nodeType": 4,
        "xmlID": "Activity_1gktsop",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "{dataFormFilledReceived:xxxx,diagramFinalized:xxxx}",
        "dataOut": "{model:xxxx,hypotheses:xxxx}",
        "timestamp": ""
      },
      {
        "id": 3,
        "nodeType": 4,
        "xmlID": "Activity_094illf",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "{SoftwareName:xxxx,model:xxxx,hypotheses:xxxx,SoftwareVersion:xxxx}",
        "dataOut": "{rawResults:xxxx}",
        "timestamp": ""
      },
      {
        "id": 4,
        "nodeType": 4,
        "xmlID": "Activity_1g0jyhn",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "{rawResults:xxxx}",
        "dataOut": "{finalResults:xxxx}",
        "timestamp": ""
      },
      {
        "id": 5,
        "nodeType": 4,
        "xmlID": "Activity_1689lou",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "{finalResults:xxxx}",
        "dataOut": "{report:xxxx}",
        "timestamp": ""
      },
      {
        "id": 6,
        "nodeType": 4,
        "xmlID": "Activity_18zqq4j",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "{dataFormFilled:xxxx}",
        "timestamp": ""
      },
      {
        "id": 7,
        "nodeType": 0,
        "xmlID": "Event_07pjzzj",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 8,
        "nodeType": 0,
        "xmlID": "Event_1ailhr5",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 9,
        "nodeType": 3,
        "xmlID": "Event_0aonam9",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 10,
        "nodeType": 3,
        "xmlID": "Event_0gtubjz",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 11,
        "nodeType": 3,
        "xmlID": "Event_126f47n",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 12,
        "nodeType": 3,
        "xmlID": "Event_1l9b7n8",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 13,
        "nodeType": 3,
        "xmlID": "Event_0afzwvl",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 14,
        "nodeType": 3,
        "xmlID": "Event_0tiesg4",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 15,
        "nodeType": 3,
        "xmlID": "Event_1xren83",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 16,
        "nodeType": 3,
        "xmlID": "Event_1vci38q",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 17,
        "nodeType": 1,
        "xmlID": "Event_05mhssw",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 18,
        "nodeType": 5,
        "xmlID": "Gateway_0cxdlki",
        "name": "",
        "lane": "LCA expert",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 19,
        "nodeType": 5,
        "xmlID": "Gateway_0jau4ji",
        "name": "",
        "lane": "Client",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      }
    ]
    const _tabChildrenOptim=[
      [
        "Event_0aonam9"
      ],
      [
        "Event_1xren83"
      ],
      [
        "Activity_094illf"
      ],
      [
        "Activity_1g0jyhn"
      ],
      [
        "Activity_1689lou"
      ],
      [
        "Event_05mhssw"
      ],
      [
        "Event_0afzwvl"
      ],
      [
        "Activity_1srhafj"
      ],
      [
        "Gateway_0jau4ji"
      ],
      [
        "Event_0tiesg4"
      ],
      [],
      [],
      [
        "Activity_18zqq4j"
      ],
      [
        "Event_1vci38q"
      ],
      [
        "Activity_1u8dcz3"
      ],
      [
        "Gateway_0cxdlki"
      ],
      [],
      [],
      [
        "Activity_1gktsop",
        "Event_0gtubjz"
      ],
      [
        "Event_126f47n",
        "Event_1l9b7n8"
      ]
    ]
    const _tabParentOptim=  [
      [
        "Event_07pjzzj"
      ],
      [
        "Event_0tiesg4"
      ],
      [
        "Gateway_0cxdlki"
      ],
      [
        "Activity_1gktsop"
      ],
      [
        "Activity_094illf"
      ],
      [
        "Activity_1g0jyhn"
      ],
      [
        "Event_1l9b7n8"
      ],
      [],
      [],
      [
        "Activity_1srhafj"
      ],
      [
        "Gateway_0cxdlki"
      ],
      [
        "Gateway_0jau4ji"
      ],
      [
        "Gateway_0jau4ji"
      ],
      [
        "Activity_18zqq4j"
      ],
      [
        "Event_0aonam9"
      ],
      [
        "Activity_1u8dcz3"
      ],
      [
        "Event_0afzwvl"
      ],
      [
        "Activity_1689lou"
      ],
      [
        "Event_1xren83"
      ],
      [
        "Event_1ailhr5"
      ]
    ]
    const _msgInOptim=  [
      [
        "Event_126f47n"
      ],
      [],
      [],
      [],
      [],
      [],
      [
        "Activity_1u8dcz3",
        "Event_0gtubjz"
      ],
      [],
      [
        "Event_0aonam9"
      ],
      [],
      [],
      [],
      [],
      [],
      [
        "Event_1l9b7n8"
      ],
      [
        "Event_0afzwvl"
      ],
      [
        "Activity_1689lou"
      ],
      [],
      [],
      []
    ]
    const _msgOutOptim= [
      [],
      [
        "Activity_18zqq4j"
      ],
      [],
      [],
      [],
      [
        "Event_1vci38q"
      ],
      [],
      [],
      [],
      [
        "Event_1ailhr5"
      ],
      [
        "Activity_18zqq4j"
      ],
      [
        "Activity_1srhafj"
      ],
      [
        "Event_0tiesg4"
      ],
      [
        "Event_1xren83"
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
    instanceTest =Number(id.args._id)
    })
    it('mesure de Gas avec Abi facet entiere', async () =>{ 

        await workflowExecution.Invoke(7,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(0,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(9,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(8,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(19,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(11,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(12,modelName,instanceTest,"Client","","")
        await workflowExecution.Invoke(10,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(0,modelName,instanceTest,"LCA expert","","")
        await workflowExecution.Invoke(9,modelName,instanceTest,"LCA expert","","")


        included = await getterFacet.getIncluded(modelName,instanceTest)
        included = included.map(value => Number(value));
        console.log(included)

    })
})