#Runs magic and generate reports

for i in {1..5}
do
  magic -dnull -noconsole -rc ../../../.magicrc met$i.mag << EOF | grep "Metal" >> report_sky130A_met$i.txt
  select
  puts [drc listall why]
  puts [drc listall count]
  exit
EOF
  if diff report_sky130A_met$i.txt test_report_sky130A_met$i.txt >> /dev/null
  then
    echo "met$i.mag testcase passed" >> ../sky130A_metals_report.txt
  else
    echo "**met$i.mag testcase failed**" >> ../sky130A_metals_report.txt
    echo "----Generated vs Golden Reference----" >> ../sky130A_metals_report.txt
    diff report_sky130A_met$i.txt test_report_sky130A_met$i.txt >> ../sky130A_metals_report.txt
    echo "-------------------------------------" >> ../sky130A_metals_report.txt
  fi
done
rm report_sky130A_*
