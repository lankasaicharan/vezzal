#!/bin/bash

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

