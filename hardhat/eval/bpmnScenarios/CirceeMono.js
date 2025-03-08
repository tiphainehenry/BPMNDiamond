describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Circee')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        await processus.Invoke(15,"Presta_Lasers_type1","","")
        await processus.Invoke(16,"EDF","","")
        await processus.Invoke(17,"Presta_Lasers_2","","")
        await processus.Invoke(18,"BEP","","")
        await processus.Invoke(19,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(0,"Presta_Lasers_type1","","")
        await processus.Invoke(10,"Presta_Lasers_2","","")
        await processus.Invoke(12,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(35,"EDF","","")
        await processus.Invoke(27,"Presta_Lasers_type1","","")
        await processus.Invoke(37,"EDF","","")
        await processus.Invoke(5,"EDF","","")
        await processus.Invoke(20,"EDF","","")
        await processus.Invoke(21,"EDF","","")
        await processus.Invoke(29,"Presta_Lasers_2","","")
        await processus.Invoke(34,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(6,"EDF","","")
        await processus.Invoke(13,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(32,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(38,"EDF","","")
        await processus.Invoke(13,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(31,"ASN_ou_Organisme_Surete","","")
        await processus.Invoke(28,"EDF","","")
  
    })
})