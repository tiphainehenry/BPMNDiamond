describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('Zad2Kolab')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        await processus.Invoke(11, "Student", "", "");
        await processus.Invoke(12, "Sluzbenik", "", "");
        await processus.Invoke(13, "Menadzer", "", "");
        await processus.Invoke(14, "Sluzba za izradu kartica", "", "");
        await processus.Invoke(8, "Menadzer", "", "");
        await processus.Invoke(10, "Sluzba za izradu kartica", "", "");
        await processus.Invoke(44, "Sluzbenik", "", "");
        await processus.Invoke(3, "Sluzbenik", "", "");
        await processus.Invoke(4, "Sluzbenik", "", "");
        await processus.Invoke(36, "Sluzba za izradu kartica", "", "");
        await processus.Invoke(42, "Menadzer", "", "");
        await processus.Invoke(9, "Menadzer", "", "");
        await processus.Invoke(34, "Menadzer", "", "");
        await processus.Invoke(35, "Menadzer", "", "");
        await processus.Invoke(43, "Sluzbenik", "", "");
        await processus.Invoke(2, "Sluzbenik", "", "");
        await processus.Invoke(21, "Sluzbenik", "", "");
        await processus.Invoke(22, "Menadzer", "", "");
        await processus.Invoke(32, "Student", "", "");
        await processus.Invoke(38, "Sluzbenik", "", "");
        await processus.Invoke(5, "Sluzbenik", "", "");
        await processus.Invoke(17, "Sluzbenik", "", "");
        await processus.Invoke(39, "Sluzbenik", "", "");
        await processus.Invoke(7, "Sluzbenik", "", "");
        await processus.Invoke(18, "Sluzbenik", "", "");
        await processus.Invoke(40, "Sluzbenik", "", "");
        await processus.Invoke(19, "Sluzbenik", "", "");
  
        await processus.Invoke(15, "Student", "", "");
  
        // await processus.Invoke(7,"LCA expert","","")
        // await processus.Invoke(0,"LCA expert","","")
        // await processus.Invoke(9,"LCA expert","","")
        // await processus.Invoke(8,"Client","","")
        // await processus.Invoke(19,"Client","","")
        // await processus.Invoke(11,"Client","","")
        // await processus.Invoke(12,"Client","","")
        // await processus.Invoke(10,"LCA expert","","")

    })
})