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

touch ../final_report.txt


netgen -batch lvs "netA.spice" "netB.spice" \
/vezzal/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl \
tc_1_comp.out -json | tee lvs.log

touch ./report1.txt
echo " "
echo "--------Test case 1--------" >> ../final_report.txt
echo " " >> ../report.txt
../count_lvs.py tc_1_comp.json >> ./report1.txt
if grep "Total errors = 0" ./report1.txt
then
        echo " Success " >> ../final_report.txt
else
	echo " Fail  " >> ../final_report.txt
        cat ./report1.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

