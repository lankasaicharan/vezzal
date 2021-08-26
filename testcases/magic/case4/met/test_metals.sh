#This will generate a report for the entire metals testcase including all PDKs

for t in sky130A
do
cd /vezzal/testcases/magic/case4/met/$t/
/vezzal/testcases/magic/case4/met/$t/test_$t\_metals.sh
done