#!/bin/bash

source ./.env

rpc="${RPC}"
address="${ADDRESS}"
gas_object_to_pay="${GAS_OBJECT_TO_PAY}"

# Run the curl command and get the list of ids
ids=$(curl -s -X POST -H "Content-Type: application/json" --data "{ \"jsonrpc\":\"2.0\", \"method\":\"suix_getStakes\",\"id\":1, \"params\": [\"$address\"]}" $rpc | jq -r '.result[].stakes[].stakedSuiId')

# Iterate over the IDs and run your command
for id in $ids; do
    echo $id
    sui client call --package 0x3 --module sui_system --function request_withdraw_stake --args 0x5 $id --gas-budget=14000000 --gas $gas_object_to_pay > /dev/null 2>&1
    sleep 3
done

