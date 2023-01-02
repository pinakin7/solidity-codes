// require("@nomiclabs/hardhat-waffle");

// // This is a sample Hardhat task. To learn how to create your own go to
// // https://hardhat.org/guides/create-task.html
// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
//   const accounts = await hre.ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });

// // You need to export an object to set up your config
// // Go to https://hardhat.org/config/ to learn more

// /**
//  * @type import('hardhat/config').HardhatUserConfig
//  */
// module.exports = {
//   solidity: "0.8.4",
// };







require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
const { GANACHE_API_URL, GANACHE_PRIVATE_KEY, ROPSTEN_API_URL, ROPSTEN_PRIVATE_KEY } = process.env;
module.exports = {
   solidity: "0.8.0",
   defaultNetwork: "ganache",
   networks: {
      hardhat: {},
      ganache: {
         url: GANACHE_API_URL,
         accounts: [`0x${GANACHE_PRIVATE_KEY}`]
      },
      ropsten:{
        url: ROPSTEN_API_URL,
        accounts: [`0x${ROPSTEN_PRIVATE_KEY}`]
      }
   },
}
