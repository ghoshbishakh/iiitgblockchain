#!/bin/bash

# echo every command
set -x


# Fetch ca secret file names:
org1ca="$(ls crypto-config/peerOrganizations/org1.example.com/ca | grep _sk)"
org2ca="$(ls crypto-config/peerOrganizations/org2.example.com/ca | grep _sk)"
org3ca="$(ls crypto-config/peerOrganizations/org3.example.com/ca | grep _sk)"

# run orderer
docker stack deploy -c docker-compose-orderer-SH.yaml iiitg

# run ca peers and cli
org1ca=$org1ca org2ca=$org2ca org3ca=$org3ca docker stack deploy -c docker-compose-SH.yaml iiitg
