#!/bin/bash

touch ../final_report.txt

magic -dnull -noconsole -rc ../.magicrc << EOF > report1.txt
gds read ../sky130_fd_sc_hd.gds
EOF
grep "Reading " report1.txt > output.txt

echo " "
echo "--------Test case 1--------" >> ../final_report.txt
if diff ./result.txt ./output.txt
then
	echo "read sky130_hd_fc_sc.gds successfully " >> ../final_report.txt
else
	echo "***read sky130_hd_fc_sc.gds failed***" >> ../final_report.txt
	echo "---Generated vs Golden Reference---" >> ../final_report.txt
	diff ./result.txt ./output.txt  >> ../final_report.txt
	echo "-----------------------------------" >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt



