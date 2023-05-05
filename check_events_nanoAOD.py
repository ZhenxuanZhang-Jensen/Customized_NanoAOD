import uproot
# three prefix for root file : root://cms-xrd-global.cern.ch/,root://cmsxrootd.fnal.gov/ , root://xrootd-cms.infn.it
mini_events = uproot.open("root://cms-xrd-global.cern.ch//store/data/Run2017D/DoubleEG/MINIAOD/UL2017_MiniAODv2-v1/270000/55BFC0CF-87FD-C343-87CE-49941651B053.root")
print(mini_events.keys())
nano_events = uproot.open("out_UL17_dataD_49941651B053_427696_0.root")
