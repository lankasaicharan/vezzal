#!/bin/bash

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

