# ABOUT PROJECT:

**Fund-Me Smart Contract**: This is a minimal project  allowing user to fund the contract owner with donations. The smart contract accepts ETH as donations, dominated in USD. Donations has minimum USD value , otherwise they are rejected. The value is priced using a Chainlink Price Feed , and the smart contract keeps track of the  doners in case they are to be rewarded in the future.

 *The FundMe Project* smart contract enables transparent, "decentralized crowdfunding", acting like a programmable Kickstarter on the blockchain. Its core purpose is to "securely accept native cryptocurrency donations (fund)", "track contributor data", "enforce a minimum USD value using Chainlink oracles", and allow "authorized withdrawals (withdraw)".  

## Overview
The FundMe contract enables decentralized fundraising with the following key features:
* Minimum funding requirement of $5 USD (converted from ETH)
* Real-time ETH/USD price conversion using Chainlink oracles
* Owner-only can withdrawal functionality
* Automatic fund() execution via fallback and receive functions

## Features
* Minimum Contribution: $5 USD equivalent in ETH
* Price Oracle Integration: Uses Chainlink ETH/USD price feeds (Sepolia testnet)
* Access Control: Only contract deployer can withdraw funds
* Fallback Support: Automatically processes direct ETH transfers as donations
  

## Technology Stack
* Solidity - Smart contract programming language
* Foundry - Development framework and testing suite
* Chainlink Brownie Contracts
* Chainlink Data Feeds


## Getting Started


### Prerequisites /
* Solidity ^0.8.18
* Chainlink contracts
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
       forge install foundry-rs/forge-std 
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

## Usage

### Build

```shell
$ forge build
```

### Testing

Run all tests: </br>
```shell
$ forge test
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
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy
```shell
$ forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url <your_rpc_url> --private-key <your_private_key>
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

## Author
LegendaryCode  
* LinkedIn: [@legendarycode3](https://www.linkedin.com/)
* Twitter:  [@legendary_code_](https://x.com)
* Github:  [@legendarycode3](https://github.com)
