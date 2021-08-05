#!/bin/sh
netgen -batch lvs netA.spice netB.spice \
/vezzal/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl \
tc_3_comp.out -json -blackbox | tee lvs.log

touch ./report3.txt
echo " "
echo "--------Test case 3--------" >> ../final_report.txt
../count_lvs.py tc_3_comp.json >> ./report3.txt
if grep "Total errors = 0" ./report3.txt
then
        echo " Success " >> ../final_report.txt
else
	echo " Fail " >> ../final_report.txt
        cat ./report3.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

