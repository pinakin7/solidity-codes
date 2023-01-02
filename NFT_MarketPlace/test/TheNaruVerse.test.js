const { assert } = require("chai");

const {web3} = require("web3");

const contract = require('../build/contracts/TheNaruVerse.json');
const {CONTRACT_ADDRESS} = require('../config');

web3.setProvider("http://127.0.0.1:7545");

const nftContract = new web3.eth.Contract(contract, );

contract("TheNaruVerse", (accounts) => {
    before(async () => {
        this.theNaruVerse = await nftContract;
    });
});