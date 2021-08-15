magic -dnull -noconsole -rc ../.magicrc << EOF >> report3.txt
load sky130_fd_sc_hd__and2_1
extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist
ext2spice lvs 
ext2spice cthresh 0.01
ext2spice extresist on
ext2spice
EOF
echo "--------Test case 3--------" >> ../final_report.txt
./cpm.py >> ./report3.txt
if grep "Success" ./report3.txt
then
        echo " Success " >> ../final_report.txt
else
        cat ./report3.txt >> ../final_report.txt
fi
echo "---------------------------" >> ../final_report.txt
