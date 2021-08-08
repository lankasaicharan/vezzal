#!/bin/bash
##########################################################################
## Written by Sai Charan Lanka (Author of "Vezzal" tool)
## GNU GENERAL PUBLIC LICENSE
## Version 3, 29 June 2007
##
## Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
## Everyone is permitted to copy and distribute verbatim copies
## of this license document, but changing it is not allowed.
##
##########################################################################

echo ""
echo "#######################################################################"
echo "##                       Welcome to Vezzal                           ##"
echo "##                                                                   ##"
echo "## Vezzal is used in test mode - accepted tools are netgen and magic ##"
echo "#######################################################################"

echo ""

if [ ! -d "open_pdks" ]; then
        #configuring Vezzal with pdk
        cd /vezzal/tools/
        git clone https://github.com/RTimothyEdwards/magic.git > /dev/null 2>&1
        cd ./magic
        ./configure > /dev/null 2>&1
        make
        make install
        cd /vezzal/
        git clone https://github.com/RTimothyEdwards/open_pdks.git
        cd /vezzal/open_pdks/
        ./configure --enable-sky130-pdk --with-sky130-local-path=/vezzal/pdk
        cd ./sky130
	make tools-a; make primitive-a  > /dev/null 2>&1
        #make  
	#make install
        echo "[Info]: Configured Vezzal with PDKs"
fi


#Configuring Vezzal with netgen tool "
cd /vezzal/tools/
git clone https://github.com/RTimothyEdwards/netgen.git > /dev/null 2>&1
cd netgen/
./configure && make > /dev/null 2>&1
make install > /dev/null 2>&1
if [ $(which netgen) ]; then
	cd /vezzal/testcases/netgen/
        for i in $(find -type d -maxdepth 1)
        do
                cd /vezzal/testcases/netgen/$i
                ./run_lvs.sh
        done
        echo " "
        echo " "
        echo "###################################"

        if grep "Fail" /vezzal/testcases/netgen/final_report.txt
        then
                echo "###################################"

                python3 /vezzal/mail-report.py Fail $1 $2
                cd tl

        else
                echo "***Passed***"
                echo " "
                echo "###################################"
                python3 /vezzal/mail-report.py Success $1 $2
		/vezzal/testcases/netgen/clean.sh
        fi
else
	exit(1)
fi

