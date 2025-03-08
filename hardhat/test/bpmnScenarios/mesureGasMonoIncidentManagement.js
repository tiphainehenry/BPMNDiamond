describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Incident_Management')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(12,"Role","","")
        await processus.Invoke(0,"Role","","")
        await processus.Invoke(1,"Role","","")
        await processus.Invoke(14,"Role","","")
        await processus.Invoke(2,"Role","","")
        await processus.Invoke(15,"Role","","")
        await processus.Invoke(4,"Role","","")
        await processus.Invoke(16,"Role","","")
        await processus.Invoke(5,"Role","","")
        await processus.Invoke(6,"Role","","")
        await processus.Invoke(17,"Role","","")
        await processus.Invoke(7,"Role","","")
        await processus.Invoke(19,"Role","","")
        await processus.Invoke(8,"Role","","")
        await processus.Invoke(18,"Role","","")
        await processus.Invoke(3,"Role","","")
        await processus.Invoke(13,"Role","","")

    })
})