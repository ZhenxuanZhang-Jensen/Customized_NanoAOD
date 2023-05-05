import os
import sys
import argparse
import json
with open('das_samples_UL17_data_resubmit.json', 'r') as f:
    sample_card = json.load(f)

sys.path.append("Utils/python_utils/.")
parser = argparse.ArgumentParser()
parser.add_argument('--StringToChange', type=str,
                    default='TEST',
                    help='String to be added in the output file name')
parser.add_argument('--OutputPath', type=str,
                    default='/eos/user/z/zhenxuan/customized_NanoAOD/',
                    required=False,
                    help='''
                    ''')
parser.add_argument('--EOSdir', type=str,
                    default='/eos/user/z/zhenxuan',
                    required=True,
                    help='''
                    ''')
parser.add_argument('--condorQueue', type=str,
                    default="tomorrow",
                    help='''
                    ''',
                    # Reference: https://twiki.cern.ch/twiki/bin/view/ABPComputing/LxbatchHTCondor#Queue_Flavours
                    choices=['espresso',  # 20min
                             'microcentury',  # 1h
                             'longlunch',  # 2h
                             'workday',  # 8h
                             'tomorrow',  # 1d
                             'testmatch',  # 3d
                             'nextweek'  # 1w
                             ])
args = parser.parse_args()
sh_file_template = '''#!/bin/bash
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
echo ${{PWD}}
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
box_out "Seventh step: nanoAOD"
export SCRAM_ARCH=slc7_amd64_gcc700
cp {cmsswTarFileWithPath} .
tar -xf {NameOfTarFile}
cd {pathWhereCodePlaced}
scramv1 b ProjectRename
eval `scram runtime -sh` # alias of cmsevn command
echo "========================="
echo "pwd : ${{PWD}}"
ls -ltrh
echo "========================="
# Use below sed command if need to edit config file before run
sed -i "s#MiniAODFileWithPath#${{3}}#g"  data2017_NANO.py
# cat for debug, as this will be printed out in stdout of condor log
cat data2017_NANO.py
#cat ${{3}}
echo "========================="
echo "==> cmsRun   data2017_NANO.py"
cmsRun  data2017_NANO.py
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
mkdir ${{5}}
mkdir ${{5}}/${{6}}
cp nano.root /eos/cms/store/group/phys_higgs/cmshgg/zhenxuan/custom_nanoAOD/$5/$6/out_${{4}}_${{1}}_${{2}}.root
date
'''

jdl_file_template_part1of2 = '''Executable = {CondorExecutable}.sh
Universe = vanilla
Notification = ERROR
Should_Transfer_Files = YES
WhenToTransferOutput = ON_EXIT
Transfer_Input_Files = {CondorExecutable}.sh
x509userproxy = $ENV(X509_USER_PROXY)
getenv      = True
+JobFlavour = "{CondorQueue}"
'''

jdl_file_template_part2of2 = '''Output = log/{CondorLogPath}/log_$(Cluster)_$(Process).stdout
Error  = log/{CondorLogPath}/log_$(Cluster)_$(Process).stdout
Log  = log/{CondorLogPath}/log_$(Cluster)_$(Process).stdout
Arguments = $(Cluster) $(Process) {InputRootFileToRun} {tag_name} {year} {dir_for_samples}
Queue 1
'''

# Step - 1: Get the tar file
import makeTarFile  
cmsswDirPath = os.environ['CMSSW_BASE']
CMSSWRel = cmsswDirPath.split("/")[-1]
storeDir = args.EOSdir
makeTarFile.make_tarfile(cmsswDirPath, CMSSWRel + ".tgz")
# # # Step - 2: Copy the tar file to eos;
# # #                            if its cernbox then just cp command with full path will work
# # #                            else you need to use the xrdcp command and path will start from /store/xxx
print "copying the " + CMSSWRel + ".tgz  file to eos path: " + storeDir + "\n"
os.system('cp ' + CMSSWRel + ".tgz" + ' ' + storeDir + '/' + CMSSWRel + ".tgz")
# # Step - 3: Get .sh and .jdl file; as produced below
CondorExecutable = "condor_submit_UL17data"
with open(CondorExecutable + ".sh","w") as fout:
    fout.write(sh_file_template.format(     cmsswTarFileWithPath = storeDir + '/CMSSW_10_6_25.tgz',
                                            NameOfTarFile = CMSSWRel + ".tgz",
                                            pathWhereCodePlaced = "CMSSW_10_6_25/src"
                                            ))


                                            
with open(CondorExecutable + ".jdl","w") as fout:
    fout.write(jdl_file_template_part1of2.format(
                                            CondorExecutable = CondorExecutable,
                                            CondorQueue = "tomorrow"))
    for i in range(len(sample_card.keys())):
      for j in sample_card[list(sample_card.keys())[i]]:
        fileout = j.split("/")[-1]
        tag1 = fileout.split(".root")[0]
        tag2 = tag1.split("-")[-1]
        tag_name = list(sample_card.keys())[i] + "_" + tag2
        fout.write(jdl_file_template_part2of2.format(
                                            CondorLogPath = list(sample_card.keys())[i],
                                            InputRootFileToRun = j,
                                            tag_name = tag_name ,
                                            year = "UL17",
                                            dir_for_samples = list(sample_card.keys())[i]

                                            ))

os.system("chmod 777 "+CondorExecutable+".sh");

print "===> Set Proxy Using:";
print "\tvoms-proxy-init --voms cms --valid 168:00";
print "===> copy proxy to home path"
print "cp /tmp/x509up_u48539 ~/"
print "===> export the proxy"
print "export X509_USER_PROXY=~/x509up_u48539"
print "\"condor_submit "+CondorExecutable+".jdl\" to submit";
# @ZhenxuanZhang-Jensen
