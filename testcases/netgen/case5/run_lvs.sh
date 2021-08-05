#!/bin/bash
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

