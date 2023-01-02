// writing test

const { assert } = require("chai");

const TheNaruVerse = artifacts.require("./TheNaruVerse.sol");

contract("TheNaruVerse", (accounts) => {
    before(async () => {
        this.theNaruVerse = await TheNaruVerse.deployed();
    });

    it("deploys successfully", async () => {
        const address = await this.theNaruVerse.address;
        assert.notEqual(address, 0x0);
        assert.notEqual(address, "");
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
    });

    

    it("minting successfully", async () => {
        // test for task completion toggle

        const mintNFT = await this.theNaruVerse.mint("https://ipfs.io/ipfs/QmV1TRRnqU6xaSKaRana3P9MqE9qVQnPz5kwF9V1QePRsY?filename=nft-metadata.json","0xd79d9C0E4d6842bE86DB75688482084aDFC67C08");
        // const mintNFT = await this.theNaruVerse.mint("https://ipfs.io/ipfs/QmV1TRRnqU6xaSKaRana3P9MqE9qVQnPz5kwF9V1QePRsY?filename=nft-metadata.json","0xd79d9C0E4d6842bE86DB75688482084aDFC67C08");
        // const mintNFT = await this.theNaruVerse.mint("https://ipfs.io/ipfs/QmV1TRRnqU6xaSKaRana3P9MqE9qVQnPz5kwF9V1QePRsY?filename=nft-metadata.json","0xd79d9C0E4d6842bE86DB75688482084aDFC67C08");

        const total = await this.theNaruVerse.totNFT();

        assert.equal(total, 1);
        const nft = await this.theNaruVerse.nvfts(1);
        assert.equal(nft.currentOwner, "0xd79d9C0E4d6842bE86DB75688482084aDFC67C08");

    });

    it("transfer successfull", async () => {
        // test for task completion toggle

        const mintNFT = await this.theNaruVerse.buyNFT("0xd79d9C0E4d6842bE86DB75688482084aDFC67C08","0xEe0Fd7269d58E6EbEE9fDF06BDa84063195E52bC",1);

        const total = await this.theNaruVerse.totNFT();

        const nft = await this.theNaruVerse.nvfts(1);

        assert.equal(total, 1);
        assert.equal(nft.currentOwner, "0xEe0Fd7269d58E6EbEE9fDF06BDa84063195E52bC");

    });



});
