#!/bin/bash

# echo every command
set -x

# Load config
source config.sh

# SCP the entire repository to all hosts at ~/cloudExTest
for i in "${REMOTE_HOSTS[@]}"
do
	echo Setting up $i ====================================================
	echo Cleaning $i ..
	ssh $i 'rm -rf /opt/cloudExTest/*'
	
	echo Copying to $i ..
	scp -r ./client-app/cloudClient $i:/opt/cloudExTest/
	scp -r ./channel-artifacts $i:/opt/cloudExTest/
	scp -r ./crypto-config $i:/opt/cloudExTest/
	scp -r ./cloudExchange $i:/opt/cloudExTest/
	scp -r ./scripts $i:/opt/cloudExTest/

done
