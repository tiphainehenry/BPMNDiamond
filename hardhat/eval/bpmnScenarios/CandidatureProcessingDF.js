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



describe('mesureGasDiamondCandidatureProcesssing', async function () {
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
        "xmlID": "sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 1,
        "nodeType": 4,
        "xmlID": "sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 2,
        "nodeType": 4,
        "xmlID": "sid-FAF4FBFF-9326-4934-927E-95332452175B",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 3,
        "nodeType": 4,
        "xmlID": "sid-F010C42E-D874-4695-8D91-A414436F1A40",
        "name": "",
        "lane": "Academic recognition agency",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 4,
        "nodeType": 4,
        "xmlID": "sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8",
        "name": "",
        "lane": "Academic committee",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 5,
        "nodeType": 4,
        "xmlID": "sid-8BB0A901-F371-49BC-9A28-E444E639F6B1",
        "name": "",
        "lane": "Academic committee",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 6,
        "nodeType": 4,
        "xmlID": "Activity_0cpaql2",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 7,
        "nodeType": 4,
        "xmlID": "Activity_0aqy0se",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 8,
        "nodeType": 2,
        "xmlID": "sid-F3F51C0A-A26D-4A56-A911-ADE749A03597",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 9,
        "nodeType": 2,
        "xmlID": "sid-0F539557-E946-4D07-A053-624FE0F7A9C5",
        "name": "",
        "lane": "Academic recognition agency",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 10,
        "nodeType": 2,
        "xmlID": "sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9",
        "name": "",
        "lane": "Academic committee",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 11,
        "nodeType": 0,
        "xmlID": "Event_0zrj276",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 12,
        "nodeType": 3,
        "xmlID": "Event_03wddcr",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 13,
        "nodeType": 3,
        "xmlID": "Event_1u0p6vg",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 14,
        "nodeType": 3,
        "xmlID": "Event_11baz0c",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 15,
        "nodeType": 3,
        "xmlID": "Event_19cdlk5",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 16,
        "nodeType": 3,
        "xmlID": "Event_1hhyzwx",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 17,
        "nodeType": 3,
        "xmlID": "Event_04hbmfi",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 18,
        "nodeType": 3,
        "xmlID": "Event_1oq4h3s",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 19,
        "nodeType": 3,
        "xmlID": "Event_17pqln8",
        "name": "",
        "lane": "Academic recognition agency",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 20,
        "nodeType": 3,
        "xmlID": "Event_1xf6yr3",
        "name": "",
        "lane": "Academic committee",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 21,
        "nodeType": 3,
        "xmlID": "Event_1ui4i16",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 22,
        "nodeType": 3,
        "xmlID": "Event_0z6wzdo",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 23,
        "nodeType": 3,
        "xmlID": "Event_0kb0mgy",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 24,
        "nodeType": 3,
        "xmlID": "Event_0wwdqz8",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 25,
        "nodeType": 3,
        "xmlID": "Event_0aaiu74",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 26,
        "nodeType": 3,
        "xmlID": "Event_1wl91q4",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 27,
        "nodeType": 3,
        "xmlID": "Event_1ggxe1u",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 28,
        "nodeType": 3,
        "xmlID": "Event_04xo1k6",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 29,
        "nodeType": 3,
        "xmlID": "Event_0v5b2cd",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 30,
        "nodeType": 3,
        "xmlID": "Event_0tpl3cz",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 31,
        "nodeType": 3,
        "xmlID": "Event_0364blm",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 32,
        "nodeType": 3,
        "xmlID": "Event_0ihqmnf",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 33,
        "nodeType": 1,
        "xmlID": "sid-1505619A-71B5-4CD4-B43B-8A7B3C5FB2A3",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 34,
        "nodeType": 1,
        "xmlID": "sid-F4293FE0-FD92-438F-8F32-9C6E7340237A",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 35,
        "nodeType": 1,
        "xmlID": "sid-F0F0BF89-BB6E-48E2-8554-6C161A792B91",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 36,
        "nodeType": 1,
        "xmlID": "sid-E903D92E-EC93-4CEC-A1E4-57D8157DCB65",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 37,
        "nodeType": 1,
        "xmlID": "sid-5958B3F4-808E-45CC-B274-D851FE52AC05",
        "name": "",
        "lane": "Academic recognition agency",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 38,
        "nodeType": 1,
        "xmlID": "sid-85B4C9C1-9333-459C-BA58-16C5C0941D3C",
        "name": "",
        "lane": "Academic committee",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 39,
        "nodeType": 1,
        "xmlID": "Event_0cg2tgf",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 40,
        "nodeType": 1,
        "xmlID": "Event_0xvdj50",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 41,
        "nodeType": 5,
        "xmlID": "sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 42,
        "nodeType": 5,
        "xmlID": "sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 43,
        "nodeType": 5,
        "xmlID": "sid-7FFDE347-5B92-41DD-B050-71385C21D46B",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 44,
        "nodeType": 5,
        "xmlID": "sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 45,
        "nodeType": 5,
        "xmlID": "Gateway_0tdxbg3",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 46,
        "nodeType": 5,
        "xmlID": "Gateway_1318jda",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 47,
        "nodeType": 5,
        "xmlID": "Gateway_0bnfuj2",
        "name": "",
        "lane": "Student",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 48,
        "nodeType": 4,
        "xmlID": "Condition_195BFBF-17B4-44F3-8447-6225079296D9",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 49,
        "nodeType": 4,
        "xmlID": "Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 50,
        "nodeType": 4,
        "xmlID": "Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 51,
        "nodeType": 4,
        "xmlID": "Condition_AAD65A5-6FB9-41E9-971C-76416F06B577",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 52,
        "nodeType": 4,
        "xmlID": "Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 53,
        "nodeType": 4,
        "xmlID": "Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 54,
        "nodeType": 4,
        "xmlID": "Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      },
      {
        "id": 55,
        "nodeType": 4,
        "xmlID": "Condition_A03919B-2C62-4AB6-8497-3A48255014C2",
        "name": "",
        "lane": "Admission office",
        "dataIn": "",
        "dataOut": "",
        "timestamp": ""
      }
    ]
    const _tabChildrenOptim = [
      [
        "sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"
      ],
      [
        "sid-1505619A-71B5-4CD4-B43B-8A7B3C5FB2A3"
      ],
      [
        "sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"
      ],
      [
        "Event_17pqln8"
      ],
      [
        "sid-8BB0A901-F371-49BC-9A28-E444E639F6B1"
      ],
      [
        "Event_1xf6yr3"
      ],
      [
        "Gateway_0bnfuj2"
      ],
      [
        "Gateway_1318jda"
      ],
      [
        "Event_03wddcr"
      ],
      [
        "sid-F010C42E-D874-4695-8D91-A414436F1A40"
      ],
      [
        "sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8"
      ],
      [
        "Event_1ui4i16"
      ],
      [
        "Event_0wwdqz8"
      ],
      [
        "Event_1ggxe1u"
      ],
      [],
      [
        "sid-F4293FE0-FD92-438F-8F32-9C6E7340237A"
      ],
      [
        "sid-F0F0BF89-BB6E-48E2-8554-6C161A792B91"
      ],
      [
        "Event_1wl91q4"
      ],
      [
        "sid-7FFDE347-5B92-41DD-B050-71385C21D46B"
      ],
      [
        "sid-5958B3F4-808E-45CC-B274-D851FE52AC05"
      ],
      [
        "sid-85B4C9C1-9333-459C-BA58-16C5C0941D3C"
      ],
      [
        "Event_04xo1k6"
      ],
      [
        "Gateway_0tdxbg3"
      ],
      [
        "Gateway_1318jda"
      ],
      [
        "sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"
      ],
      [
        "sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"
      ],
      [
        "sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"
      ],
      [
        "Event_1oq4h3s"
      ],
      [
        "Event_0z6wzdo"
      ],
      [
        "Event_0kb0mgy"
      ],
      [
        "Event_0cg2tgf"
      ],
      [
        "Event_0ihqmnf"
      ],
      [
        "Event_0xvdj50"
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
        "Condition_195BFBF-17B4-44F3-8447-6225079296D9",
        "Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65"
      ],
      [
        "Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61",
        "Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607"
      ],
      [
        "Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702",
        "Condition_A03919B-2C62-4AB6-8497-3A48255014C2"
      ],
      [
        "Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA",
        "Condition_AAD65A5-6FB9-41E9-971C-76416F06B577"
      ],
      [
        "Event_0v5b2cd",
        "Activity_0aqy0se"
      ],
      [
        "Activity_0cpaql2"
      ],
      [
        "Event_0tpl3cz",
        "Event_0364blm"
      ],
      [
        "Event_11baz0c"
      ],
      [
        "Event_04hbmfi"
      ],
      [
        "sid-FAF4FBFF-9326-4934-927E-95332452175B"
      ],
      [
        "Event_19cdlk5"
      ],
      [
        "Event_1hhyzwx"
      ],
      [
        "Event_1u0p6vg"
      ],
      [
        "sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"
      ],
      [
        "sid-E903D92E-EC93-4CEC-A1E4-57D8157DCB65"
      ]
    ]
    const _tabParentOptim = [
      [
        "Event_0wwdqz8",
        "Event_0aaiu74"
      ],
      [
        "Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702"
      ],
      [
        "Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA"
      ],
      [
        "sid-0F539557-E946-4D07-A053-624FE0F7A9C5"
      ],
      [
        "sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9"
      ],
      [
        "sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8"
      ],
      [
        "Gateway_1318jda"
      ],
      [
        "Gateway_0tdxbg3"
      ],
      [],
      [],
      [],
      [],
      [
        "sid-F3F51C0A-A26D-4A56-A911-ADE749A03597"
      ],
      [
        "Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607"
      ],
      [
        "Condition_195BFBF-17B4-44F3-8447-6225079296D9"
      ],
      [
        "Condition_AAD65A5-6FB9-41E9-971C-76416F06B577"
      ],
      [
        "Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61"
      ],
      [
        "Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65"
      ],
      [
        "Event_1ggxe1u"
      ],
      [
        "sid-F010C42E-D874-4695-8D91-A414436F1A40"
      ],
      [
        "sid-8BB0A901-F371-49BC-9A28-E444E639F6B1"
      ],
      [
        "Event_0zrj276"
      ],
      [
        "Event_04xo1k6"
      ],
      [
        "Event_0v5b2cd"
      ],
      [
        "Event_03wddcr"
      ],
      [],
      [
        "Event_04hbmfi"
      ],
      [
        "Event_1u0p6vg"
      ],
      [
        "Event_1ui4i16"
      ],
      [
        "Gateway_0tdxbg3"
      ],
      [
        "Gateway_0bnfuj2"
      ],
      [
        "Gateway_0bnfuj2"
      ],
      [
        "Event_0364blm"
      ],
      [
        "sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"
      ],
      [
        "Event_19cdlk5"
      ],
      [
        "Event_1hhyzwx"
      ],
      [
        "Condition_A03919B-2C62-4AB6-8497-3A48255014C2"
      ],
      [
        "Event_17pqln8"
      ],
      [
        "Event_1xf6yr3"
      ],
      [
        "Event_0tpl3cz"
      ],
      [
        "Event_0ihqmnf"
      ],
      [
        "sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"
      ],
      [
        "sid-FAF4FBFF-9326-4934-927E-95332452175B"
      ],
      [
        "Event_1oq4h3s"
      ],
      [
        "Event_1wl91q4"
      ],
      [
        "Event_0z6wzdo"
      ],
      [
        "Activity_0aqy0se",
        "Event_0kb0mgy"
      ],
      [
        "Activity_0cpaql2"
      ],
      [
        "sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"
      ],
      [
        "sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"
      ],
      [
        "sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"
      ],
      [
        "sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"
      ],
      [
        "sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"
      ],
      [
        "sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"
      ],
      [
        "sid-7FFDE347-5B92-41DD-B050-71385C21D46B"
      ],
      [
        "sid-7FFDE347-5B92-41DD-B050-71385C21D46B"
      ]
    ]
    const _msgInOptim = [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [
        "Event_1ui4i16"
      ],
      [
        "Event_04hbmfi"
      ],
      [
        "Event_1u0p6vg"
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
      [
        "Event_0z6wzdo"
      ],
      [
        "Event_0kb0mgy"
      ],
      [
        "Event_17pqln8"
      ],
      [
        "Event_1xf6yr3"
      ],
      [
        "Event_03wddcr"
      ],
      [
        "Event_11baz0c"
      ],
      [
        "Event_19cdlk5",
        "Event_1hhyzwx"
      ],
      [
        "Event_1oq4h3s"
      ],
      [
        "sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"
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
    const _msgOutOptim = [
      [],
      [
        "Event_0ihqmnf"
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
      [
        "Event_04xo1k6"
      ],
      [
        "sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9"
      ],
      [
        "Event_0v5b2cd"
      ],
      [
        "Event_0tpl3cz"
      ],
      [
        "Event_0tpl3cz"
      ],
      [
        "sid-0F539557-E946-4D07-A053-624FE0F7A9C5"
      ],
      [
        "Event_0364blm"
      ],
      [
        "Event_1wl91q4"
      ],
      [
        "Event_1ggxe1u"
      ],
      [
        "sid-F3F51C0A-A26D-4A56-A911-ADE749A03597"
      ],
      [
        "Event_0wwdqz8"
      ],
      [
        "Event_0aaiu74"
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
      []
    ]

    const _keyReplay=[]
    const _valueReplay=[[]]

    await ModelFactoryFacet.addModel('CandidatureProcesssing',activities,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      
    let tx = await ModelFactoryFacet.newInstance('CandidatureProcesssing')
    let receipt = await tx.wait()
    const events = receipt.events;
    const id = events.find(event => event.event === 'instanceId');
    console.log(Number(id.args._id))
    instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{
      modelName = 'CandidatureProcesssing'
      // await workflowExecution.Invoke(11, modelName, instanceTest, "Student", "", "");
      // await workflowExecution.Invoke(21, modelName, instanceTest, "Student", "", "");
      // await workflowExecution.Invoke(12, modelName, instanceTest, "Admission office", "", "");
      // await workflowExecution.Invoke(22, modelName, instanceTest, "Student", "", "");
      // await workflowExecution.Invoke(14, modelName, instanceTest, "Admission office", "", "");
      // await workflowExecution.Invoke(41, modelName, instanceTest, "Admission office", "", "");


      await workflowExecution.Invoke(11, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(21, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(12, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(0, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(22, modelName, instanceTest, "Student", "", "");
      await workflowExecution.Invoke(0, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(41, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(42, modelName, instanceTest, "Admission office", "", "");

      await workflowExecution.Invoke(48, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(49, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(14, modelName, instanceTest, "Admission office", "", "");
      await workflowExecution.Invoke(23, modelName, instanceTest, "Student", "", "");

      // await processus.Invoke(11, "Student", "", "");
      // await processus.Invoke(21, "Student", "", "");
      // await processus.Invoke(12, "Admission office", "", "");
      // await processus.Invoke(0, "Admission office", "", "");
      // await processus.Invoke(22, "Student", "", "");
      // await processus.Invoke(0, "Admission office", "", "");
      // await processus.Invoke(41, "Admission office", "", "");
      // await processus.Invoke(42, "Admission office", "", "");


      getIncludedIndices(getterFacet, modelName, instanceTest) 


      included = await getterFacet.getIncluded("CandidatureProcesssing",instanceTest)
      included = included.map(value => Number(value));
      console.log(included)
    })
})