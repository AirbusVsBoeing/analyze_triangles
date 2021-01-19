# Figure S4. Relationship between Generalized Nestedness (GN) and network centralization, as given by a simple linear model

# retrieve info from figureS3.R

# PCA for summarizing all centrality measures
pca.cent = rbind(Result.cent, figS3.cent)
au <- princomp(pca.cent,cor=TRUE,scores=TRUE)
au_nopath <- princomp(pca.cent[,c(1:4, 6)],cor=TRUE,scores=TRUE)
au_noccpath <- princomp(pca.cent[,c(1:4)],cor=TRUE,scores=TRUE)
au_sworld <- princomp(pca.cent[,c(5:6)],cor=TRUE,scores=TRUE)

# variation explained by PC1
loadings(au)
loadings(au_nopath)
loadings(au_noccpath)
loadings(au_sworld)

# linear regression: PC1 Centrality x Residual-corrected nested
lmpca <- lm(au$scores[,1] ~ resid(lmcorrec))
summary(lmpca)
lmpca_nopath <- lm(au_nopath$scores[,1] ~ resid(lmcorrec))
summary(lmpca_nopath)
lmpca_noccpath <- lm(au_noccpath$scores[,1] ~ resid(lmcorrec))
summary(lmpca_noccpath)
lmpca_sworld <- lm(au_sworld$scores[,1] ~ resid(lmcorrec))
summary(lmpca_sworld)



collab = rep(c(1:7), each=3)

par(mfrow=c(1,3), mar=c(4,4,1,1))


# PC1 (all metrics) x Corrected Nested (Residuals Nestedness x Connectance)
plot(resid(lmcorrec),au$scores[,1], pch=15, cex=1.5, col=c("black","purple", "blue", "green", "yellow", "orange", "red")[collab], xlab="Residuals (Nc~Connectance)", ylab="PC1 (Centrality, Clustering, Shortest Path", las=1)
legend("bottomright", c("Theoretical", "Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=1, col=c("black", "purple", "blue", "green", "yellow", "orange", "red"), bty="n")
abline(lmpca)
legend("topright",paste("y=", round(coef(lmpca)[1], digits=6),"+",round(coef(lmpca)[2], digits=2),"x"," ; p=",round(coefficients(summary(lmpca))[2,4], digits=3), sep="")  , bty="n", cex=0.8)

# PC1 (all but not path length) x Corrected Nested (Residuals Nestedness x Connectance)
#plot(resid(lmcorrec),au_nopath$scores[,1], pch=15, cex=1.5, col=c("black", "purple", "blue", "green", "yellow", "orange", "red")[collab], xlab="(Residuals Nc~Connectance)", ylab="PC1 (Centrality, Clustering)", las=1)
#legend("bottomright", c("Theoretical", "Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=1, col=c("black", "purple", "blue", "green", "yellow", "orange", "red"), bty="n")
#abline(lmpca_nopath)
#legend("topright",paste("y=", round(coef(lmpca_nopath)[1], digits=6),round(coef(lmpca_nopath)[2], digits=2),"x"," ; p=",round(coefficients(summary(lmpca_nopath))[2,4], digits=3), sep="")  , bty="n", cex=0.8)

# PC1 (no cc and no path length) x Corrected Nested (Residuals Nestedness x Connectance)
plot(resid(lmcorrec),au_noccpath$scores[,1], pch=15, cex=1.5, col=c("black", "purple", "blue", "green", "yellow", "orange", "red")[collab], xlab="Residuals (Nc~Connectance)", ylab="PC1 (Centrality)", las=1)
legend("topright", c("Theoretical", "Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=1, col=c("black", "purple",  "blue", "green", "yellow", "orange", "red"), bty="n")
abline(lmpca_noccpath)
legend("bottomright",paste("y=", round(coef(lmpca_noccpath)[1], digits=6),round(coef(lmpca_noccpath)[2], digits=2),"x"," ; p=",round(coefficients(summary(lmpca_noccpath))[2,4], digits=3), sep="")  , bty="n", cex=0.8)

# PC1 (small world: CC + Path) x Corrected Nested (Residuals Nestedness x Connectance)
plot(resid(lmcorrec), au_sworld$scores[,1], pch=15, cex=1.5, col=c("black", "purple", "blue", "green", "yellow", "orange", "red")[collab], xlab="Residuals (Nc~Connectance)", ylab="PC1 (Clustering, Shortest Path)", las=1)
legend("topright", c("Theoretical", "Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=1, col=c("black", "purple",  "blue", "green", "yellow", "orange", "red"), bty="n")
abline(lmpca_sworld)
legend("bottomright",paste("y=", round(coef(lmpca_sworld)[1], digits=6),round(coef(lmpca_sworld)[2], digits=2),"x"," ; p=",round(coefficients(summary(lmpca_sworld))[2,4], digits=3), sep="")  , bty="n", cex=0.8)






## Attempts to model Nunip with centrality using GLMs (draft)

figS4 = cbind(figS1, figS3.cent)
plot(figS4[,3], figS4[,11])
plot(figS4[,3], figS4[,12])
plot(resid(lmcon), figS4[,11])
plot(resid(lmcon), figS4[,12])

summary(lm(figS4[,3]~figS4[,11]))
summary(lm(figS4[,3]~figS4[,12]))
summary(lm(figS4[,3]~figS4[,12]+figS4[,11]))
summary(lm(figS4[,3]~figS4[,12]+figS4[,11]+figS4[,10]+figS4[,9]+figS4[,8]+figS4[,7]))
step(lm(figS4[,3]~figS4[,12]+figS4[,11]+figS4[,10]+figS4[,9]+figS4[,8]+figS4[,7]), direction="backward")
pairs(figS4)