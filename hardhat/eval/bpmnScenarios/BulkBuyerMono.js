describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {
    Processus = await ethers.getContractFactory('BulkBuyer')
    processus = await Processus.deploy()
    await processus.deployed()
    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        ///// Bulkbuyer /////
        // start
        await processus.Invoke(8,"BulkBuyer","","")
        // sendOrder
        await processus.Invoke(14,"BulkBuyer","","")
        // production start
        await processus.Invoke(20,"BulkBuyer","","")
        // productionend*
        await processus.Invoke(19,"BulkBuyer","","")
        // end
        await processus.Invoke(25,"BulkBuyer","","")

        ////// Manufacturer /////
        // orderfromBulkB
        await processus.Invoke(6,"Manufactturer","","")
        //cakculate demand
        await processus.Invoke(3,"Manufactturer","","")
        // place order
        await processus.Invoke(12,"Manufactturer","","")
        // receive order
        await processus.Invoke(16,"Manufactturer","","")
        //reportstart
        await processus.Invoke(11,"Manufactturer","","")
        //produce
        await processus.Invoke(2,"Manufactturer","","")
        // msg end
        await processus.Invoke(23,"Manufactturer","","")

        //////// Middleman/////
        // order form manu
        await processus.Invoke(5,"Middleman","","")
        // fwdorder
        await processus.Invoke(10,"Middleman","","")
        // ordertransport
        await processus.Invoke(22,"Middleman","","")


        //////// Special Carrier/////
        // order transport
        await processus.Invoke(7,"SpecialCarrier","","")
        // request
        await processus.Invoke(13,"SpecialCarrier","","")
        // receivedetail
        await processus.Invoke(17,"SpecialCarrier","","")
        //receivewayb
        await processus.Invoke(18,"SpecialCarrier","","")
        // deliver order
        await processus.Invoke(24,"SpecialCarrier","","")

        //////// Supplier/////
        // order suply
        await processus.Invoke(4,"Supplier","","")
        // produce
        await processus.Invoke(1,"Supplier","","")
        // prepare transport
        await processus.Invoke(0,"Supplier","","")
        // receive req
        await processus.Invoke(15,"Supplier","","")
        // provide details
        await processus.Invoke(9,"Supplier","","")
        // provide way bills
        await processus.Invoke(21,"Supplier","","")

        await processus.Invoke(18,"SpecialCarrier","","")
        await processus.Invoke(24,"SpecialCarrier","","")
        await processus.Invoke(11,"Manufactturer","","")
        await processus.Invoke(19,"BulkBuyer","","")
        await processus.Invoke(25,"BulkBuyer","","")

    })
})