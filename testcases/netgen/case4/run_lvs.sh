#!/bin/sh
netgen -batch lvs netA.spice netB.spice \
sky130A_setup.tcl \
tc_4_comp.out -json -blackbox | tee lvs.log

touch ./report4.txt
echo "--------Test case 4--------" >> ../final_report.txt
../count_lvs.py tc_4_comp.json >> ./report4.txt
if grep "Total errors = 0" ./report4.txt
then
        echo " Success " >> ../final_report.txt
else
        echo " Fail  " >> ../final_report.txt
        cat ./report4.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

