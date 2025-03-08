const { deployCaterPillar } = require('../../scripts/deployCaterPillar.js')



describe('mesureGasCaterpillar', async function () {
    let registry
    before(async function () {

    registry= await deployCaterPillar()
    //await deployCaterPillar()

    })
    it('Affiche les address du registry et du worklist', async () =>{
        console.log("registry ",registry[0])
        console.log("worklist ",registry[1])
        console.log('ici')
        const instance = await ethers.getContractAt('BulkBuyer', registry[2])
        let wkList = await ethers.getContractAt('Process_0_WorkList', registry[1])
        let active_place_order_for_supplies_ = await instance.getTaskRequestIndex(2)
        console.log("placeorder",Number(active_place_order_for_supplies_))
        
        await wkList.DefaultTask_callback(0)
        
        console.log("\n after callBack 0")
        let token = await instance.getToken()
        console.log("token",Number(token))  
        let active_a = await instance.getTaskRequestIndex(1)
        console.log("ordergood",Number(active_a))
        active_place_order_for_supplies_ = await instance.getTaskRequestIndex(2)
        console.log("placeorder",Number(active_place_order_for_supplies_))
        active_place_order_for_supplies_ = await instance.getTaskRequestIndex(4)
        console.log("forward order",Number(active_place_order_for_supplies_))
        active_place_order_for_supplies_ = await instance.getTaskRequestIndex(8)
        console.log("fortransport",Number(active_place_order_for_supplies_))

        console.log("\nafter callBack1")
        await wkList.DefaultTask_callback(1)
        token = await instance.getToken()
        console.log("token",Number(token))
        let boucle = await instance.getBoucle()
        console.log("nbBoucle",Number(boucle))
        active_place_order_for_supplies_ = await instance.getTaskRequestIndex(4)
        console.log("forward order",Number(active_place_order_for_supplies_))
        active_place_order_for_supplies_ = await instance.getTaskRequestIndex(8)
        console.log("fortransport",Number(active_place_order_for_supplies_))



    })
})