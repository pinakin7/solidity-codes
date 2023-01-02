## Workflow

Server -> Client App -> Blockchain -> Smart Contract

### Smart Contracts
* Blockchain programs
* Immutable
* Microservices

### Project Folder Structure
* contracts directory: this is where all smart contacts live. We already have a Migration contract that handles our migrations to the blockchain.
* migrations directory: this is where all of the migration files live. These migrations are similar to other web development frameworks that require migrations to change the state of a database. Whenever we deploy smart contracts to the blockchain, we are updating the blockchain's state, and therefore need a migration.
* test directory: this is where we'll write our tests for our smart contract.
* truffle-config.js file: this is the main configuration file for our Truffle project, where we'll handle things like network configuration.