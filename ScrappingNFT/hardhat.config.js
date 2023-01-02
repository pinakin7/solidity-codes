
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
const { API_URL, PRIVATE_KEY, ROPSTEN_PRIVATE, ROPSTEN_URL } = process.env;
module.exports = {
   solidity: "0.8.1",
   defaultNetwork: "ganache",
   networks: {
      hardhat: {},
      ganache: {
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      },
      ropsten: {
         url: "https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
         accounts: [`0x${ROPSTEN_PRIVATE}`]
      },
      rinkbey: {
         url: "https://eth-rinkeby.alchemyapi.io/v2/78u68FklYOhbxf3CPmyMYGZjNvWhrCN-",
         accounts: [`0x${ROPSTEN_PRIVATE}`]
      }
   },
}
