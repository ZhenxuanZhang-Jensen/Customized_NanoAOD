#!/bin/bash
echo "Starting job on " `date`
echo "Running on: `uname -a`"
echo "System software: `cat /etc/redhat-release`"
source /cvmfs/cms.cern.ch/cmsset_default.sh
echo "###################################################"
echo "#    List of Input Arguments: "
echo "###################################################"
echo "Input Arguments (Cluster ID): $1"
echo "Input Arguments (Proc ID): $2"
echo "Input Arguments (Root file name with path): $3"
echo "Input Arguments (Tag got from miniAOD file): $4"
echo "Input Arguments (Tag got from miniAOD file): $4"
echo "Input Arguments (Year): $5"
echo "Input Arguments (Directory for different sample): $6"
echo "###################################################"
echo "======="
ls -ltrh
echo "======"
echo ${PWD}
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
box_out "Seventh step: nanoAOD"
export SCRAM_ARCH=slc7_amd64_gcc700
cp /eos/user/z/zhenxuan/customized_NanoAOD/CMSSW_10_6_25.tgz .
tar -xf CMSSW_10_6_25.tgz
cd CMSSW_10_6_25/src
scramv1 b ProjectRename
eval `scram runtime -sh` # alias of cmsevn command
echo "========================="
echo "pwd : ${PWD}"
ls -ltrh
echo "========================="
# Use below sed command if need to edit config file before run
sed -i "s#MiniAODFileWithPath#${3}#g"  NANO.py
sed -i "s#production info nevts:-1#${4} nevts:-1#g"  NANO.py
# cat for debug, as this will be printed out in stdout of condor log
cat NANO.py
#cat ${3}
echo "========================="
echo "==> cmsRun   nano_py/NANO.py"
cmsRun  nano_py/NANO.py
echo "========================="
echo "==> List all files..."
ls -ltrh
echo "+=============================="
echo "List all root files = "
ls -ltrh *.root
echo "+=============================="
# copy output to eos
echo "xrdcp output for condor"
echo "+=============================="
mkdir ${5}
mkdir ${5}/${6}
cp nano.root /eos/user/z/zhenxuan/customized_NanoAOD/$5/$6/out_${4}_${1}_${2}.root
date
