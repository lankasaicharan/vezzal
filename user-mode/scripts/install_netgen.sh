#!/bin/bash


#Configuring Vezzal with Netgen"
cd ~/vezzal/tools/
git clone https://github.com/RTimothyEdwards/netgen.git > /dev/null 2>&1
cd netgen/
./configure && make > /dev/null
make install > /dev/null

if netgen -batch
then
	echo "Tool installed successfully"
else
	echo "Tool installation failed"
	cd td/
fi

