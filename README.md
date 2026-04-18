# FundMe Smart Contract:

**Fund-Me Smart Contract**: This is a minimal project  allowing user to fund the contract owner with donations. The smart contract accepts ETH as donations, dominated in USD. Donations has minimum USD value , otherwise they are rejected. The value is priced using a Chainlink Price Feed , and the smart contract keeps track of the  doners in case they are to be rewarded in the future.

 *The FundMe Project* smart contract enables transparent, "decentralized crowdfunding", acting like a programmable Kickstarter on the blockchain. Its core purpose is to "securely accept native cryptocurrency donations (fund)", "track contributor data", "enforce a minimum USD value using Chainlink oracles", and allow "authorized withdrawals (withdraw)".  

## Project Overview
The FundMe contract enables decentralized fundraising with the following key features:
* Minimum funding requirement of $5 USD (converted from ETH)
* Real-time ETH/USD price conversion using Chainlink oracles
* Owner-only can withdraw functionality
* Automatic fund() execution via fallback and receive functions

It demonstrates:
* Price feed integration via AggregatorV3Interface
* Mocking Chainlink feeds for local testing
* Foundry-style unit, integration tests

Built this project to understand in-dept about:
* Oracle integration (Chainlink)
* Access control with onlyOwner
* Safe ETH withdrawal patterns.
* Gas optimizations with constant, immutable, and custom errors.

## Features
* Minimum Contribution: $5 USD equivalent in ETH
* Price Oracle Integration: Uses Chainlink ETH/USD price feeds (Sepolia testnet)
* Access Control: Only contract deployer can withdraw funds
* Fallback Support: Automatically processes direct ETH transfers as donations
* Funder Tracking: Records who sent ETH and how much
* Auto ETH Handling: receive() and fallback() support direct ETH

## Real-World Analogy
Think of this contract like a donation box:
* People (like e.g "Nathaniel" 🧍) can donate ETH
* But it only accepts donations worth $5 or more in real-time USD value
* You (the contract creator) are the only one allowed to withdraw the funds.
* The contract safely tracks all donors and protects against misuse.

## Key Concepts Used
* msg.sender, msg.value, address(this).balance
* Chainlink AggregatorV3Interface
* Price conversion using custom library (PriceConverter)
* onlyOwner modifier using immutable i_owner
* transfer, send, and call ETH withdrawal methods
* Gas-optimized NotOwner() custom error
* receive() and fallback() to catch direct ETH transactions
  

## Technology Stack (Technologies Used)
* Solidity - Smart contract programming language
* Foundry(forge, cast, anvil) - Development framework and testing suite
* Chainlink Price/Data Feeds (real + mock)
* Chainlink Brownie Contracts
* MetaMask: Ethereum wallet for transactions.


## Getting Started


### Prerequisites
* Solidity ^0.8.18
* Chainlink contracts
* Install the MetaMask browser extension and connect it to a test network (e.g., Sepolia).
* Apart of being able to deploy on local blockchain (like Anvil) .  Access to Ethereum free testnet (Sepolia) for deployment, is needed. Which is typically similar to mainnet deployment.

### Installation
  1. Clone the repository: </br>

     ```shell
        git clone https://github.com/legendarycode3/fund-me-smart-contract 
     ```
     ```shell
        cd fund-me-smart-contract
     ```
   
 1. Install dependencies: </br>
     ```shell
       forge install smartcontractkit/chainlink-brownie-contracts@0.6.1  
     ```
    ```shell  
      make install  Or   
      forge install
    ```
    
    
 4. Build the project: </br>
    ```shell
      make build
    ```

       


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of: </br>

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/


