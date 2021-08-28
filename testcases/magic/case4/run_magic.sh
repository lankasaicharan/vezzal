cd /vezzal/testcases/magic/case4/met/
/vezzal/testcases/magic/case4/met/test_metals.sh
cd /vezzal/testcases/magic/case4/via/
/vezzal/testcases/magic/case4/via/test_vias.sh
cd /vezzal/testcases/magic/case4/

technologies=("sky130A")
echo "--------Test case 4--------" >> ../final_report.txt
echo "-----***Metals***---------" >> ../final_report.txt
for i in $technologies
do
  if grep "failed" ./met/$i\_metals_report.txt || [ -f ./met/$i\_metals_report.txt ]
  then
   cat ./met/$i\_metals_report.txt >> ../final_report.txt
  else
   echo " $i related layout files passed - Success" >> ../final_report.txt
  fi
  rm ./met/$i\_metals_report.txt
done
echo "-------*****-------" >> ../final_report.txt

echo "-----***Vias***---------" >> ../final_report.txt
for i in $technologies
do
  if grep "failed" ./via/$i\_vias_report.txt || [ -f ./via/$i\_vias_report.txt ]
  then
   cat ./via/$i\_vias_report.txt >> ../final_report.txt
  else
   echo " $i related layout files passed - Success" >> ../final_report.txt
  fi
  rm ./via/$i\_vias_report.txt
done
echo "-------*****-------" >> ../final_report.txt
echo "---------------------------" >> ../final_report.txt
