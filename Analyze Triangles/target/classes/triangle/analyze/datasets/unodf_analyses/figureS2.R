# Figure S2. (A) Generalized Nestedness (GN) and size (number of nodes) of perfectly nested networks.

# Creating 200 "perfect nested symmetrical binary matrices"
As <- list()
for(i in 1:202){ As[[i]] <- perfnestgen(size=i) }
# Removing very small matrices to which nestedness does not make sense
As[[1]]<-NULL
As[[2]]<-NULL

# Nestedness should be ~1 for all of them
N <- matrix(NA, length(As), 2)
for(i in 1:length(As)){ N[i,] <- as.numeric(unodf(As[[i]]))}

# Plotting
plot(x=c(3:202), y=N[,1], main="", ylim=c(0,1), cex=1.5, pch=1, ylab="Unipartite nestedness", xaxt='n', xlab="Matrix size (Number of nodes)", las=1)
axis(1, at=c(3,50,100,150,200))

# Plotting some matrices
par(mfrow=c(1,6))
plotmat(As[[1]], scale=F) #3 nodes N=0
plotmat(As[[2]], scale=F) #4 nodes N=0.66
plotmat(As[[3]], scale=F) #5 nodes N=0.8
plotmat(As[[4]], scale=F) #6 nodes N=0.86
plotmat(As[[8]], scale=F) #10 nodes N=0.95
plotmat(As[[18]], scale=F) #20 nodes N=0.99
