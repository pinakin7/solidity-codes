async function main() {
    const TheNaruVerse = await ethers.getContractFactory("TheNaruVerse");

    // Start deployment, returning a promise that resolves to a contract object
    const theNaruVerse = await TheNaruVerse.deploy();
    await theNaruVerse.deployed();
    console.log("Contract deployed to address:", theNaruVerse.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


    // 0x73E314505Bde2c668aB4bDcF94D7D69D733C36aD -> ganache

    // 0x9e6D1f4998C369Cd6AaAbE674B9AE632a08e6b0F -> ropsten