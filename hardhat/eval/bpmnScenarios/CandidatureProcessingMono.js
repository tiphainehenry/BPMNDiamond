describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {
        Processus = await ethers.getContractFactory('CandidatureProcessing')
        processus = await Processus.deploy()
        await processus.deployed()
    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        await processus.Invoke(11, "Student", "", "");
        await processus.Invoke(21, "Student", "", "");
        await processus.Invoke(12, "Admission office", "", "");
        await processus.Invoke(0, "Admission office", "", "");
        await processus.Invoke(22, "Student", "", "");
        await processus.Invoke(0, "Admission office", "", "");
        await processus.Invoke(41, "Admission office", "", "");
        await processus.Invoke(42, "Admission office", "", "");
        await processus.Invoke(48, "Admission office", "", "");
        await processus.Invoke(49, "Admission office", "", "");
        await processus.Invoke(14, "Admission office", "", "");
        await processus.Invoke(23, "Student", "", "");

        
        included = await processus.getIncluded()
        included = included.map(value => Number(value));
        console.log(included)

    })
})