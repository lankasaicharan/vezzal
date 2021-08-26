#This will generate a report for the entire metals testcase including all PDKs

for t in sky130A
do
cd /vezzal/testcases/magic/case4/via/$t/
/vezzal/testcases/magic/case4/via/$t/test_$t\_vias.sh
done