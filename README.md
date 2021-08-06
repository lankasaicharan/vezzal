# Vezzal

Vezzal is a CI tool for Netgen and Magic (yet to be supported). This tool is a docker image which has an environment containing all tool dependencies such as libraries and PDK. The latest version of the specific tool is tested against a pre-built test cases database covering core features of that tool and generates a report which can be retrieved using the Vezzal's built-in mailing feature. It takes the advantage of Github actions and the docker technology for continuous integration of tools that are already stored in the github repo.

## Table of Contents

* [**Philosophy**](https://github.com/lankasaicharan/vezzal/blob/master/README.md#philosophy)

* [**Vezzal Tool**](https://github.com/lankasaicharan/vezzal/blob/master/README.md#vezzal-tool)

  > [**Directory Structure**](https://github.com/lankasaicharan/vezzal/blob/master/README.md#directory-structure)
  
  > [**Scripts**](https://github.com/lankasaicharan/vezzal#scripts)
  
  > [**Testcases**](https://github.com/lankasaicharan/vezzal#testcases)

* [**Github Actions**](https://github.com/lankasaicharan/vezzal#github-actions)

  > [**Building the .yml file**](https://github.com/lankasaicharan/vezzal/blob/master/README.md#building-the-yml-file)

* [**Continuous Integration workflow using Github actions and Vezzal**](https://github.com/lankasaicharan/vezzal/blob/main/README.md#day-4-pre-layout-timing-analysis-and-importance-of-good-clock-tree)

* [**Authors**](https://github.com/lankasaicharan/vezzal/blob/master/README.md#authors)

* [**Acknowledgments**](https://github.com/lankasaicharan/vezzal#acknowledgments)

-----------------

## Philosophy

Constant development of tools often breaks something internally which can lead to other issues. Hence there is a need to test the tool for its previous supporting features. But the tool needs an environment to work and good test cases to test the features. That's where Vezzal comes in. The main goal of Vezzal is to provide the tool an environment supporting all dependencies like compilers, libraries etc., and a test cases database which could test the tool its core and supporting features with very few inputs from the user. It can also be used as a standalone environment to work with and exercise opensource EDA tools by using the test cases database as examples to practice. However, this feature needs few modification to the current version but a good understanding of Vezzal can help you to achieve it. In addition to the main goal, authors of Vezzal tries to keep everything simple by following the KISS principle (KEEP IT SIMPLE, STUPID) to avoid any kind of usage restrictions, giving complete freedom to mould Vezzal according to the needs of the user. The CI feature offered by Vezzal couldn't be possible without the docker technology, which is also employed by the OpenLANE, and Github Actions.



## Vezzal Tool

Vezzal is in the form of docker image (as of now) which has the environment to support current open-source EDA tools like Netgen, Magic etc. It includes dependencies such as tcl/tk, gcc, python3, git and many more libraries. The image also includes a test cases database, which is mainly used for CI to tools but can also be used for other misc purposes. Vezzal also comes with individual tool testing scripts and also with a mailing feature to report the result of CI. However, Vezzal tried to keep everything simple and light-weight hence PDKs are installed with only necessary content. The simplicity of Vezzal can also be seen in its structure leaving no obstructions for the user to understand what he/she is doing.

![Vezzal](https://github.com/lankasaicharan/vezzal/blob/master/Images/Vezzal.png)

### **Directory Structure**

The directory named *vezzal* serves as the *home* directory to the tool. It consists of two main directories - *testcases* and *tools*. Tool dependent testcases are stored under the *testcases* directory. All tool installations happen in the *tools* directory. There are two scripts - *test_netgen.sh* and *mail-report.py* which tests the netgen tool and mails the final result to provided mail addresses, respectively.

*Please note that currently **Vezzal** is configured for Netgen tool, hence the mailing python script is configured to Netgen related directory.*  

Under the testcases directory, there are directories which contain scripts and testcases for each individual tool. Currently, **Vezzal** contains testcases and supporting scripts, only for Netgen tool. Similar content will be added for Magic tool very soon. There is a complete freedom to update the testcases, however the present testcases tests the opensource EDA tools for some of their core features.  

Details related to testcases are mentioned in furthur sections.

![Directory Structure](https://github.com/lankasaicharan/vezzal/blob/master/Images/internal%20directory.png)

### **Scripts**

**Vezzal** contains shell scripts which are written for a particular tool, mainly to support testing. Scripts can be identified in two categories. One master script which performs the testing of the tool and many test case related scripts which does the actual testing by communicating with the tool in various fashions. Consider the example of Netgen. There is a master script called *test_netgen.sh* which does the testing of the tool by interacting with various shell scripts present in the each test case directory. (This will be invoked directly with the docker image while performing CI through Github actions.)
There are two arguments to this shell script - list of mail IDs and the passcode for *vezzal mail ID*. Both of them are used for mailing purposes (as you could see that already).

Each testcase directory contains custom shell script which invokes the tool and generates reports accordingly. There are other scripts in the tool-dependent testcases directory such as *count_lvs.py* in the case of Netgen, which supports the counting of errors from the tool output(Thanks to Tim Edwards for providing this).

There is a python script in the *vezzal* directory (home) which mails the final result to the mails IDs mentioned during the launching of testing operation.

### **Testcases**

Testcases are designed to test the core features of a particular tool. Under the *testcases* directory, there are sub-directories with name of the tool which contains all the test cases. Each testcase is named as *case#*. This *case#* directory contains required files such as spice netlists, verilog files, lef files, def files, .mag files, dependent files and shell scripts which invoke the tool in various fashions.
Reports are generated after each case testing and are analyzed to identify the result.

Below is the list of test cases for Netgen which are tested in Vezzal -

#### Netgen

| Testcases                          | Feature                                                | Result |
|------------------------------------|--------------------------------------------------------|--------|
| testcase1 - netA.spice netB.spice  |basic matching                                          |Success |
| testcase2 - netA.spice netB.spice  |introducing **top cell name** along with the netlist file|Success |
| testcase3 - netA.spice netB.spice  |adding *blackbox* option while invoking the tool        |Success |
| testcase4 - netA.spice netB.spice  |adding *permute* to the setup file and testing the swapping of pins |Success |
| testcase5 - netA.spice netB.spice  |testing the general analog spice netlists               |Pins mismatching |
| testcase6 - netA.spice netB.v      |enable variable MAG_EXT_GDS (set to 1) before running netgen         |Success  |
| testcase7 - netA.spice netB.spice  |should able to find the properties difference between magic extracted spice netlist and xschem extracted spice netlist         |   Property errors = 6     |


#### Magic

**To be updated**

## Github Actions

Github Actions makes things easy to automate worflows.Upon various events, the workflow gets triggered and performs the required actions such as building, testing and deployment of one's code present in the Github repo. To develop a workflow, a *.yml* file is required which follows a particular syntax which includes the presense of events, jobs etc.

### **Building the *.yml* file**

**Vezzal** uses Github actions to perform CI to tools. The *.yml* file is stored in *.github/workflows* directory in the Github repo. This file contains the following main steps:
 >Pull the docker image
 
 >Start the container for the image
 
 >Run the appropriate script to test the tool


## Continuous Integration workflow using Github actions and Vezzal

Continuous Integration workflow using Github actions and Vezzal is clearly explained in the below image. Upon push or pull to the tool's Github repo, the workflow gets triggered. First, the docker image of the Vezzal is pulled from the docker hub and a container is started for that image. Then, the tool related test script is executed.
The updated tool's Github repo is pulled into the Vezzal environment and the tool is installed.Upon successful installation of the tool, related testcases are used to the test the tool which furthur generate two kinds of reports - local testcase report and a general tool report.Now the reports are analyzed and the result is mailed to the list of mail IDs mentioned along with the test script at the beginning.This is the end of CI.
**It starts from the contributor updating the tool's Github repository and will end with a message sent to the contributor.**

![CI workflow with Github actions and Vezzal](https://github.com/lankasaicharan/vezzal/blob/master/Images/CI%20workflow.png)

## Authors

**Vezzal** is designed and developed by **Sai Charan Lanka** who currently works as an EDA CAD intern at **onsemi**, India.

## Acknowledgments

1. Tim Edwards - Founder (Opencircuitdesign), SVP (Analog and Tools - efabless)
2. Kunal Ghosh - Co-founder (VSD Corp. Pvt. Ltd)

