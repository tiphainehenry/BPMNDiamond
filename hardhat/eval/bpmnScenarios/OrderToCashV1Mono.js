describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('OrderToCashV1')
    processus = await Processus.deploy()
    await processus.deployed()

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{

        await processus.Invoke(15,"OrderTOCash","","")
        await processus.Invoke(9,"OrderTOCash","","")
        await processus.Invoke(0,"OrderTOCash","","")
        await processus.Invoke(1,"OrderTOCash","","") //15-16-17-18-19-20
        await processus.Invoke(15,"OrderTOCash","","")
        await processus.Invoke(2,"OrderTOCash","","")
        await processus.Invoke(16,"OrderTOCash","","") //15-16-17-18-19-20
        await processus.Invoke(3,"OrderTOCash","","")
        await processus.Invoke(17,"OrderTOCash","","")
        await processus.Invoke(4,"OrderTOCash","","")
        await processus.Invoke(18,"OrderTOCash","","")
        await processus.Invoke(5,"OrderTOCash","","") //15-16-17-18-19-20
        // included = await processus.getIncluded()
        // included = included.map(value => Number(value));
        // console.log(included)      


    })
})