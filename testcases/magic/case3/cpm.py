#!/usr/bin/env python3

import re
import os
f1=open("test_sky130_fd_sc_hd__and2_1.spice","r")
f2=open("sky130_fd_sc_hd__and2_1.spice","r")
f3=open("test_sky130_fd_sc_hd__and2_1.mod.spice","w")
f4=open("sky130_fd_sc_hd__and2_1.mod.spice","w")

for i in f1:
    t=re.sub(r"^C(\d){1,2}","",i)
    print(t.strip(),file=f3)
for i in f2:
    t=re.sub(r"^C(\d){1,2}","",i)
    print(t.strip(),file=f4)
for line in f1:
    if not line.isspace():
        f3.write(line)
for line in f2:
    if not line.isspace():
        f4.write(line)
        
f3.close()
f4.close()

f3=open("test_sky130_fd_sc_hd__and2_1.mod.spice","r")
f4=open("sky130_fd_sc_hd__and2_1.mod.spice","r")
t=[]
u=[]
for i in f3:
    t.append(set(i.split(" ")))
for i in f4:
    u.append(set(i.split(" ")))

for i in t:
    if i not in u:
        print("Failed")
print("Success")

f1.close()
f2.close()
f3.close()
f4.close()
os.system("rm test_sky130_fd_sc_hd__and2_1.mod.spice sky130_fd_sc_hd__and2_1.mod.spice")
