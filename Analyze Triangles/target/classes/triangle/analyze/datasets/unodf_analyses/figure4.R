# Figure 4. Generalized Nestedness (GN) across different cut-off level for the biological networks across six organization levels. 

# Summary Plotting Sensitivity analysis, binary matrix and empirical network visualization in different cut-offs
# 1. Molecular level: a) Spliceosome proteins, b) Microsatellites
# 2. Individual level: a) Human cranium Europe, b)Human cranium Howells-F, c) Human cranium Howells-M
# 3. Population level: a) Spotted hyena, b) Dolphin Sotalia guianensis, c) Dolphin Tursiops truncatus
# 4. Meta-population level: a) microsatellite human populations
# 5. Community level: a) Food web Chesapeake, b)Food web Everglades, c)Food web Florida, d) Food web St.Marks
# 6. Meta-community level: a) Functional Reef fishes Length_Diet, b)L_D_Mobility, c)L_D_M_School size d) Taxonomic Reef fishes

#source("analysis.R")


# Overall figure 4
par(mfrow=c(7,3))
par(mar=c(4,4,1,1))
order=c(2,1,3)
for(i in order){
  errbar(x=resultmol[[i]][,1], y=resultmol[[i]][,2], resultmol[[i]][,4], resultmol[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="purple", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
}
order=c(3,2,1)
for(i in order){
  errbar(x=resultind[[i]][,1], y=resultind[[i]][,2], resultind[[i]][,4], resultind[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="blue", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
}
order=c(2,3,1)
for(i in order){
  errbar(x=resultpop[[i]][,1], y=resultpop[[i]][,2], resultpop[[i]][,4], resultpop[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="green", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
}
order=c(1,2,3)
for(i in 1:3){
  errbar(x=resultmep[[i]][,1], y=resultmep[[i]][,2], resultmep[[i]][,4], resultmep[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="yellow", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE)
           title(ylab="Unipartite nestedness (95%CI)")}
}
order=c(2,3,1)
for(i in order){
  errbar(x=resultcom[[i]][,1], y=resultcom[[i]][,2], resultcom[[i]][,4], resultcom[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="orange", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
}  
for(i in order){
  errbar(x=resultcom[[i]][,1], y=resultcom[[i]][,6], resultcom[[i]][,8], resultcom[[i]][,9], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="orange", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=FALSE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
}
order=c(1,2,3)
for(i in order){
  errbar(x=resultmet[[i]][,1], y=resultmet[[i]][,2], resultmet[[i]][,4], resultmet[[i]][,5], ylab="", pch=19, cex=1, xaxt='n', cap=0.03, main="", xlab="", ylim=c(0,1), las=1, col="red", axes=FALSE, frame.plot=TRUE)
  axis(1, at=seq(0, 0.9, length.out=10), las=1, labels=TRUE)
  if(i != order[1]){ axis(2, at=seq(0, 1, length.out=6), las=1, labels=FALSE)
  } else { axis(2, at=seq(0, 1, length.out=6), las=1, labels=TRUE) }
  if(i == order[2]) title(xlab="Cut-off")
}





# 1. Molecular level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfrow=c(1,3))
order=c(2,1,3)
for(i in order){
  errbar(x=resultmol[[i]][,1], y=resultmol[[i]][,2], resultmol[[i]][,4], resultmol[[i]][,5], xlab="Cut-off", ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=names(datamol)[i], ylim=c(0,1), las=1, col="purple")
  axis(1, at=seq(0, 0.9, length.out=10), las=1, xlab="cut-off")
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){
    #plotmat(ordermat(cutmol[[j]][[i]]), scale=F)
    plotmatbin(ordermat(cutmol[[j]][[i]]), colpres="purple", colabs="black")
}}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ gplot(cutmol[[j]][[i]], gmode="graph", usecurve=T)}
}



# 2. Individual level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfrow=c(1,3))
order=c(3,2,1)
for(i in order){
  errbar(x=resultind[[i]][,1], y=resultind[[i]][,2], resultind[[i]][,4], resultind[[i]][,5], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=names(dataind)[i], xlab="Cut-off", ylim=c(0,1), las=1, col="blue")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ 
    #plotmat(ordermat(cutind[[j]][[i]]), scale=F)
    plotmatbin(ordermat(cutind[[j]][[i]]), colpres="blue", colabs="black")
  }
}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ gplot(cutind[[j]][[i]], gmode="graph", usecurve=T)}
}



# 3. Population level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfrow=c(1,3))
order=c(2,3,1)
for(i in order){
  errbar(x=resultpop[[i]][,1], y=resultpop[[i]][,2], resultpop[[i]][,4], resultpop[[i]][,5], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=names(datapop)[i], xlab="Cut-off", ylim=c(0,1), las=1, col="green")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ 
    if(dim(cutpop[[j]][[i]])[1]!=0){
      #plotmat(ordermat(cutpop[[j]][[i]]), scale=F)
      plotmatbin(ordermat(cutpop[[j]][[i]]), colpres="green", colabs="black")
}}}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ 
    if(dim(cutpop[[j]][[i]])[1]!=0){
      gplot(cutpop[[j]][[i]], gmode="graph", usecurve=T)
}}}



