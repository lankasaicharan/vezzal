#!/bin/bash

#Configuring Vezzal with Magic"
cd ~/vezzal/tools/
git clone https://github.com/RTimothyEdwards/magic.git > /dev/null 2>&1
cd magic/
./configure && make > /dev/null 2>&1
make install > /dev/null 2>&1

if magic --version
then
	echo "Tool installed successfully"
else
	echo "Tool installation failed"
	cd td/
fi

