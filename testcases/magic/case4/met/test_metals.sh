cd /vezzal/testcases/magic/case4/met/
for i in {1,2,3,4,5}
do
magic -dnull -noconsole -rc ../../.magicrc met$i << EOF | grep "(met$i." >> tmp_report.txt
select
drc why
exit
EOF
done

echo "--------Test case 4--------" >> ../../final_report.txt
echo "   -----***Metal***-----   " >> ../../final_report.txt
../cmp.py "metals" >> ../met_report.txt
sort ../met_report.txt | uniq >> ../report4_met.txt
if grep "Metals - Success" ../report4_met.txt
then
        echo "     Success     " >> ../../final_report.txt
else
        echo "Fail" >> ../../final_report.txt
        cat ../report4_met.txt >> ../../final_report.txt
fi


