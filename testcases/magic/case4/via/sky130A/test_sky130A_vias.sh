#Runs magic and generate reports
for i in {1..4}
do
  magic -dnull -noconsole -rc ../../../.magicrc via$i.mag << EOF | grep "(via" >> report_sky130A_via$i.txt
  select
  puts [drc listall why]
  puts [drc listall count]
  exit
EOF

if diff report_sky130A_via$i.txt test_report_sky130A_via$i.txt >> /dev/null
  then
    echo "via$i.mag file passed" >> ../sky130A_vias_report.txt
  else
    echo "**via$i.mag file failed**" >> ../sky130A_vias_report.txt
    echo "----Generated vs Golden Reference----" >> ../sky130A_vias_report.txt
    diff report_sky130A_via$i.txt test_report_sky130A_via$i.txt >> ../sky130A_vias_report.txt
    echo "-------------------------------------" >> ../sky130A_vias_report.txt
  fi

done
rm report*
