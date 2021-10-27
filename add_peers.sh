#!/bin/bash

set -e

PEERS_URL=https://raw.githubusercontent.com/eurec4a/ipfs_tools/main/peers.json
CONFIG_FILE=~/.ipfs/config

EXISTING_PEERS=$(cat "$CONFIG_FILE" | jq '[.Peering.Peers[].ID]' || echo "[]")
NEW_PEERS=$(curl "$PEERS_URL" | jq '[.Peers[] | select(.ID as $in | $blacklist | index($in) | not)]' --argjson blacklist "$EXISTING_PEERS")

NEW_PEER_COUNT=`echo "$NEW_PEERS" | jq length`
if [ "$NEW_PEER_COUNT" -eq "0" ]; then
    echo "no new peers to add"
    exit 0
fi

echo "adding new peers:"
echo $NEW_PEERS

cp "$CONFIG_FILE" "${CONFIG_FILE}.bak.`date '+%Y%m%d%H%M%S'`"
tmp=`mktemp`
cat "$CONFIG_FILE" | jq '.Peering.Peers += $newpeers' --argjson newpeers "$NEW_PEERS" > $tmp && mv $tmp $CONFIG_FILE
