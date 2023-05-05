import os
import sys
import argparse
import json
with open('das_samples.json', 'r') as f:
    sample_card = json.load(f)
    # print(sample_card)

sh_file_template = '''
#!/bin/bash
cmsDriver.py {mc2017} -n -1 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_mc2017_realistic_v8 --step NANO --nThreads 1 --era Run2_2017,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein {filein}  --fileout {fileout} --no_exec
 '''

# # # Step - 3: Get .sh and .jdl file; as produced below
NanoExecutable = "create_nano_py"

# print(sample_card.keys())
with open(NanoExecutable + ".sh","w") as fout:
    for i in range(len(sample_card.keys())):
        for j in sample_card[list(sample_card.keys())[i]]:
            fileout = j.split("/")[-1]
            python_name = list(sample_card.keys())[i] + "_" + fileout.split(".root")[0] 
            fileout  = list(sample_card.keys())[i] + "_" + fileout
            fout.write(sh_file_template.format(mc2017 = python_name,
                                            filein = j,
                                            fileout = fileout
                                            ))