##  Deployment to a testnet or mainnet
1. Setup environment variables </br>
You'll want to set your SEPOLIA_RPC_URL and PRIVATE_KEY as environment variables. You can add them to a .env file </br>
* PRIVATE_KEY: The private key of your account (like from [metamask](https://metamask.io/). NOTE: FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
* SEPOLIA_RPC_URL: This is url of the sepolia testnet node you're working with. You can get setup with one for free from  [alchemy](https://www.alchemy.com/)
Optionally, add your ETHERSCAN_API_KEY if you want to verify your contract on [Etherscan](https://etherscan.io/)
2. Get testnet ETH  </br>
Head over to [cloud.google.com](https://cloud.google.com/application/web3/faucet) or [faucets.chain.link](https://faucets.chain.link/) and get some testnet Sepolia ETH. You should see the Sepolia ETH show up in your metamask.
3. Deploy(Using Script) </br>
```shell
 forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## Usage

### Build

```shell
 forge build
```

### Testing

Run all tests: </br>
```shell
 forge test
```
Or </br>
```shell
make test
```

Run tests with verbosity: </br>
```shell
make test -vvv
```
Run specific test: </br>
```shell
forge test --mt testFunctionName
```
Test coverage: </br>
```shell
make coverage
```

Example test scenarios:
* Funding below minimum threshold (should revert)
* Successful funding above minimum
* Non-owner withdrawal attempt (should revert)
* Owner withdrawal functionality
* Price conversion accuracy

### Format

```shell
 forge fmt
```

### Gas Snapshots

```shell
 forge snapshot
```

### Anvil

```shell
 anvil
```

### Deploy
```shell
 forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url <your_rpc_url> --private-key <your_private_key>
```
Deploy to Sepolia testnet: </br>
> make deploy-sepolia

### Cast </br>

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## Smart Contract Details
### Functions
* fund(): Allows users to contribute funds to the campaign. Requires the sent amount to meet the minimum USD requirement.
* getPrice(): Retrieves the latest ETH to USD conversion rate using Chainlink's AggregatorV3Interface.
* getVersion():  Retrieves the version of the Chainlink AggregatorV3Interface being used.
* getConversionRate(uint256 ethAmount): Calculates the equivalent USD amount for the provided ETH amount.
* withdraw(): Enables the contract owner to be able to pull all funds (Ether) out of the contract to their own wallet.

## Configuration
Create a .env file with the following variables:

```shell
SEPOLIA_RPC_URL=your_sepolia_rpc_url 
ETHERSCAN_API_KEY=your_etherscan_api_key  
```



## Project Structure
    ├──script
    │   ├── DeployFundMe.s.sol
    │   ├── HelperConfig.s.sol
    │   └── Interactions.s.sol
    ├── src
        ├── PriceConverterLibrary.sol
    │   └── FundMe.sol
    └── test
        ├── integration
        │   └── FundMeTestIntegrationOrIntetractionTest.t.sol
        ├── mocks
        │   └── MockV3Aggregator.sol
        └── unit
            └── FundMeTest.t.sol
        ├── foundry.toml
        └── README.md

## Gas Optimization
The contract implements several gas optimization techniques:
* Immutable owner variable
* Constant minimum USD value
* Efficient array resetting in withdrawal

## 📚 References
* Foundry Book
*  Foundry Fundamentals

## Learn More (Resources)
* [Solidity Documentation](https://docs.soliditylang.org/en/v0.8.35-pre.1/)
* [Foundry Documentation](https://www.getfoundry.sh/)
* [Chainlink Documentation](https://docs.chain.link/)

## Learning Objectives
By completing this project, you should be comfortable with:
* Writing Solidity contracts with external dependencies
* Using libraries and immutable variables
* Writing Foundry tests with mocks and cheats
* Debugging EVM and Foundry errors
* Understanding environment-specific behavior (local vs testnet vs fork)

##  Additional Info:
Some users were having a confusion that whether Chainlink-brownie-contracts is an official Chainlink repository or not.
Here is the info. Chainlink-brownie-contracts is an official repo. The repository is owned and maintained by the
chainlink team for this very purpose, and gets releases from the proper chainlink release process. You can see it's still
the smartcontractkit org as well.
[smartcontractkit](https://github.com/smartcontractkit/chainlink-brownie-contracts)

## Author
LegendaryCode  
* LinkedIn: [@legendarycode3](https://www.linkedin.com/legendarycode3)
* Twitter:  [@legendary_code_](https://x.com/legendary_code_)
* Github:  [@legendarycode3](https://github.com/legendarycode3)
