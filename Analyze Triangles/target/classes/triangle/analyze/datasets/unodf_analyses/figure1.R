# Figure 1: schematic representation of nestedness

# Creating unipartite binary matrix with Maximum Nunip
dev.off()
Nest <- perfnestgen(size=20)
plotmat(Nest, scale=F)
gplot(Nest, gmode="graph", usecurve=F)
unodf(Nest)

# Creating unipartite binary matrix with minimum Nunip (see Almeida-Neto et al. 2007)
# Checkerboard
a=c(1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0)
b=c(0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1)
Checker <- as.matrix(rbind(b,a,b,a,b,a,b,a,b,a,b,a,b,a,b,a,b,a,b,a))
plotmat(Checker, scale=F)
gplot(Checker, gmode="graph", usecurve=F)
unodf(Checker)

# Modular, Non-inclusive sets
d= c(1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0)
d1=c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0)
e= c(0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0)
e1=c(0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
f= c(0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1)
Nonin <- cbind(d,d,d,d,d,d1,d1,e,e,e,e,e,e1,e1,f,f,f,f,f,f)
diag(Nonin)=0
plotmat(Nonin, scale=F)
gplot(Nonin, gmode="graph", usecurve=F)
unodf(Nonin)

# High turnover
i= c(1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0)
i1=c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
j= c(0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1)
High <- cbind(i,i,i,i,i,i,i,i,i1,i1,i1,i1,j,j,j,j,j,j,j,j)
diag(High)=0
plotmat(High, scale=F)
gplot(High, gmode="graph", usecurve=F)
unodf(High)

# Random symmetric matrix
Rand <- null2(Nest, iter=1, symmetric=T)
Rand <- as.matrix(Rand[,,1])
diag(Rand)=0
plotmat(Rand, scale=F)
gplot(Rand, gmode="graph", usecurve=F)
unodf(Rand)


# Creating Figures for the theoretical scheme:
par(mfrow=c(1, 5), mar=c(0.5,0.5,0.5,0.5))
plotmat(Checker,scale=F)
plotmat(Nonin, scale=F)
plotmat(High,scale=F)
plotmat(Rand,scale=F)
plotmat(Nest,scale=F)
dev.off()

# gplot plots
par(mfrow=c(1, 5), mar=c(0.5,0.5,0.5,0.5))
gplot(Checker,gmode="graph", usecurve=F)
gplot(Nonin, gmode="graph", usecurve=F)
gplot(High,gmode="graph", usecurve=F)
gplot(Rand,gmode="graph", usecurve=F)
gplot(Nest,gmode="graph", usecurve=F)
dev.off()

# igraph plots:
gChecker <- graph.adjacency(Checker, mode=c("undirected"), weighted=NULL, diag=F,add.colnames=NULL, add.rownames=NA)
gNonin <- graph.adjacency(Nonin, mode=c("undirected"), weighted=NULL, diag=F,add.colnames=NULL, add.rownames=NA)
gHigh <- graph.adjacency(High, mode=c("undirected"), weighted=NULL, diag=F,add.colnames=NULL, add.rownames=NA)
gRand <- graph.adjacency(Rand, mode=c("undirected"), weighted=NULL, diag=F,add.colnames=NULL, add.rownames=NA)
gNest <- graph.adjacency(Nest, mode=c("undirected"), weighted=NULL, diag=F,add.colnames=NULL, add.rownames=NA)

par(mfrow=c(1, 5), mar=c(0.5,0.5,0.5,0.5))
plot(gChecker, vertex.size=10, vertex.label=NA, vertex.color="yellow", edge.curved=F)
plot(gNonin, vertex.size=10, vertex.label=NA, vertex.color="yellow",edge.curved=F)
plot(gHigh, vertex.size=10, vertex.label=NA, vertex.color="yellow",edge.curved=F)
plot(gRand, vertex.size=10, vertex.label=NA, vertex.color="yellow",edge.curved=F)
plot(gNest, vertex.size=10, vertex.label=NA, vertex.color="yellow",edge.curved=F)

