describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Pizza')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(4,"Role","","")
        await processus.Invoke(6,"Role","","")
        await processus.Invoke(13,"suplier","","")
        await processus.Invoke(3,"suplier","","")
        await processus.Invoke(1,"suplier","","")
        await processus.Invoke(8,"suplier","","")
        await processus.Invoke(0,"suplier","","")
        await processus.Invoke(14,"suplier","","")
        await processus.Invoke(7,"suplier","","")
        await processus.Invoke(11,"suplier","","")
        await processus.Invoke(10,"Role","","")

    })
})