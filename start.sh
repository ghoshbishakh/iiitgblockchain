#!/bin/bash

# echo every command
set -x

# Load config
source $(dirname $0)/../config.sh


# Check org hostnames:
echo $ORG1_HOSTNAME
echo $ORG2_HOSTNAME
echo $ORG3_HOSTNAME

# Fetch ca secret file names:
org1ca="$(ls crypto-config/peerOrganizations/org1.example.com/ca | grep _sk)"
org2ca="$(ls crypto-config/peerOrganizations/org2.example.com/ca | grep _sk)"
org3ca="$(ls crypto-config/peerOrganizations/org3.example.com/ca | grep _sk)"

# run orderer
ORG1_HOSTNAME=$ORG1_HOSTNAME docker stack deploy -c docker-compose-orderer.yaml iiitg

# run ca peers and cli
org1ca=$org1ca org2ca=$org2ca org3ca=$org3ca ORG1_HOSTNAME=$ORG1_HOSTNAME ORG2_HOSTNAME=$ORG2_HOSTNAME ORG3_HOSTNAME=$ORG3_HOSTNAME docker stack deploy -c docker-compose.yaml iiitg
