# setwd("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/")

#Import COMID data (dataframe of streamcat variables for each stream segment in CA)
# all.comid<-rbind(read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/Streamcat_v2_AllCOMID_030117/exp_1.csv", stringsAsFactors = F),
#                  read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/Streamcat_v2_AllCOMID_030117/exp_2.csv", stringsAsFactors = F),
#                  read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/Streamcat_v2_AllCOMID_030117/exp_3.csv", stringsAsFactors = F))
# NOT RUN: This adds all the natural factors to COMID
# comid.nats<-read.csv("ALL_COMID_Nats.csv", stringsAsFactors = F)
# all.comid<-join(all.comid, comid.nats[,setdiff(names(comid.nats), "WsAreaSqKm")])

save(all.comid,file="all.comid.Rdata", compress="xz")
load("all.comid.Rdata")
library(plyr)
csci<-join(read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/CSCI_LU_temp_040617.csv", stringsAsFactors = F), #Load data
           read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/CSCI_Nat_temp_061217.csv", stringsAsFactors = F))

#Light data massage
csci$SampleID<-paste(csci$StationCode, csci$SampleDate, csci$CollectionMethodCode, csci$FieldReplicate, sep="_")
csci<-csci[which(!is.na(csci$PctFrstLossWs)),] #Drop rows with missing STREAMCAT data
csci$RdDensCatRp100[is.na(csci$RdDensCatRp100)]<-0

save(csci,file="csci.Rdata", compress="xz")
load("csci.Rdata")


#Simplify variables
#in csci
csci$TotUrb2011Ws<-  rowSums(csci[,c("PctUrbOp2011Ws","PctUrbLo2011Ws","PctUrbMd2011Ws","PctUrbHi2011Ws")])
csci$TotUrb2011Cat<-  rowSums(csci[,c("PctUrbOp2011Cat","PctUrbLo2011Cat","PctUrbMd2011Cat","PctUrbHi2011Cat")])
csci$TotUrb2011WsRp100<-  rowSums(csci[,c("PctUrbOp2011WsRp100","PctUrbLo2011WsRp100","PctUrbMd2011WsRp100","PctUrbHi2011WsRp100")])
csci$TotUrb2011CatRp100<-  rowSums(csci[,c("PctUrbOp2011CatRp100","PctUrbLo2011CatRp100","PctUrbMd2011CatRp100","PctUrbHi2011CatRp100")])
csci$TotAg2011Ws<-  rowSums(csci[,c("PctHay2011Ws","PctCrop2011Ws")])
csci$TotAg2011Cat<-  rowSums(csci[,c("PctHay2011Cat","PctCrop2011Cat")])
csci$TotAg2011WsRp100<-  rowSums(csci[,c("PctHay2011WsRp100","PctCrop2011WsRp100")])
csci$TotAg2011CatRp100<-  rowSums(csci[,c("PctHay2011CatRp100","PctCrop2011CatRp100")])

#in all.comid
all.comid$TotUrb2011Ws<-  rowSums(all.comid[,c("PctUrbOp2011Ws","PctUrbLo2011Ws","PctUrbMd2011Ws","PctUrbHi2011Ws")])
all.comid$TotUrb2011Cat<-  rowSums(all.comid[,c("PctUrbOp2011Cat","PctUrbLo2011Cat","PctUrbMd2011Cat","PctUrbHi2011Cat")])
all.comid$TotUrb2011WsRp100<-  rowSums(all.comid[,c("PctUrbOp2011WsRp100","PctUrbLo2011WsRp100","PctUrbMd2011WsRp100","PctUrbHi2011WsRp100")])
all.comid$TotUrb2011CatRp100<-  rowSums(all.comid[,c("PctUrbOp2011CatRp100","PctUrbLo2011CatRp100","PctUrbMd2011CatRp100","PctUrbHi2011CatRp100")])
all.comid$TotAg2011Ws<-  rowSums(all.comid[,c("PctHay2011Ws","PctCrop2011Ws")])
all.comid$TotAg2011Cat<-  rowSums(all.comid[,c("PctHay2011Cat","PctCrop2011Cat")])
all.comid$TotAg2011WsRp100<-  rowSums(all.comid[,c("PctHay2011WsRp100","PctCrop2011WsRp100")])
all.comid$TotAg2011CatRp100<-  rowSums(all.comid[,c("PctHay2011CatRp100","PctCrop2011CatRp100")])

#Bring in GIS-measured area
gis.area<-read.csv("C:/Users/Raphaelm/Documents/SCCWRP/Channels in developed landscapes/Data/RawData/ModLandscapes/csci_AREA.csv", stringsAsFactors = F)
