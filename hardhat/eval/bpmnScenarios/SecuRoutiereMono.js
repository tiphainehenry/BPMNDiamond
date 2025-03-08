describe('mesureGasMono', async function () {
    let Processus
    let processus
    before(async function () {

    Processus = await ethers.getContractFactory('SecuRoutiere')
    processus = await Processus.deploy()
    await processus.deployed()
    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        
        //// CRIRC //// 
        // START
        await processus.Invoke(14,"CRIRC","","")  
        // XOR        
        await processus.Invoke(22,"CRIRC","","")  
        // Centraliser
        await processus.Invoke(2,"CRIRC","","")  
        // Receptionner communiques
        await processus.Invoke(1,"CRIRC","","")  
        // XOR        
        await processus.Invoke(23,"CRIRC","","")  
        // Analyser situation 
        await processus.Invoke(0,"CRIRC","","")  
        // XOR 
        await processus.Invoke(24,"CRIRC","","")  
        // Renseigner
        await processus.Invoke(4,"CRIRC","","")  
        // envoyer
        await processus.Invoke(3,"CRIRC","","")  
        // informer
        await processus.Invoke(5,"CRIRC","","")  
        // informerCellules
        await processus.Invoke(6,"CRIRC","","")  
        // xor
        await processus.Invoke(25,"CRIRC","","")  
        // end
        await processus.Invoke(18,"CRIRC","","")  

        //// EMZDCOZ //// 
        // receive
        await processus.Invoke(17,"EMIZDCOZ","","")  
        // receptionner
        await processus.Invoke(13,"EMIZDCOZ","","")  
        // end
        await processus.Invoke(21,"EMIZDCOZ","","")  

        //// cellule comm //// 
        // receive
        await processus.Invoke(15,"CelluleComPref35","","")  
        // receotuinner
        await processus.Invoke(7,"CelluleComPref35","","")  
        // xor 
        await processus.Invoke(26,"CelluleComPref35","","")  
        // rediger comm 
        await processus.Invoke(8,"CelluleComPref35","","")  
        //receptionner comm 
        await processus.Invoke(9,"CelluleComPref35","","")  
        // xor 
        await processus.Invoke(27,"CelluleComPref35","","")  
        // publier
        await processus.Invoke(10,"CelluleComPref35","","")  
        // end
        await processus.Invoke(19,"CelluleComPref35","","")  


        //// prefet zone //// 
        // receive
        await processus.Invoke(16,"PrefetZone","","")  
        // receptionner comm
        await processus.Invoke(11,"PrefetZone","","")  
        // valider comm 
        await processus.Invoke(12,"PrefetZone","","")  
        // end
        await processus.Invoke(20,"PrefetZone","","")  


        included = await processus.getIncluded()
        included = included.map(value => Number(value));
        console.log(included)

        // await processus.Invoke(33,"EDF","","")
        // await processus.Invoke(2,"EDF","","")
        // await processus.Invoke(3,"EDF","","")
        // await processus.Invoke(35,"EDF","","")
        // await processus.Invoke(20,"EDF","","")
        // await processus.Invoke(0,"Presta_Lasers_type1","","")
        // await processus.Invoke(15,"Presta_Lasers_type1","","")
        // await processus.Invoke(27,"Presta_Lasers_type1","","")

    })
})