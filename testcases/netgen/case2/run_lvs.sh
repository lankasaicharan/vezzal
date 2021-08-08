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

netgen -batch lvs "netA.spice test" "netB.spice test" \
/vezzal/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl \
tc_2_comp.out -json | tee lvs.log

touch ./report2.txt
echo " "
echo "--------Test case 2--------" >> ../final_report.txt
../count_lvs.py tc_2_comp.json >> ./report2.txt
if grep "Total errors = 0" ./report2.txt
then
        echo " Success " >> ../final_report.txt
else
	echo " Fail  " >> ../final_report.txt
        cat ./report2.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

