describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {
        Processus = await ethers.getContractFactory('SeadmeteGarantii')
        processus = await Processus.deploy()
        await processus.deployed()
    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        await processus.Invoke(21, "Laojuhataja", "", "");
        await processus.Invoke(22, "Tookoja juhataja", "", "");
        await processus.Invoke(23, "Assistent", "", "");
        await processus.Invoke(5, "Tookoja juhataja", "", "");
        await processus.Invoke(17, "Assistent", "", "");
        await processus.Invoke(11, "Remonditehnik", "", "");
        await processus.Invoke(26, "Tookoja juhataja", "", "");
        await processus.Invoke(0, "Laojuhataja", "", "");
        await processus.Invoke(29, "Remonditehnik", "", "");
        await processus.Invoke(32, "Tookoja juhataja", "", "");
        await processus.Invoke(33, "Tookoja juhataja", "", "");
        await processus.Invoke(4, "Tookoja juhataja", "", "");
        await processus.Invoke(27, "Tookoja juhataja", "", "");
        await processus.Invoke(35, "Tookoja juhataja", "", "");
        await processus.Invoke(36, "Tookoja juhataja", "", "");
        await processus.Invoke(16, "Muugijuht", "", "");
        await processus.Invoke(6, "Tookoja juhataja", "", "");
        await processus.Invoke(1, "Laojuhataja", "", "");
        await processus.Invoke(7, "Tookoja juhataja", "", "");
        await processus.Invoke(19, "Tootja remondikeskus", "", "");
        await processus.Invoke(20, "Tootja remondikeskus", "", "");
        await processus.Invoke(3, "Laojuhataja", "", "");
        await processus.Invoke(9, "Tookoja juhataja", "", "");
        await processus.Invoke(8, "Tookoja juhataja", "", "");
        await processus.Invoke(28, "Tookoja juhataja", "", "");
        await processus.Invoke(31, "Tookoja juhataja", "", "");
        await processus.Invoke(34, "Tookoja juhataja", "", "");
        await processus.Invoke(24, "Laojuhataja", "", "");
        await processus.Invoke(24, "Laojuhataja", "", "");

    })
})