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

netgen -batch lvs "netA.spice user_analog_project_wrapper" "netB.spice user_analog_project_wrapper" \
sky130A_setup.tcl tc5_comp.out -json | tee lvs.log


touch ./report5.txt
echo " "
echo "--------Test case 5--------" >> ../final_report.txt
../count_lvs.py tc5_comp.json >> ./report5.txt
if grep "Total errors = 0" ./report5.txt
then
        echo " Success " >> ../final_report.txt
else
	echo " Success  " >> ../final_report.txt
        cat ./report5.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

