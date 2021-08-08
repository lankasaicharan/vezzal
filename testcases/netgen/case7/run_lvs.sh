#!/bin/sh
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
netgen -batch lvs "netA.spice example_por" "netB.spice example_por" \
sky130A_setup.tcl tc_7_comp.out -json | tee lvs.log
touch ./report7.txt
echo " "
echo "--------Test case 7--------" >> ../final_report.txt
../count_lvs.py tc_7_comp.json >> ./report7.txt
if grep "property failures = 6" ./report7.txt
then
        echo " Success " >> ../final_report.txt
	echo "Found Property errors = 6" >> ../final_report.txt
else
        echo " Fail  " >> ../final_report.txt
        cat ./report7.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt


