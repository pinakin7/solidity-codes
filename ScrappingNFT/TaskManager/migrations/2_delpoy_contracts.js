var TodoList = artifacts.require("./TodoList.sol");

module.exports = function(deployer){
    deployer.deploy(TodoList);
};


// deploying the TodoList smart contract