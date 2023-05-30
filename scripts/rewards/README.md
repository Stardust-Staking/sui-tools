# SUI Withdrawer/Merger

## This script make following activions
- withdraws all staked 0x3::staking_pool::StakedSui objects
- merged all sui::SUI coin objects into PRIMARY_COIN

## Prerequisites
- tools: Bash, Curl, jq, grep
- Sui binary installed and avaialve
- Validator addreess imported into Sui client


## Usage

First, you need to set your parameters in .env. 
- copy `.env-example` into `.env`
- .env in text editor and change 

```
RPC="https://sui-rpc-mainnet.testnet-pride.com:443"
ADDRESS=""
GAS_OBJECT_TO_PAY=""
PRIMARY_COIN=""
```


Tested on MacOS with homebrew

## TODO / roadmap:

- [x] withdraw all staked objects
- [x] merge all sui::SUI coin objects into PRIMARY_COIN
- [ ] withdraw all OR selected staked objects
- [ ] make user select PRIMARY_COIN interactively 
- [ ] transfer all or selected amount to the address 
