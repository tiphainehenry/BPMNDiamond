describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('LCA')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(7,"LCA expert","","")
        await processus.Invoke(0,"LCA expert","","")
        await processus.Invoke(9,"LCA expert","","")
        await processus.Invoke(8,"Client","","")
        await processus.Invoke(19,"Client","","")
        await processus.Invoke(11,"Client","","")
        await processus.Invoke(12,"Client","","")
        await processus.Invoke(10,"LCA expert","","")
        await processus.Invoke(0,"LCA expert","","")
        await processus.Invoke(9,"LCA expert","","")
        // included = await processus.getIncluded()
        // included = included.map(value => Number(value));
        // console.log(included)      
    })
})