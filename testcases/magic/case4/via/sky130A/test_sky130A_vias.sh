#Runs magic and generate reports
#define an array containing all rules like below but in shell script
#sky130A_via_rules=("(via.1a + 2 * via.4a)" "(via3.4a - via2.4)" "(via2.1a + 2 * via2.4)" "(via3.1 + 2 * via3.4)" "(via3.5 - via3.4)" "(via4.1 + 2 * via4.4)")
sky130A_via_rules=("via.1a" "via.4a" "via3.4a" "via2.4" "via2.1a" "via2.4" "via3.1" "via3.4" "via3.5" "via3.4" "via4.1" "via4.4")
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
    echo "Via "$i" Success" >> ../sky130A_vias_report.txt
  else
    case $i in
       1)
          for j in 0 1
          do
            if grep ${sky130A_via_rules[j]} report_sky130A_via$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_via_rules[j]}"- Not found" >> ../sky130A_vias_report.txt
            fi
          done 
          ;;
       2)
          for j in 2 3 4 5
          do
            if grep ${sky130A_via_rules[j]} report_sky130A_via$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_via_rules[j]}"- Not found" >> ../sky130A_vias_report.txt
            fi
          done 
          ;;
       3)
          for j in 6 7 8 9
          do
            if grep ${sky130A_via_rules[j]} report_sky130A_via$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_via_rules[j]}"- Not found" >> ../sky130A_vias_report.txt
            fi
          done 
          ;;
       4)
          for j in 10 11
          do  
            if grep ${sky130A_via_rules[j]} report_sky130A_via$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_via_rules[j]}"- Not found" >> ../sky130A_vias_report.txt
            fi
          done
          ;;
    esac
  fi

done
rm report*
