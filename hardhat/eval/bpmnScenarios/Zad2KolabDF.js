const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')

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


describe('mesureGasDiamondZad2Kolab', async function () {
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

    activities = [
      {
        "id": 0,
        "nodeType": 4,
        "xmlID": "Activity_1srhafj",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 1,
        "nodeType": 4,
        "xmlID": "Activity_079gz74",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 2,
        "nodeType": 4,
        "xmlID": "Activity_0ab2fst",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 3,
        "nodeType": 4,
        "xmlID": "Activity_1lihfh5",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 4,
        "nodeType": 4,
        "xmlID": "Activity_014h9o1",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 5,
        "nodeType": 4,
        "xmlID": "Activity_16mflyw",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 6,
        "nodeType": 4,
        "xmlID": "Activity_1jn8sv3",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 7,
        "nodeType": 4,
        "xmlID": "Activity_1dri4q3",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 8,
        "nodeType": 4,
        "xmlID": "Activity_0nkdkfx",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 9,
        "nodeType": 4,
        "xmlID": "Activity_1codthm",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 10,
        "nodeType": 4,
        "xmlID": "Activity_1ahho0f",
        "name": "",
        "lane": "Sluzba za izradu kartica",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 11,
        "nodeType": 0,
        "xmlID": "Event_07pjzzj",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 12,
        "nodeType": 0,
        "xmlID": "Event_1ailhr5",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 13,
        "nodeType": 0,
        "xmlID": "Event_1qhsgh4",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 14,
        "nodeType": 0,
        "xmlID": "Event_1el27dt",
        "name": "",
        "lane": "Sluzba za izradu kartica",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 15,
        "nodeType": 3,
        "xmlID": "Event_0aonam9",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 16,
        "nodeType": 3,
        "xmlID": "Event_0km72bd",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 17,
        "nodeType": 3,
        "xmlID": "Event_1l9b7n8",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 18,
        "nodeType": 3,
        "xmlID": "Event_0665nzt",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 19,
        "nodeType": 3,
        "xmlID": "Event_0ce1833",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 20,
        "nodeType": 3,
        "xmlID": "Event_1m5jwhh",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 21,
        "nodeType": 3,
        "xmlID": "Event_0iiw5d3",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 22,
        "nodeType": 3,
        "xmlID": "Event_12yx8iq",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 23,
        "nodeType": 3,
        "xmlID": "Event_0tiesg4",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 24,
        "nodeType": 3,
        "xmlID": "Event_0n8usxs",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 25,
        "nodeType": 3,
        "xmlID": "Event_00wk5t0",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 26,
        "nodeType": 3,
        "xmlID": "Event_0csocgv",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 27,
        "nodeType": 3,
        "xmlID": "Event_1qb41xx",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 28,
        "nodeType": 3,
        "xmlID": "Event_1g5wtob",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 29,
        "nodeType": 3,
        "xmlID": "Event_05wnvqp",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 30,
        "nodeType": 3,
        "xmlID": "Event_09w8kd3",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 31,
        "nodeType": 1,
        "xmlID": "Event_16uro6j",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 32,
        "nodeType": 1,
        "xmlID": "Event_0o6iie7",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 33,
        "nodeType": 1,
        "xmlID": "Event_09b4brt",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 34,
        "nodeType": 1,
        "xmlID": "Event_15wqldz",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 35,
        "nodeType": 1,
        "xmlID": "Event_04tl72l",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 36,
        "nodeType": 1,
        "xmlID": "Event_11cbi93",
        "name": "",
        "lane": "Sluzba za izradu kartica",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 37,
        "nodeType": 5,
        "xmlID": "Gateway_0baiti1",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 38,
        "nodeType": 5,
        "xmlID": "Gateway_1xp1d08",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 39,
        "nodeType": 5,
        "xmlID": "Gateway_1wzv0n7",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 40,
        "nodeType": 5,
        "xmlID": "Gateway_0tsfn3b",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 41,
        "nodeType": 5,
        "xmlID": "Gateway_01hrjpm",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 42,
        "nodeType": 5,
        "xmlID": "Gateway_0oyn87e",
        "name": "",
        "lane": "Menadzer",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 43,
        "nodeType": 6,
        "xmlID": "Gateway_0x8dzy1",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 44,
        "nodeType": 6,
        "xmlID": "Gateway_08u5ndn",
        "name": "",
        "lane": "Sluzbenik",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      }
    ]
    _tabChildrenOptim= [
      [
        "Event_0aonam9"
      ],
      [
        "Gateway_0baiti1"
      ],
      [
        "Gateway_1xp1d08"
      ],
      [
        "Gateway_0x8dzy1"
      ],
      [
        "Gateway_0x8dzy1"
      ],
      [
        "Gateway_1wzv0n7"
      ],
      [
        "Gateway_0tsfn3b"
      ],
      [
        "Gateway_0tsfn3b"
      ],
      [
        "Gateway_0oyn87e"
      ],
      [
        "Event_12yx8iq"
      ],
      [
        "Event_11cbi93"
      ],
      [
        "Activity_1srhafj"
      ],
      [
        "Gateway_08u5ndn"
      ],
      [
        "Activity_0nkdkfx"
      ],
      [
        "Activity_1ahho0f"
      ],
      [
        "Gateway_0baiti1"
      ],
      [
        "Activity_079gz74"
      ],
      [],
      [
        "Event_1qb41xx"
      ],
      [
        "Gateway_01hrjpm"
      ],
      [],
      [],
      [
        "Event_09w8kd3"
      ],
      [
        "Event_16uro6j"
      ],
      [
        "Event_0km72bd"
      ],
      [
        "Event_0o6iie7"
      ],
      [
        "Event_09b4brt"
      ],
      [
        "Activity_1jn8sv3"
      ],
      [
        "Event_1m5jwhh"
      ],
      [
        "Event_0iiw5d3"
      ],
      [
        "Event_04tl72l"
      ],
      [],
      [],
      [],
      [],
      [],
      [],
      [
        "Event_0tiesg4",
        "Event_0csocgv",
        "Event_00wk5t0"
      ],
      [
        "Event_1l9b7n8",
        "Activity_16mflyw"
      ],
      [
        "Event_0665nzt",
        "Activity_1dri4q3"
      ],
      [
        "Event_0ce1833"
      ],
      [
        "Event_1g5wtob",
        "Event_05wnvqp"
      ],
      [
        "Event_15wqldz",
        "Activity_1codthm"
      ],
      [
        "Activity_0ab2fst"
      ],
      [
        "Activity_014h9o1",
        "Activity_1lihfh5"
      ]
    ]
    _tabParentOptim= [
      [
        "Event_07pjzzj"
      ],
      [
        "Event_0km72bd"
      ],
      [
        "Gateway_0x8dzy1"
      ],
      [
        "Gateway_08u5ndn"
      ],
      [
        "Gateway_08u5ndn"
      ],
      [
        "Gateway_1xp1d08"
      ],
      [
        "Event_1qb41xx"
      ],
      [
        "Gateway_1wzv0n7"
      ],
      [
        "Event_1qhsgh4"
      ],
      [
        "Gateway_0oyn87e"
      ],
      [
        "Event_1el27dt"
      ],
      [],
      [],
      [],
      [],
      [
        "Activity_1srhafj"
      ],
      [
        "Event_0n8usxs"
      ],
      [
        "Gateway_1xp1d08"
      ],
      [
        "Gateway_1wzv0n7"
      ],
      [
        "Gateway_0tsfn3b"
      ],
      [
        "Event_1g5wtob"
      ],
      [
        "Event_05wnvqp"
      ],
      [
        "Activity_1codthm"
      ],
      [
        "Gateway_0baiti1"
      ],
      [],
      [
        "Gateway_0baiti1"
      ],
      [
        "Gateway_0baiti1"
      ],
      [
        "Event_0665nzt"
      ],
      [
        "Gateway_01hrjpm"
      ],
      [
        "Gateway_01hrjpm"
      ],
      [
        "Event_12yx8iq"
      ],
      [
        "Event_0tiesg4"
      ],
      [
        "Event_00wk5t0"
      ],
      [
        "Event_0csocgv"
      ],
      [
        "Gateway_0oyn87e"
      ],
      [
        "Event_09w8kd3"
      ],
      [
        "Activity_1ahho0f"
      ],
      [
        "Event_0aonam9",
        "Activity_079gz74"
      ],
      [
        "Activity_0ab2fst"
      ],
      [
        "Activity_16mflyw"
      ],
      [
        "Activity_1jn8sv3",
        "Activity_1dri4q3"
      ],
      [
        "Event_0ce1833"
      ],
      [
        "Activity_0nkdkfx"
      ],
      [
        "Activity_014h9o1",
        "Activity_1lihfh5"
      ],
      [
        "Event_1ailhr5"
      ]
    ],
    _msgInOptim= [
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
        "Event_0aonam9"
      ],
      [
        "Event_0ce1833"
      ],
      [
        "Event_12yx8iq"
      ],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [
        "Event_1l9b7n8"
      ],
      [
        "Event_0665nzt"
      ],
      [
        "Event_0iiw5d3"
      ],
      [
        "Event_1m5jwhh"
      ],
      [
        "Event_0km72bd"
      ],
      [
        "Event_15wqldz"
      ],
      [
        "Event_04tl72l"
      ],
      [
        "Event_11cbi93"
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
      [],
      [],
      []
    ],
    _msgOutOptim= [
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
        "Event_1ailhr5"
      ],
      [
        "Event_1qb41xx"
      ],
      [
        "Event_0tiesg4"
      ],
      [
        "Event_0n8usxs"
      ],
      [
        "Event_1qhsgh4"
      ],
      [
        "Event_0csocgv"
      ],
      [
        "Event_00wk5t0"
      ],
      [
        "Event_1el27dt"
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
      [
        "Event_1g5wtob"
      ],
      [
        "Event_05wnvqp"
      ],
      [
        "Event_09w8kd3"
      ],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      []
    ]

      const _keyReplay=[]
      const _valueReplay=[[]]


      await ModelFactoryFacet.addModel('Zad2Kolab',activities,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      
      let tx = await ModelFactoryFacet.newInstance('Zad2Kolab')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{

      let modelName = 'Zad2Kolab'

      await workflowExecution.Invoke(11, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(12, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(13, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(14, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
      await workflowExecution.Invoke(8, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(10, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
      await workflowExecution.Invoke(44, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(3, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(4, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(36, modelName, instanceTest, "Sluzba za izradu kartica", "", "");
      await workflowExecution.Invoke(42, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(9, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(34, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(35, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(43, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(2, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(21, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(22, modelName, instanceTest, "Menadzer", "", "");
      await workflowExecution.Invoke(32, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(38, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(5, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(17, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(39, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(7, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(18, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(40, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(19, modelName, instanceTest, "Sluzbenik", "", "");
      await workflowExecution.Invoke(15, modelName, instanceTest, "Student", "", "");

      getIncludedIndices(getterFacet, modelName, instanceTest)


        included = await getterFacet.getIncluded("Zad2Kolab",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})