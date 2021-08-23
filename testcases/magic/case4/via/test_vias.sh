cd /vezzal/testcases/magic/case4/via/
for i in {1,2,3,4}
do
magic -dnull -noconsole -rc ../../.magicrc via$i << EOF | grep "(via*" >> tmp_report.txt
select
drc why
exit
EOF
done

echo "   -----***Via***-----   " >> ../../final_report.txt
../cmp.py "vias" >> ../via_report.txt
sort ../via_report.txt | uniq >> ../report4_via.txt
if grep "Vias - Success" ../report4_via.txt
then
        echo "     Success     " >> ../../final_report.txt
else
        echo "Fail" >> ../../final_report.txt
        cat ../report4_via.txt >> ../../final_report.txt
fi
echo "---------------------------" >> ../../final_report.txt