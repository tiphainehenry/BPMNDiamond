describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Procurement')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(6,"Buyer","","")
        await processus.Invoke(0,"Buyer","","")
        await processus.Invoke(1,"Buyer","","")
        await processus.Invoke(9,"Buyer","","")
        await processus.Invoke(5,"Buyer","","")
        await processus.Invoke(10,"Buyer","","")
        await processus.Invoke(3,"Buyer","","")
        await processus.Invoke(4,"Buyer","","")
        await processus.Invoke(11,"Buyer","","")
        await processus.Invoke(2,"Buyer","","")
        await processus.Invoke(7,"Buyer","","")

    })
})