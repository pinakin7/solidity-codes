var metaMaskInstalled = false;

window.onload = (e)=>{
    // check for the presence of metamask installed or not
    const {ethereum} = window;
    if(!ethereum && !ethereum.isMetaMask){
        // ask for installing metamask
        // console.log("MetaMask Not Installed");
        const notInstalledAlert = document.getElementById("notInstalled");
        notInstalledAlert.classList.remove("d-none");
    }
    else{
        // do nothing
        // console.log("MetaMask Installed");
        const installedAlert = document.getElementById("installed");
        installedAlert.classList.remove("d-none");
        metaMaskInstalled = true;
    }


    const loginWithMetaMask = async ()=>{
        // login with metamask accounts
        const currAccounts = await window.ethereum.request({method: 'eth_requestAccounts'}).catch((error)=>{
            document.getElementById("errorAlert").classList.remove("d-none");
            document.getElementById("errorMessage").innerText = error.message.toString().replace(/(\r\n|\n|\r)/gm, "");
            return;
        });

        const chainId = await ethereum.request({ method: 'eth_chainId' });
        

        
        if(!currAccounts){return};
        
        // console.log(currAccounts);
        
        // console.log(chainId);
        
        window.userWalletAddress = currAccounts[0];
        
        // const balance = parseInt(await ethereum.request({method: 'eth_getBalance', params:[currAccounts[0], 'latest']}).slice(2), 16);

        let balance = await ethereum.request({method: 'eth_getBalance', params:[currAccounts[0], 'latest']});

        balance = balance.slice(2);

        balance = parseInt(balance, 16)/1000000000000000000;

        // console.log(balance);
        
        document.getElementById("accountAddress").innerHTML = "Account Address: "+ currAccounts[0] + "<br> Balance: " + balance + " ETH";

        if(chainId && chainId==="0x1"){
            // console.log("Connected to Ethereum Mainnet");

            

            document.getElementById("mainnetConnected").classList.remove("d-none");            

            document.getElementById("integrateMetaMask").innerHTML = "Remove Integration";

            document.getElementById("integrateMetaMask").removeEventListener("click", loginWithMetaMask);
            
            document.getElementById("integrateMetaMask").addEventListener("click", logoutWithMetaMask);

        }

        else{
            // console.log("Connect to Ethereum Mainnet");   

            document.getElementById("errorAlert").classList.remove("d-none");
            document.getElementById("errorMessage").innerText = "Please Connect to Ethereum Mainnet";
        }

        

    };

    const logoutWithMetaMask = ()=>{

        window.userWalletAddress = null;

        document.getElementById("accountAddress").innerHTML = "Account Address: ";

        document.getElementById("integrateMetaMask").innerHTML = "Integrate MetaMask";

        document.getElementById("integrateMetaMask").addEventListener("click", loginWithMetaMask);
        
        document.getElementById("integrateMetaMask").removeEventListener("click", logoutWithMetaMask);
    };


    if(metaMaskInstalled){

        const integrateMetaMaskCard = document.getElementById("integrateMetaMaskCard");
        integrateMetaMaskCard.classList.remove("d-none");


        const integrateMetaMask = document.getElementById("integrateMetaMask");


        integrateMetaMask.addEventListener("click", loginWithMetaMask);
    }


};