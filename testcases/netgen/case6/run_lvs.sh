#!/bin/sh
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

export MAGIC_EXT_USE_GDS=1
netgen -batch lvs "netA.spice digital_pll" "netB.v digital_pll" \
sky130A_setup.tcl \
tc_6_comp.out -json | tee lvs.log
touch ./report6.txt
echo " "
echo "--------Test case 6--------" >> ../final_report.txt
../count_lvs.py tc_6_comp.json >> ./report6.txt
if grep "Total errors = 0" ./report6.txt
then
        echo " Success " >> ../final_report.txt
else
        echo " Fail  " >> ../final_report.txt
        cat ./report6.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt

