

netgen -batch lvs "netA.spice example_por" "netB.spice example_por" /vezzal/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl tc_7_comp.out -json | tee lvs.log
touch ./report7.txt
echo " "
echo "--------Test case 7--------" >> ../final_report.txt
../count_lvs.py tc_7_comp.json >> ./report7.txt
if grep "Total errors = 0" ./report7.txt
then
        echo " Success " >> ../final_report.txt
else
        echo " Fail  " >> ../final_report.txt
        cat ./report7.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt


