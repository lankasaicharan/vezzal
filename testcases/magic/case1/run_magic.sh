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
	echo " Success " >> ../final_report.txt
else
	cat ./report1.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt



