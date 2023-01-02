async function main() {
    const WesTer = await ethers.getContractFactory("WesTer");

    // Start deployment, returning a promise that resolves to a contract object
    const wesTer = await WesTer.deploy();
    await wesTer.deployed();
    console.log("Contract deployed to address:", wesTer.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


    // 0xa9217599DA93BaA56FdC37B66e126462f54Da5EF contract deployment address