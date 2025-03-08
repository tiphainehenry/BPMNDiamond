describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Certification')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(10,"ChefAffaire","","")
        await processus.Invoke(0,"ChefAffaire","","")
        await processus.Invoke(17,"ChefAffaire","","")
        await processus.Invoke(28,"BureauEtude","","")
        await processus.Invoke(1,"BureauEtude","","")
        await processus.Invoke(15,"BureauEtude","","")
        await processus.Invoke(9,"VerificateurN1","","")
        await processus.Invoke(18,"BureauEtude","","")
        await processus.Invoke(29,"VerificateurN1","","")
        await processus.Invoke(8,"VerificateurN1","","")
        await processus.Invoke(7,"VerificateurN1","","")
        await processus.Invoke(27,"VerificateurN1","","")
        await processus.Invoke(23,"VerificateurN1","","")
        await processus.Invoke(2,"VerificateurN2","","")
        await processus.Invoke(3,"VerificateurN2","","")
        await processus.Invoke(4,"VerificateurN2","","")
        await processus.Invoke(25,"VerificateurN2","","")
        await processus.Invoke(20,"VerificateurN2","","")
        await processus.Invoke(6,"Approbateur","","")
        await processus.Invoke(26,"Approbateur","","")
        await processus.Invoke(5,"Approbateur","","")
        await processus.Invoke(22,"Approbateur","","")
        // included = await processus.getIncluded()
        // included = included.map(value => Number(value));
        // console.log(included)      

    })
})