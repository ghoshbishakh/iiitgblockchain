#!/bin/bash

# echo every command
set -x

# Load config
source $(dirname $0)/../config.sh

# Remove stack
docker stack rm cloudex

# Cleaning local artifacts
rm -rf $(dirname $0)/../channel-artifacts/*
rm -rf $(dirname $0)/../crypto-config


# SCP the entire repository to all hosts at ~/cloudExTest
for i in "${REMOTE_HOSTS[@]}"
do
	echo Setting up $i ====================================================
	echo Cleaning $i ..
	ssh $i 'cd /opt/cloudExTest/cloudClient && vagrant destroy --force'
	ssh $i 'rm -rf /opt/cloudExTest/*'

	ssh $i 'docker stop $(docker ps -aq)'
	ssh $i 'docker rm $(docker ps -aq)'
	
	ssh $i 'docker volume rm cloudex_orderer.example.com'
	ssh $i 'docker volume rm cloudex_peer0.org1.example.com'
	ssh $i 'docker volume rm cloudex_peer1.org1.example.com'
	ssh $i 'docker volume rm cloudex_peer0.org2.example.com'
	ssh $i 'docker volume rm cloudex_peer1.org2.example.com'
	ssh $i 'docker volume rm cloudex_peer0.org3.example.com'
	ssh $i 'docker volume rm cloudex_peer1.org3.example.com'

done
