# Figure S1. Relationship between (A) Generalized Nestedness (GN) and network connectance (proportion of realized links in relation to possible links: links/nodes2); and (B) GN and network size (number of nodes). 

# Loading fig3 and fig2 (see figure2.R, and figure3.R)
fig3 
fig2 
             
# gathering number of nodes
figS1dim <- matrix(NA, length(fig2), 2)
for(i in 1:length(fig2)){ figS1dim[i,]=dim(fig2[[i]])}

# Calculating connectance (links/nodes^2)
figS1 = cbind(figS1dim[,1], matrix(NA, length(fig2), 1)); colnames(figS1)=c("nodes", "connect")
for(i in 1: nrow(figS1)){ figS1[i,2] = (sum(fig2[[i]]))/(figS1dim[i,1]^2)}

# gathering Nc and 95%CI
figS1 = cbind(figS1, fig3[,1:3])
rownames(figS1) = rownames(fig3)

# adding color factor
collevel = rep(c(1:6), each=3)
figS1 = cbind(figS1, collevel)


# adding linear models
lmcon <- lm(Nc ~ connect, data=as.data.frame(figS1))
summary(lmcon)

lmsize <- lm(Nc ~ nodes, data=as.data.frame(figS1))
summary(lmsize)


# plotting relationships
par(mfrow=c(1,2), mar=c(4,4,1,1))

# Nestedness x connectance
errbar(x=figS1[,2], y=figS1[,3], figS1[,4], figS1[,5], ylab="Generalized Nested among columns (95%CI)", xlab="Connectance (links/nodes^2)", pch=15, cex=1.5, cap=0.03, ylim=c(0,1), las=1,col=c("purple", "blue", "green", "yellow","orange", "red")[figS1[,6]])
abline(lmcon)
legend("topleft", paste("y=", round(coef(lmcon)[1], digits=2),"+",round(coef(lmcon)[2], digits=2),"x"," ; p=",round(coefficients(summary(lmcon))[2,4], digits=3), sep=""), bty="n", cex=0.8)
legend("topright", c("(A)"), bty="n", cex=1)


# Nestedness x network size
errbar(x=figS1[,1], y=figS1[,3], figS1[,4], figS1[,5], ylab="", xlab="Network size (nodes)", pch=19, cex=1.5, cap=0.03, ylim=c(0,1), las=1, col=c("purple", "blue", "green", "yellow", "orange", "red")[figS1[,6]])
abline(lmsize)
legend("topleft", paste("y=", round(coef(lmsize)[1], digits=2),round(coef(lmsize)[2], digits=5),"x"," ; p=",round(coefficients(summary(lmsize))[2,4], digits=3), sep=""), bty="n", cex=0.8)
legend("bottomright", c("Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=0.8, col=c("purple", "blue", "green", "yellow", "orange", "red"), bty="n")
legend("topright", c("(B)"), bty="n", cex=1)



# Plotting N corrected by connectance: plotting lmcon residuals per system.  Residuals means the difference between the observed value and the value predicted by the connectance (x-axis)
plot(residuals(lmcon), pch=15, cex=1.5, col=c("purple", "blue", "green", "yellow", "orange", "red")[figS1[,6]], xlab="biological system", ylab="Residuals Nc~Connectance", ylim=c(-0.2, 0.25))
axis(1, at=1:nrow(fig3), las=1)
legend("bottomleft", c("Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=0.8, col=c("purple", "blue", "green", "yellow", "orange", "red"), bty="n")

#summary(lm(resid(lmcon) ~ c(1:18)))
#abline(lm(resid(lmcon) ~ c(1:18)))
#legend("topleft", paste("y=", round(coef(lm(resid(lmcon) ~ c(1:18)))[1], digits=2),round(coef(lm(resid(lmcon) ~ c(1:18)))[2], digits=3),"x"," ; p=",round(coefficients(summary(lm(resid(lmcon) ~ c(1:18))))[2,4], digits=3), sep=""), bty="n", cex=0.8)

