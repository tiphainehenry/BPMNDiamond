const { deployDiamond } = require('../../scripts/deployDiamondFactory.js')




describe('mesureGasDiamondSecuRoutiere', async function () {
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
          "nodeType": 0,
          "xmlID": "Activity_02tq2it",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 1,
          "nodeType": 0,
          "xmlID": "Activity_1quc8tv",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 2,
          "nodeType": 0,
          "xmlID": "Activity_01ys8qs",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 3,
          "nodeType": 0,
          "xmlID": "Activity_0cqwmvc",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 4,
          "nodeType": 0,
          "xmlID": "Activity_1epgm4c",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 5,
          "nodeType": 0,
          "xmlID": "Activity_0937gma",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 6,
          "nodeType": 0,
          "xmlID": "Activity_0636o50",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 7,
          "nodeType": 0,
          "xmlID": "Activity_00avy5f",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 8,
          "nodeType": 0,
          "xmlID": "Activity_1k1saoy",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 9,
          "nodeType": 0,
          "xmlID": "Activity_05th277",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 10,
          "nodeType": 0,
          "xmlID": "Activity_17iy2ec",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 11,
          "nodeType": 0,
          "xmlID": "Activity_1b596f2",
          "name": "",
          "lane": "PrefetZone",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 12,
          "nodeType": 0,
          "xmlID": "Activity_0ne1v0s",
          "name": "",
          "lane": "PrefetZone",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 13,
          "nodeType": 0,
          "xmlID": "Activity_06oi6j8",
          "name": "",
          "lane": "EMIZDCOZ",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 14,
          "nodeType": 0,
          "xmlID": "StartEvent_1",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 15,
          "nodeType": 0,
          "xmlID": "Event_1ou8xf8",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 16,
          "nodeType": 0,
          "xmlID": "Event_04da35f",
          "name": "",
          "lane": "PrefetZone",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 17,
          "nodeType": 0,
          "xmlID": "Event_1jx8cio",
          "name": "",
          "lane": "EMIZDCOZ",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 18,
          "nodeType": 0,
          "xmlID": "Event_02ba84a",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 19,
          "nodeType": 0,
          "xmlID": "Event_0cxqtgz",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 20,
          "nodeType": 0,
          "xmlID": "Event_18icfer",
          "name": "",
          "lane": "PrefetZone",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 21,
          "nodeType": 0,
          "xmlID": "Event_19uszpk",
          "name": "",
          "lane": "EMIZDCOZ",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 22,
          "nodeType": 0,
          "xmlID": "Gateway_0az2hc7",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 23,
          "nodeType": 0,
          "xmlID": "Gateway_0salem5",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 24,
          "nodeType": 0,
          "xmlID": "Gateway_1s0ed8k",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 25,
          "nodeType": 0,
          "xmlID": "Gateway_09yrc9t",
          "name": "",
          "lane": "CRIRC",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 26,
          "nodeType": 0,
          "xmlID": "Gateway_140fja3",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        },
        {
          "id": 27,
          "nodeType": 0,
          "xmlID": "Gateway_123gcsl",
          "name": "",
          "lane": "CelluleComPref35",
          "dataIn": "",
          "dataOut": "",
          "timestamp": ""
        }
      ]
      const _tabChildrenOptim=[
        [
          "Gateway_1s0ed8k"
        ],
        [
          "Gateway_0salem5"
        ],
        [
          "Gateway_0salem5"
        ],
        [
          "Gateway_09yrc9t"
        ],
        [
          "Gateway_09yrc9t"
        ],
        [
          "Gateway_09yrc9t"
        ],
        [
          "Gateway_09yrc9t"
        ],
        [
          "Gateway_140fja3"
        ],
        [
          "Activity_05th277"
        ],
        [
          "Gateway_123gcsl"
        ],
        [
          "Event_0cxqtgz"
        ],
        [
          "Activity_0ne1v0s"
        ],
        [
          "Event_18icfer"
        ],
        [
          "Event_19uszpk"
        ],
        [
          "Gateway_0az2hc7"
        ],
        [
          "Activity_00avy5f"
        ],
        [
          "Activity_1b596f2"
        ],
        [
          "Activity_06oi6j8"
        ],
        [],
        [],
        [],
        [],
        [
          "Activity_01ys8qs",
          "Activity_1quc8tv"
        ],
        [
          "Activity_02tq2it"
        ],
        [
          "Activity_0cqwmvc",
          "Activity_1epgm4c",
          "Activity_0937gma",
          "Activity_0636o50"
        ],
        [
          "Event_02ba84a"
        ],
        [
          "Activity_1k1saoy"
        ],
        [
          "Activity_17iy2ec"
        ]
      ]
      const _tabParentOptim=  [
        [
          "Gateway_0salem5"
        ],
        [
          "Gateway_0az2hc7"
        ],
        [
          "Gateway_0az2hc7"
        ],
        [
          "Gateway_1s0ed8k"
        ],
        [
          "Gateway_1s0ed8k"
        ],
        [
          "Gateway_1s0ed8k"
        ],
        [
          "Gateway_1s0ed8k"
        ],
        [
          "Event_1ou8xf8"
        ],
        [
          "Gateway_140fja3"
        ],
        [
          "Activity_1k1saoy"
        ],
        [
          "Gateway_123gcsl"
        ],
        [
          "Event_04da35f"
        ],
        [
          "Activity_1b596f2"
        ],
        [
          "Event_1jx8cio"
        ],
        [],
        [],
        [],
        [],
        [
          "Gateway_09yrc9t"
        ],
        [
          "Activity_17iy2ec"
        ],
        [
          "Activity_0ne1v0s"
        ],
        [
          "Activity_06oi6j8"
        ],
        [
          "StartEvent_1"
        ],
        [
          "Activity_1quc8tv",
          "Activity_01ys8qs"
        ],
        [
          "Activity_02tq2it"
        ],
        [
          "Activity_1epgm4c",
          "Activity_0cqwmvc",
          "Activity_0937gma",
          "Activity_0636o50"
        ],
        [
          "Activity_00avy5f"
        ],
        [
          "Activity_05th277"
        ]
      ]
      const _msgInOptim=     [
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
          "Activity_0ne1v0s"
        ],
        [],
        [],
        [],
        [],
        [],
        [
          "Activity_0636o50"
        ],
        [
          "Activity_1k1saoy"
        ],
        [
          "Activity_1epgm4c"
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
        []
      ]
      const _msgOutOptim=   [
        [],
        [],
        [],
        [],
        [
          "Event_1jx8cio"
        ],
        [],
        [
          "Event_1ou8xf8"
        ],
        [],
        [
          "Event_04da35f"
        ],
        [],
        [],
        [],
        [
          "Activity_05th277"
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
        []
      ]
      const _keyReplay=[]
      const _valueReplay=[[]]
      await ModelFactoryFacet.addModel('SecuRoutiere',activities,_tabChildrenOptim,_tabParentOptim,_msgInOptim,_msgOutOptim,_keyReplay,_valueReplay)
      
      let tx = await ModelFactoryFacet.newInstance('SecuRoutiere')
      let receipt = await tx.wait()
      const events = receipt.events;
      const id = events.find(event => event.event === 'instanceId');
      console.log(Number(id.args._id))
      instanceTest =Number(id.args._id)

    })
    it('mesure de Gas avec Abi facet entiere', async () =>{


      await workflowExecution.Invoke(14,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // XOR        
      await workflowExecution.Invoke(22,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // Centraliser
      await workflowExecution.Invoke(2,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // Receptionner communiques
      await workflowExecution.Invoke(1,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // XOR        
      await workflowExecution.Invoke(23,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // Analyser situation 
      await workflowExecution.Invoke(0,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // XOR 
      await workflowExecution.Invoke(24,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // Renseigner
      await workflowExecution.Invoke(4,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // envoyer
      await workflowExecution.Invoke(3,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // informer
      await workflowExecution.Invoke(5,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // informerCellules
      await workflowExecution.Invoke(6,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // xor
      await workflowExecution.Invoke(25,"SecuRoutiere",instanceTest,"CRIRC","","")  
      // end
      await workflowExecution.Invoke(18,"SecuRoutiere",instanceTest,"CRIRC","","")  

      //// EMZDCOZ //// 
      // receive
      await workflowExecution.Invoke(17,"SecuRoutiere",instanceTest,"EMIZDCOZ","","")  
      // receptionner
      await workflowExecution.Invoke(13,"SecuRoutiere",instanceTest,"EMIZDCOZ","","")  
      // end
      await workflowExecution.Invoke(21,"SecuRoutiere",instanceTest,"EMIZDCOZ","","")  

      //// cellule comm //// 
      // receive
      await workflowExecution.Invoke(15,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // receotuinner
      await workflowExecution.Invoke(7,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // xor 
      await workflowExecution.Invoke(26,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // rediger comm 
      await workflowExecution.Invoke(8,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      //receptionner comm 
      await workflowExecution.Invoke(9,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // xor 
      await workflowExecution.Invoke(27,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // publier
      await workflowExecution.Invoke(10,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  
      // end
      await workflowExecution.Invoke(19,"SecuRoutiere",instanceTest,"CelluleComPref35","","")  


      //// prefet zone //// 
      // receive
      await workflowExecution.Invoke(16,"SecuRoutiere",instanceTest,"PrefetZone","","")  
      // receptionner comm
      await workflowExecution.Invoke(11,"SecuRoutiere",instanceTest,"PrefetZone","","")  
      // valider comm 
      await workflowExecution.Invoke(12,"SecuRoutiere",instanceTest,"PrefetZone","","")  
      // end
      await workflowExecution.Invoke(20,"SecuRoutiere",instanceTest,"PrefetZone","","")  


        // await workflowExecution.Invoke(12,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(0,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(1,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(14,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(2,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(15,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(4,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(16,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(5,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(6,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(17,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(7,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(19,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(8,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(18,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(3,"SecuRoutiere",instanceTest,"Role","","")
        // await workflowExecution.Invoke(13,"SecuRoutiere",instanceTest,"Role","","")

        // await workflowExecution.Invoke(0,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(4,"Taille8",instanceTest,"BureauEtude","","")
        // await workflowExecution.Invoke(1,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(7,"Taille8",instanceTest,"VerificateurN1","","")
        // await workflowExecution.Invoke(6,"Taille8",instanceTest,"VerificateurN1","","")

        included = await getterFacet.getIncluded("SecuRoutiere",instanceTest)
        included = included.map(value => Number(value));
        console.log(included)
    })
})