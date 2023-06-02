#!/bin/bash

source ./.env

rpc="${RPC}"
address="${ADDRESS}"
gas_object_to_pay="${GAS_OBJECT_TO_PAY}"
primary_coin="${PRIMARY_COIN}"

# Check RPC server
status_code=$(curl -s -X POST -H "Content-Type: application/json" --data "{ \"jsonrpc\":\"2.0\", \"method\":\"sui_getChainIdentifier\",\"id\":1, \"params\": []}" -o /dev/null -w "%{http_code}" $rpc)

if [ $status_code -ne 200 ]; then
    echo "Server $rpc did not return HTTP 200. Please check your server URL in the .env"
    exit 1
fi

# Get address's SuiStaked objects
ids=$(curl -s -X POST -H "Content-Type: application/json" --data "{ \"jsonrpc\":\"2.0\", \"method\":\"suix_getStakes\",\"id\":1, \"params\": [\"$address\"]}" $rpc | jq -r '.result[].stakes[].stakedSuiId')

# Iterate over the IDs and run sui request_withdraw_stake
echo "Withdrawing all sui::SuiStaked objects"

for id in $ids; do
    echo $id
    sui client call --package 0x3 --module sui_system --function request_withdraw_stake --args 0x5 $id --gas-budget=14000000 --gas $gas_object_to_pay > /dev/null 2>&1
    sleep 3
done

# Get address's sui::SUI objects, exclude GAS_OBJECT_TO_PAY and PRIMARY_COIN
echo "Merging all sui::SUI objects to PRIMARY_COIN"
coin_ids=$(curl -s -X POST -H 'Content-Type: application/json' --data "{\"jsonrpc\":\"2.0\", \"id\":1,\"method\":\"suix_getCoins\",\"params\":{\"owner\":\"$address\"},\"coin_type\":\"0x2::sui::SUI\"}" $rpc | jq -r '.result.data[].coinObjectId' | egrep -v "$gas_object_to_pay|$primary_coin")

for id in $coin_ids; do
    echo $id
    sui client merge-coin --primary-coin $primary_coin --coin-to-merge $id  --gas-budget=2000000 --gas $gas_object_to_pay > /dev/null 2>&1
    sleep 3
done
