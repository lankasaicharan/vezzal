magic -dnull -noconsole -rc ../.magicrc << EOF >> report2.txt | grep "LEF" > output.txt
lef read ../sky130_fd_sc_hd.lef
EOF
grep "LEF" ./report2.txt > output.txt
touch ./report2.txt
echo " "
echo "--------Test case 2--------" >> ../final_report.txt
if diff ./result.txt ./output.txt
then
	echo " Success " >> ../final_report.txt
else
	cat ./report2.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt
