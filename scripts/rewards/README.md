# SUI Withdrawer/Merger

## This script make following actions:
- withdraws all staked 0x3::staking_pool::StakedSui objects
- merges all sui::SUI coin objects into PRIMARY_COIN

## Prerequisites
- Tools: Bash, Curl, jq, grep
- Sui binary installed and avaialve
- Validator addreess imported into Sui client


## Usage

First, you need to set your parameters in .env. 
- copy `.env-example` into `.env`
- open `.env` in the text editor and change 

```
RPC="https://sui-rpc-mainnet.testnet-pride.com:443"
ADDRESS=""
GAS_OBJECT_TO_PAY=""
PRIMARY_COIN=""
```


### Note: Tested on MacOS with homebrew

## TODO / roadmap:

- [x] withdraw all staked objects
- [x] merge all sui::SUI coin objects into PRIMARY_COIN
- [ ] withdraw all OR selected staked objects
- [ ] make user select PRIMARY_COIN interactively 
- [ ] transfer all or selected amount to the address 

# Disclaimer

This software is provided as-is with no warranty or guarantees. We take no responsibility for any damages or losses that may occur from using the software. All usage of this software is at your own risk and you are fully responsible for any damages, data loss, or issues that may arise. Please ensure that you understand what the script does before running it.

The software is open-source and we welcome contributions, but we do not assume any liability for any issues that arise from modifications, contributions, or use of this software.

Please remember to always follow ethical and legal guidelines when using and modifying this software.
