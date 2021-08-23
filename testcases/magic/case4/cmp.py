#!/usr/bin/env python3
import os
import sys
metals=["met1.1","met1.2","met1.3b","met1.4","met1.5","met1.6","met2.1","met2.2","met2.3b","met2.6","met3.1","met3.2","met3.3d","met3.6","met4.1","met4.2","met4.4a","met4.5b","met5.1","met5.2","met5.3 - via4.4","met5.4"]
vias=["via.1a + 2 * via.4a","via2.4a - via2.4","via2.1a + 2 * via2.4","via3.1 + 2 * via3.4","via3.5 - via3.4","via4.1 + 2 * via4.4"]

flag=0
with open("/vezzal/testcases/magic/case4/met/tmp_report.txt","r") as f1:
    if sys.argv[1] == "metals":
        for i in f1:
            for j in metals:
                if i not in j:
                    print(i+"--not found")
                    flag=1
                else:
                    break
        if flag:
            print("Metals - Success")
        
f1.close()

flag=0
with open("/vezzal/testcases/magic/case4/via/tmp_report.txt","r") as f2:
    if sys.argv[1] == "vias":
        for i in f2:
            for j in vias:
                if i not in j:
                    print(i+"--not found")
                    flag=1
                else:
                    break
        if flag:
            print("Vias - Success")
f2.close()

