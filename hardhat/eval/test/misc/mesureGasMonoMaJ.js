describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('ProcessusMono8')
    processus = await Processus.deploy()
    await processus.deployed()

    ProcessusV2 = await ethers.getContractFactory('ProcessusMono8V2')
    processusV2 = await ProcessusV2.deploy()
    await processusV2.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{


    })
})