## ABOUT PROJECT:

**Fund-Me Project**: This is a minimal project  allowing user to fund the contract owner with donations. The smart contract accepts ETH as donations, dominated in USD. Donations has minimum USD value , otherwise they are rejected. The value is priced using a Chainlink Price Feed , and the smart contract keeps track of the  doners in case they are to be rewarded in the future.

 *The FundMe Project* smart contract enables transparent, "decentralized crowdfunding", acting like a programmable Kickstarter on the blockchain. Its core purpose is to "securely accept native cryptocurrency donations (fund)", "track contributor data", "enforce a minimum USD value using Chainlink oracles", and allow "authorized withdrawals (withdraw)".  

1.Proper ReadMe

2. integration Test
3. 
## USED THIS PROGRAMATIVE VERIFICATION, WHEN TRYING TO DEPLOY WITH ETHER_API_KEY , WHEN USING Makefile 
1. Programatic verification 
   
2. Push on github



## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

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

### Test

```shell
$ forge test
```

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
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
