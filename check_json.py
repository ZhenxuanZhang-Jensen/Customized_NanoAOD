'''
resubmit jobs that are not finished
check the json file root and the local dir root file name, if the same, then pass, else, put the name in the json file to resubmit the jobs
'''
def resubmit_jobs(name_submitted_json, dir_of_local_files, name_resubmitted_json):
    '''open the submitted json file'''
    import json
    with open(name_submitted_json) as f:
	    submitted_json = json.load(f)
    for i in submitted_json.keys():
        print(f"the key name:{i}, have number of files : {len(submitted_json[i])}")

    '''find the file that in json but not in dir'''
    import subprocess
    list_of_keys = list(submitted_json.keys())
    root_file = []
    for index_keys in range(len(list_of_keys)):
        samples_find = [i.split(".root")[0].split('-')[-1] for i in submitted_json[list_of_keys[index_keys]]]
        for i in range(len(samples_find)):
            shell_cmd = 'ls -ltr ' + dir_of_local_files + list_of_keys[index_keys] + '/*' + samples_find[i] + '*'
            return_cmd = subprocess.run(shell_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8',shell=True)
            if return_cmd.returncode != 0:
                # pass
                print("file can't find: %s, tag is : %s" %(return_cmd.stdout,samples_find[i]))
                root_file.append(submitted_json[list_of_keys[index_keys]][i])
            else:
                # print(return_cmd.stdout)
                pass
        # save in the json file
        json_contents = {}
        json_contents[list_of_keys[index_keys]] = root_file
        with open(name_resubmitted_json,'a') as fout:
            json.dump(json_contents,fout,indent=2)
resubmit_jobs(name_submitted_json='/afs/cern.ch/user/z/zhenxuan/CMSSW_10_6_25/src/das_samples_NMSSM_XToYHTo2G2WTo4Q.json', dir_of_local_files='/eos/cms/store/group/phys_higgs/cmshgg/zhenxuan/custom_nanoAOD/das_samples_NMSSM_XToYHTo2G2WTo4Q/', name_resubmitted_json = '/afs/cern.ch/user/z/zhenxuan/CMSSW_10_6_25/src/das_samples_NMSSM_XToYHTo2G2WTo4Q_resubmit.json')