# Vezzal 

### **(made-up name from "vessel" indicating that this tool is a container containing most of the library dependencies and PDK info for the EDA tools it supports)**

🤝 Help needed to improve Vezzal. Please feel free do to a pull request to improve the coding. There is a huge scope for it.

**CI is supported to below tools via Vezzal** - 
* **Netgen -** ![](https://github.com/RtimothyEdwards/netgen/actions/workflows/main.yml/badge.svg)
* **Magic -**  ![](https://github.com/RtimothyEdwards/magic/actions/workflows/main.yml/badge.svg)

**Available tools that can be used in user mode*
* **Netgen**
* **Magic**
* Xschem
* PDK
* ...

:warning: **This version of Vezzal needs code and testcases optimization.**

Vezzal is a tool currrently supporting CI for Netgen and Magic. This tool is a docker image which has an environment containing all tool dependencies such as libraries and PDK info. The latest version of the specific tool is tested against a pre-built test cases database covering core features of that tool and generates a report which can be retrieved using the Vezzal's built-in mailing feature. It takes the advantage of Github actions and the docker technology for continuous integration of tools that are already stored in the github repo.

**Vezzal docker image - https://hub.docker.com/r/vezzal/vezzal**

* **vezzal:v1 is used for testing purposes.(Test mode)**
* **vezzal:v0 is used for general tool usage purposes.(User mode)**


## Table of Contents

* [**Philosophy**](https://github.com/lankasaicharan/vezzal/#philosophy)

* [**Vezzal Tool**](https://github.com/lankasaicharan/vezzal/#vezzal-tool)

* [**User Mode**](https://github.com/lankasaicharan/vezzal/#user-mode)

* [**Test Mode**](https://github.com/lankasaicharan/vezzal/#test-mode)

  > [**Directory Structure**](https://github.com/lankasaicharan/vezzal/#directory-structure)
  
  > [**Scripts**](https://github.com/lankasaicharan/vezzal#scripts)
  
  > [**Testcases**](https://github.com/lankasaicharan/vezzal#testcases)

* [**Github Actions**](https://github.com/lankasaicharan/vezzal#github-actions)

  > [**Building the .yml file**](https://github.com/lankasaicharan/vezzal/#building-the-yml-file)

* [**Continuous Integration workflow using Github actions and Vezzal**](https://github.com/lankasaicharan/vezzal/#day-4-pre-layout-timing-analysis-and-importance-of-good-clock-tree)

* [**Authors**](https://github.com/lankasaicharan/vezzal/#authors)

* [**Acknowledgments**](https://github.com/lankasaicharan/vezzal#acknowledgments)

-----------------

## Philosophy

Constant development of tools often breaks something internally which can lead to other issues. Hence there is a need to test the tool for its previous supporting features. But the tool needs an environment to work and good test cases to test the features. This problem is solved by "Vezzal". It is a containerized environment which can be operated in two modes - user mode and test mode. In the test mode of Vezzal, the tool is provided with an environment supporting all dependencies like compilers, libraries etc., and a test cases database which could test the tool its core and supporting features with a very few inputs from the user. The testing can be done through GitHub Actions feature to trigger the Vezzal because of any changes to the tool, thus supporting the continuous integration (CI) of tools. Currently, the Vezzal is supporting the CI for Magic and Netgen tools at a basic level. In the user mode, Vezzal can be used to work with the supporting open-source EDA tools without worrying about the tool dependencies and can exercise them using the test cases database as examples. In addition to the main goal, authors of Vezzal tries to keep everything simple by following the KISS (KEEP IT SIMPLE, STUPID) principle to avoid any kind of usage restrictions, giving complete freedom to mould Vezzal according to the needs and requirements of the user. The CI feature offered by Vezzal couldn't be possible without the docker technology, which is also employed by the OpenLane, and GitHub Actions.ons.


## Vezzal Tool

Vezzal is in the form of docker image (as of now) which has the environment to support current open-source EDA tools like Netgen, Magic etc. It includes dependencies such as tcl/tk, gcc, python3, git and many more libraries. 

![Vezzal](https://github.com/lankasaicharan/vezzal/blob/master/Images/Vezzal.png)

### User mode
Vezzal can be used in User mode which is nothing but containerizing the EDA tools without bothering about the dependecies installation on your system. Currently, Vezzal can be used to run Netgen and Magic. Since Magic needs to be used in GUI mode (for more functionalities), the docker container must be run by using the local Xserver which is available for every linux desktop environment. Vezzal can be started using - 
```
docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" vezzal/vezzal:v0 bash
```
This will run the vezzal container with an interactive terminal.

Internally, there is a make file which helps to install, uninstall and update desired tools and PDK.
```
make [[clean_/update_]netgen/magic/xschem/sky130a_pdks]
```
Since this is a docker container, all sort of docker advantages are applicable to Vezzal.

### Test mode
The image also includes a test cases database, which is mainly used for CI to tools but can also be used for other misc purposes. Vezzal also comes with individual tool testing scripts and also with a mailing feature to report the result of CI. However, Vezzal tried to keep everything simple and light-weight hence PDKs are installed with only necessary content. The simplicity of Vezzal can also be seen in its structure leaving no obstructions for the user to understand what he/she is doing.


#### **Directory Structure**

The directory named *vezzal* serves as the *home* directory to the tool. It consists of two main directories - *testcases* and *tools*. Tool dependent testcases are stored under the *testcases* directory. All tool installations happen in the *tools* directory. There are two scripts - *test_netgen.sh* and *mail-report.py* which tests the netgen tool and mails the final result to provided mail addresses, respectively.

*Please note that currently **Vezzal** is configured for Netgen tool, hence the mailing python script is configured to Netgen related directory.*  

Under the testcases directory, there are directories which contain scripts and testcases for each individual tool. Currently, **Vezzal** contains testcases and supporting scripts, only for Netgen tool. Similar content will be added for Magic tool very soon. There is a complete freedom to update the testcases, however the present testcases tests the opensource EDA tools for some of their core features.  

Details related to testcases are mentioned in furthur sections.

![Directory Structure](https://github.com/lankasaicharan/vezzal/blob/master/Images/internal%20directory.png)

#### **Scripts**

**Vezzal** contains shell scripts which are written for a particular tool, mainly to support testing. Scripts can be identified in two categories. One master script which performs the testing of the tool and many test case related scripts which does the actual testing by communicating with the tool in various fashions. Consider the example of Netgen. There is a master script called *test_netgen.sh* which does the testing of the tool by interacting with various shell scripts present in the each test case directory. (This will be invoked directly with the docker image while performing CI through Github actions.)
There are two arguments to this shell script - list of mail IDs and the passcode for *vezzal mail ID*. Both of them are used for mailing purposes (as you could see that already).

Each testcase directory contains custom shell script which invokes the tool and generates reports accordingly. There are other scripts in the tool-dependent testcases directory such as *count_lvs.py* in the case of Netgen, which supports the counting of errors from the tool output(Thanks to Tim Edwards for providing this).

There is a python script in the *vezzal* directory (home) which mails the final result to the mails IDs mentioned during the launching of testing operation.

#### **Testcases**

Testcases are designed to test the core features of a particular tool. Under the *testcases* directory, there are sub-directories with name of the tool which contains all the test cases. Each testcase is named as *case#*. This *case#* directory contains required files such as spice netlists, verilog files, lef files, def files, .mag files, dependent files and shell scripts which invoke the tool in various fashions.
Reports are generated after each case testing and are analyzed to identify the result.

Below is the list of test cases for Netgen which are tested in Vezzal -

##### Netgen

| Testcases                          | Feature                                                | Result |
|------------------------------------|--------------------------------------------------------|--------|
| testcase1 - netA.spice netB.spice  |basic matching                                          |Success |
| testcase2 - netA.spice netB.spice  |introducing **top cell name** along with the netlist file|Success |
| testcase3 - netA.spice netB.spice  |adding *blackbox* option while invoking the tool        |Success |
| testcase4 - netA.spice netB.spice  |adding *permute* to the setup file and testing the swapping of pins |Success |
| testcase5 - netA.spice netB.spice  |testing the general analog spice netlists               |Pins mismatching |
| testcase6 - netA.spice netB.v      |enable variable MAG_EXT_GDS (set to 1) before running netgen         |Success  |
| testcase7 - netA.spice netB.spice  |should able to find the properties difference between magic extracted spice netlist and xschem extracted spice netlist         |   Property errors = 6     |


##### Magic

| Testcases                          | Feature                                                | Result |
|------------------------------------|--------------------------------------------------------|--------|
| testcase1 - result.txt testing.sh  |Testing gds read option                                   |Success |
| testcase2 - result.txt testing.sh  |Testing lef read option                                 |Success |
| testcase3 - cmp.py, testing.sh, testing version of spice netlist |Testing the extraction feature |Success |
| testcase4 - met, via  |Testing drc checking feature of magic. Currently tests with sky130A technology based rules. Another set of open PDKs will be added soon|Success |

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
A huge thanks to **Tim Edwards** for helping in building the testcases database and providing a constant feedback for the tool's foundation.

## Acknowledgments

1. Tim Edwards - Founder (Opencircuitdesign), SVP (Analog and Tools - efabless)
2. Kunal Ghosh - Co-founder (VSD Corp. Pvt. Ltd)