# 4. Meta-population level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfrow=c(1,3))
order=c(1,2,3)
for(i in 1:3){
  errbar(x=resultmep[[i]][,1], y=resultmep[[i]][,2], resultmep[[i]][,4], resultmep[[i]][,5], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=names(datamep)[i], xlab="Cut-off", ylim=c(0,1), las=1, col="yellow")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ 
    if(dim(cutmep[[1]][[i]])[1]!=0){
      #plotmat(ordermat(cutmep[[1]][[i]]), scale=F)
      plotmatbin(ordermat(cutmep[[j]][[i]]), colpres="yellow", colabs="black")      
    }}
}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(1,3), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:3){
    if(dim(cutmep[[1]][[i]])[1]!=0){
      gplot(cutmep[[1]][[i]], gmode="graph", usecurve=T)
    }}
}



# 5. Community level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfcol=c(1,3))
order=c(2,3,1)
for(i in order){
  errbar(x=resultcom[[i]][,1], y=resultcom[[i]][,2], resultcom[[i]][,4], resultcom[[i]][,5], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=paste("Nc", names(datacom)[i]), xlab="Cut-off", ylim=c(0,1), las=1, col="orange")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}  

for(i in order){
  errbar(x=resultcom[[i]][,1], y=resultcom[[i]][,6], resultcom[[i]][,8], resultcom[[i]][,9], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=paste("Nr", names(datacom)[i]), xlab="Cut-off", ylim=c(0,1), las=1, col="orange")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){
    if(dim(cutcom[[j]][[i]])[1]!=0){
    #plotmat(ordermat(cutcom[[j]][[i]]), scale=F)
    plotmatbin(ordermat(cutcom[[j]][[i]]), colpres="orange", colabs="black")
}}}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ gplot(cutcom[[j]][[i]], gmode="graph", usecurve=T)}
}



# 6. Metacommunity level ------------------------------------------------------

# Plotting: Sensitivity analysis Nunip x cutoffs
par(mfrow=c(1,3))
order=c(1,2,3)
for(i in order){
  errbar(x=resultmet[[i]][,1], y=resultmet[[i]][,2], resultmet[[i]][,4], resultmet[[i]][,5], ylab="", pch=19, cex=2, xaxt='n', cap=0.03, main=names(datamet)[i], xlab="Cut-off", ylim=c(0,1), las=1, col="red")
  axis(1, at=seq(0, 0.9, length.out=10), las=1)
  if(i == order[1]) title(ylab="Unipartite nestedness (95%CI)")
}

# Plotting: Binary matrices in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){ 
    if(dim(cutmet[[j]][[i]])[1]!=0){
      #plotmat(ordermat(cutmet[[j]][[i]]), scale=F)
      plotmatbin(ordermat(cutmet[[j]][[i]]), colpres="red", colabs="black")
}}}

# Plotting: empirical network plots in different cutoffs
par(mfrow=c(3,10), mar=c(1,1,1,1))
for(j in order){
  for(i in 1:10){
    if(dim(cutmet[[j]][[i]])[1]!=0){
      gplot(cutmet[[j]][[i]], gmode="graph", usecurve=T)
}}}