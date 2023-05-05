whichSample=$1

if [ $whichSample == 1 ]; then
    echo "running mc"
    cmsDriver.py test_nanoTuples_mc2018 -n 1000 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_upgrade2018_realistic_v15_L1v1 --step NANO --nThreads 1 --era Run2_2018,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein /store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/CCA98048-BF07-204D-8620-9D285B30408B.root --fileout file:nano_mc2018_M1000.root --customise_commands "process.options.wantSummary = cms.untracked.bool(True)" >& test_mc2018_M1000.log &

fi
if [ $whichSample == 2 ]; then
    echo "running data"
    cmsDriver.py test_nanoTuples_data2018abc -n 1000 --data --eventcontent NANOAOD --datatier NANOAOD --conditions 106X_dataRun2_v32 --step NANO --nThreads 1 --era Run2_2018,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeData --filein /store/data/Run2018D/JetHT/MINIAOD/12Nov2019_UL2018_rsb-v1/270000/100C831A-70F3-B645-8D7D-0A4474767984.root --fileout file:nano_data2018.root --customise_commands "process.options.wantSummary = cms.untracked.bool(True)" >& test_data2018.log &
    
fi

if [ $whichSample == 3 ]; then
    echo "running create mc 17 file"
    cmsDriver.py mc2017 -n -1 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_mc2017_realistic_v8 --step NANO --nThreads 1 --era Run2_2017,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein /store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/CCA98048-BF07-204D-8620-9D285B30408B.root  --fileout UL17_nano.root --no_exec
    
fi

if [ $whichSample == 4 ]; then
    echo "running crab mc 17"
    python crab.py -p mc2017_NANO.py --site T2_CH_CERN -o /eos/cms/store/group/phys_higgs/cmshgg/zhenxuan -t NanoTuples-[2] -i mc.txt --num-cores 1 --send-external -s FileBased -n 2 --work-area crab_projects_mc --dryrun
    # python crab.py -p mc2017_NANO.py --site T2_CH_CERN -o /store/user/$USER/outputdir -t NanoTuples-[version] -i mc.txt --num-cores 1 --send-external -s FileBased -n 2 --work-area crab_projects_mc --dryrun
    
fi

if [ $whichSample == 5 ]; then
    echo "running data 17"
    cmsDriver.py data2017 -n -1 --data --eventcontent NANOAOD --datatier NANOAOD --conditions 106X_dataRun2_v32 --step NANO --nThreads 1 --era Run2_2017,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeData --filein "/store/data/Run2017E/DoubleEG/MINIAOD/UL2017_MiniAODv2-v1/280000/B0D5F548-A65F-1540-89AC-168E337FB635.root" --fileout file:nano.root --no_exec
    
fi
if [ $whichSample == 6 ]; then
    echo "running data 18"
    
    cmsDriver.py data2018 -n -1 --data --eventcontent NANOAOD --datatier NANOAOD --conditions 106X_dataRun2_v32 --step NANO --nThreads 1 --era Run2_2018,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeData --filein "/store/mc/RunIISummer20UL17MiniAODv2/GJet_Pt-20to40_DoubleEMEnriched_MGG-80toInf_TuneCP5_13TeV_Pythia8/MINIAODSIM/106X_mc2017_realistic_v9-v5/30000/F4774BA7-941C-BC42-BCAD-01B0BF1F8AA9.root" --fileout file:nano.root --no_exec
    
fi
if [ $whichSample == 7 ]; then
    echo "running create mc 18 file"
    cmsDriver.py mc2018 -n -1 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_upgrade2018_realistic_v15_L1v1 --step NANO --nThreads 1 --era Run2_2018,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein "/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-280_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/85F078A9-722D-A140-B9ED-5129C54E59A4.root"  --fileout file:nano.root --no_exec
    
fi
if [ $whichSample == 8 ]; then
    echo "running create data 16"
    cmsDriver.py data2016 -n -1 --data --eventcontent NANOAOD --datatier NANOAOD --conditions 106X_dataRun2_v32 --step NANO --nThreads 1 --era Run2_2016,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeData --filein "/store/data/Run2016H/DoubleEG/MINIAOD/UL2016_MiniAODv2-v1/280000/FD408781-7856-EC4A-945C-05E9AD117DD9.root" --fileout file:nano.root --no_exec
fi

if [ $whichSample == 9 ]; then
    echo "running create mc 16 file"
    cmsDriver.py mc2018 -n -1 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_upgrade2018_realistic_v15_L1v1 --step NANO --nThreads 1 --era Run2_2018,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein "/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-280_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/85F078A9-722D-A140-B9ED-5129C54E59A4.root"  --fileout file:nano.root --no_exec
    
fi

# cmsDriver.py mc2016 -n -1 --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --conditions 106X_mcRun2_asymptotic_v15 --step NANO --nThreads 1 --era Run2_2016,run2_nanoAOD_106Xv1 --customise PhysicsTools/NanoTuples/nanoTuples_cff.nanoTuples_customizeMC --filein file:step-1.root --fileout file:nano.root --no_exec


# ['/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/CCA98048-BF07-204D-8620-9D285B30408B.root\n', 
# '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/582512F4-C977-2049-ACD0-1C6B85BA3931.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/820ABF59-D90D-9E43-8E7D-CF404E8F9FD7.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/6C2E40DA-C1D4-E846-B4E5-FA4C066E133D.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/B6A6B74E-0B3D-D94C-A493-C129DB717559.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/83ECE794-1A16-8E4F-8107-4B4F04681651.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/B0B3D8EF-D5B6-C243-8627-75D366F040A7.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/4B042568-E3C1-E641-8A26-B9D6D94A702C.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/75647954-DE3C-8F45-92B8-2F9CCCEE5D43.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/B2B405B5-DB5E-6E44-99AF-301C59E43226.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/D8C9BF71-8426-7B4A-94DC-C0C3949D4DD7.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/9A5DC465-3602-E14E-B275-B741E0D2370F.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/BB631DE9-D1A5-2C47-BADC-1992C67FD150.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/D75EB1BD-9DBB-2649-B03D-AE3D5D1C571E.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/973DDA7D-C323-6C40-9B00-CD3BFF00C096.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/533A7304-8F52-4E43-8503-29484F8E9EC6.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/75295453-7E93-CD40-B18B-3549508FE89F.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/5B0D622B-5891-9C45-B6F4-3400B2420E19.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/117EFB00-FDE9-184D-8FBB-D426EC466A5D.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/F3D1F41E-92B4-2A4F-B43E-8B59CDB26169.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/85ED6033-A18F-D043-AF4B-4449595B81F4.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/FD72B95E-DA80-A94A-B7FE-5C4C615F6208.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/04D3FBF0-A539-5143-9A1C-8D42A1D54C88.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/123F6F55-7095-A740-BDCC-6FDE378D0E1B.root\n', '/store/mc/RunIISummer20UL18MiniAODv2/GluGluToRadionToHHTo2G2WTo2G4Q_M-1000_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/MINIAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/50000/EEED7589-184B-F040-8ACF-C01A2E84CE6B.root\n']