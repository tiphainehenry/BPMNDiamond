describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('SPARKLogistics')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        await processus.Invoke(17, "SPARKS", "", "");
        await processus.Invoke(3,"SPARKS","","")
        await processus.Invoke(4,"SPARKS","","")
        await processus.Invoke(52, "SPARKS", "", "");
        await processus.Invoke(62, "SPARKS", "", "");
        await processus.Invoke(63, "SPARKS", "", "");
        await processus.Invoke(6, "SPARKS", "", "");
        await processus.Invoke(5, "SPARKS", "", "");
        await processus.Invoke(22, "SPARKS", "", "");
        await processus.Invoke(49, "Customer", "", "");
        await processus.Invoke(0,"Customer","","")
        await processus.Invoke(49, "Customer", "", "");
        await processus.Invoke(59, "Customer", "", "");
        await processus.Invoke(60, "Customer", "", "");
        await processus.Invoke(21, "Customer", "", "");
        await processus.Invoke(12, "SPARKS", "", "");
        await processus.Invoke(54, "SPARKS", "", "");
        await processus.Invoke(64, "SPARKS", "", "");
        await processus.Invoke(65, "SPARKS", "", "");
        await processus.Invoke(24, "SPARKS", "", "");
        await processus.Invoke(51, "Customer", "", "");
        await processus.Invoke(2,"Customer","","")
        await processus.Invoke(61, "Customer", "", "");
        await processus.Invoke(11, "SPARKS", "", "");
        await processus.Invoke(10, "SPARKS", "", "");
        await processus.Invoke(44, "SPARKS", "", "");
        await processus.Invoke(48, "External garage", "", "");
  
    })
})