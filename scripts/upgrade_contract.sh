#!/bin/bash
set -e

# Usage: ./upgrade_contract.sh <CONTRACT_ID> <WASM_FILE> <NETWORK>
# Example: ./upgrade_contract.sh C... contracts/grainlify-core/target/wasm32-unknown-unknown/release/grainlify_core.wasm testnet

CONTRACT_ID=$1
WASM_FILE=$2
NETWORK=${3:-testnet}

if [ -z "$CONTRACT_ID" ] || [ -z "$WASM_FILE" ]; then
    echo "Usage: $0 <CONTRACT_ID> <WASM_FILE> [NETWORK]"
    exit 1
fi

echo "Installing WASM..."
WASM_HASH=$(soroban contract install --wasm "$WASM_FILE" --network "$NETWORK" --source-account default)
echo "WASM Hash: $WASM_HASH"

echo "Upgrading contract..."
soroban contract invoke \
    --id "$CONTRACT_ID" \
    --network "$NETWORK" \
    --source-account default \
    -- \
    upgrade \
    --new_wasm_hash "$WASM_HASH"

echo "Upgrade complete."
