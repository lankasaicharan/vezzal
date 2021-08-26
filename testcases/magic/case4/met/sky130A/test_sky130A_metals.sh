#Runs magic and generate reports
#define an array containing all rules like below but in shell script
sky130A_metal_rules=("met1.1" "met1.2" "met1.3b" "met1.4" "met1.5" "met1.6" "met2.1" "met2.2" "met2.3b" "met2.6" "met3.1" "met3.2" "met3.3d" "met3.6" "met4.1" "met4.2" "met4.4a" "met4.5b" "met5.1" "met5.2" "met5.3 - via4.4" "met5.4")

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
    echo "Metal "$i" Success" >> ../sky130A_metals_report.txt
  else
    case $i in
       1)
          for j in {0..5}
          do
            if grep ${sky130A_metal_rules[j]} report_sky130A_met$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_metal_rules[j]}"- Not found" >> ../sky130A_metals_report.txt
            fi
          done 
          ;;
       2)
          for j in {6..9}
          do
            if grep ${sky130A_metal_rules[j]} report_sky130A_met$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_metal_rules[j]}"- Not found" >> ../sky130A_metals_report.txt
            fi
          done 
          ;;
       3)
          for j in {10..13}
          do
            if grep ${sky130A_metal_rules[j]} report_sky130A_met$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_metal_rules[j]}"- Not found" >> ../sky130A_metals_report.txt
            fi
          done 
          ;;
       4)
          for j in {14..17}
          do
            if grep ${sky130A_metal_rules[j]} report_sky130A_met$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_metal_rules[j]}"- Not found" >> ../sky130A_metals_report.txt
            fi
          done 
          ;;
       5)
          for j in {17..21}
          do
            if grep ${sky130A_metal_rules[j]} report_sky130A_met$i.txt >> /dev/null
            then 
              continue
            else
              echo "Sky130A rule - "${sky130A_metal_rules[j]}"- Not found" >> ../sky130A_metals_report.txt
            fi
          done 
          ;;
    esac
  fi
done
rm report_sky130A_*
