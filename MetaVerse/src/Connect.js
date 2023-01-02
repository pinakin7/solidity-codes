import abi from "./abi/abi.json" assert {type:"json"};

const connect = new Promise((res, rej)=>{
    if(typeof window.ethereum == "undefined"){
        rej("Install MetaMask");
    }

    window.ethereum.request({method:"eth_requestAccounts"});

    let web3 = new Web3(window.ethereum);

    let contract = new web3.eth.Contract(abi, "0xb8A095e4cBf2bC303F51a55bC96A0Ece72aA0366");

    // console.log(contract);

    web3.eth.getAccounts().then((accounts)=>{
        contract.methods.totalSupply().call({from:accounts[0]}).then((supply)=>{
            contract.methods.getBuildings().call().then((data)=>{
                res({supply:supply, buildings:data})
            })
        })
    });

});

export default connect;
