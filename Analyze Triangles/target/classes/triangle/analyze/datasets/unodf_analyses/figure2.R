# Figure 2. Adjacency matrices and network representation of 18 empirical biological systems across six organization levels. 

# Pulling the info to create figure 2: plot of matrices and/or networks for all systems
fig2 <- list(ordermat(cutmol[[3]][[which.max(resultmol[[2]][,2])]], symmetry=TRUE), # 1 spliceosome
             ordermat(cutmol[[1]][[which.max(resultmol[[1]][,2])]], symmetry=TRUE), # 2 C.elegans genes
             ordermat(cutmol[[2]][[which.max(resultmol[[3]][,2])]], symmetry=TRUE), # 3 Yeast Nuclear exosome
             ordermat(cutind[[3]][[which.max(resultind[[3]][,2])]], symmetry=TRUE), # 4 cranium Howell M
             ordermat(cutind[[2]][[which.max(resultind[[2]][,2])]], symmetry=TRUE), # 5 cranium Howell F
             ordermat(cutind[[1]][[which.max(resultind[[1]][,2])]], symmetry=TRUE), # 6 cranium Europe
             ordermat(cutpop[[2]][[which.max(resultpop[[2]][,2])]], symmetry=TRUE), # 7 sotalia
             ordermat(cutpop[[3]][[which.max(resultpop[[3]][,2])]], symmetry=TRUE), # 8 tursiops
             ordermat(cutpop[[1]][[which.max(resultpop[[1]][,2])]], symmetry=TRUE), # 9 hyena
             ordermat(cutmep[[1]][[which.max(resultmep[[1]][,2])]], symmetry=TRUE), # 10 Microsatellite frog
             ordermat(cutmep[[2]][[which.max(resultmep[[2]][,2])]], symmetry=TRUE), # 11 Microsatellite human
             ordermat(cutmep[[3]][[which.max(resultmep[[3]][,2])]], symmetry=TRUE), # 12 Microsatellite sparrow
             ordermat(cutcom[[2]][[which.max(resultcom[[2]][,2])]], symmetry=FALSE), # 13 mangrove wet foodweb
             ordermat(cutcom[[3]][[which.max(resultcom[[3]][,2])]], symmetry=FALSE), # 14 narragen foodweb
             ordermat(cutcom[[1]][[which.max(resultcom[[1]][,2])]], symmetry=FALSE), # 15 baydry foodweb
             ordermat(cutmet[[1]][[which.max(resultmet[[1]][,2])]], symmetry=TRUE), # 16 Genera Reef fishes
             ordermat(cutmet[[2]][[which.max(resultmet[[2]][,2])]], symmetry=TRUE), # 17 LD Reef fishes
             ordermat(cutmet[[3]][[which.max(resultmet[[3]][,2])]], symmetry=TRUE)) # 18 LDMS Reef fishes

rownames(fig2) <- c(names(resultmol)[2],names(resultmol)[1],names(resultmol)[3],
                    names(resultind)[3],names(resultind)[2],names(resultind)[1],
                    names(resultpop)[2],names(resultpop)[3],names(resultpop)[1],
                    names(resultmep)[1],names(resultmep)[2],names(resultmep)[3],
                    names(resultcom)[2],names(resultcom)[3],names(resultcom)[1],
                    names(resultmet)[1],names(resultmet)[2],names(resultmet)[3])

# Plotting: Binary matrices ## VERY LARGE IMAGE
par(mfrow=c(5,3), mar=c(1,1,1,1))
for(i in 1:length(fig2)){ plotmat(fig2[[i]], scale=F)}

# Plotting: empirical network plots ### VERY SLOW!
colore = c(rep("purple", 3), rep("blue", 3), rep("green", 3), rep("yellow", 3), rep("orange", 3), rep("red", 3))
for(i in 1:length(fig2)){ gplot(fig2[[i]], vertex.col=colore[i], edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}

# Trying one level at time
par(mfrow=c(1,3))

for(i in 1:3){ plotmatbin(fig2[[i]], colpres="purple", colabs="black")}
for(i in 4:6){ plotmatbin(fig2[[i]], colpres="blue", colabs="black")}
for(i in 7:9){ plotmatbin(fig2[[i]], colpres="green", colabs="black")}
for(i in 10:12){ plotmatbin(fig2[[i]], colpres="yellow", colabs="black")}
for(i in 13:15){ plotmatbin(fig2[[i]], colpres="orange", colabs="black")}
for(i in 16:18){ plotmatbin(fig2[[i]], colpres="red", colabs="black")}


for(i in 1:3){ gplot(fig2[[i]], vertex.col="purple", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in 4:6){ gplot(fig2[[i]], vertex.col="blue", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in 7:9){ gplot(fig2[[i]], vertex.col="green", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in 10:12){ gplot(fig2[[i]], vertex.col="yellow", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in 13:15){ gplot(fig2[[i]], vertex.col="orange", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in 16:18){ gplot(fig2[[i]], vertex.col="red", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}


# Trying overlapping networks and matrices in AI
par(mfrow=c(6,6), mar=c(1,1,1,1))

for(i in 1:3){ 
  plotmatbin(fig2[[i]], colpres="purple", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 4:6){ 
  plotmatbin(fig2[[i]], colpres="blue", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 7:9){ 
  plotmatbin(fig2[[i]], colpres="green", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 10:12){ 
  plotmatbin(fig2[[i]], colpres="yellow", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 13:15){ 
  plotmatbin(fig2[[i]], colpres="orange", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 16:18){ 
  plotmatbin(fig2[[i]], colpres="red", colabs="black")
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}

# each column of the figure at time to paste into AI figure
par(mfrow=c(6,1), mar=c(1,1,1,1))
colore = c(rep("purple", 3), rep("blue", 3), rep("green", 3), rep("yellow", 3), rep("orange", 3), rep("red", 3))
for(i in c(1,4,7,10,13,16)){ gplot(fig2[[i]], vertex.col=colore[i], edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in c(2,5,8,11,14,17)){ gplot(fig2[[i]], vertex.col=colore[i], edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}
for(i in c(3,6,9,12,15,18)){ gplot(fig2[[i]], vertex.col=colore[i], edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)}



par(mfrow=c(6,6), mar=c(1,1,1,1))
for(i in 1:3){ 
  gplot(fig2[[i]], vertex.col="purple", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 4:6){ 
  gplot(fig2[[i]], vertex.col="blue", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 7:9){ 
  gplot(fig2[[i]], vertex.col="green", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 10:12){ 
  gplot(fig2[[10]], vertex.col="yellow", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 13:15){ 
  gplot(fig2[[i]], vertex.col="orange", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
for(i in 16:18){ 
  gplot(fig2[[i]], vertex.col="red", edge.col="grey80", vertex.cex=2, gmode="graph", usecurve=F)
  plotmatbin(fig2[[i]], colpres="white", colabs="white")}
