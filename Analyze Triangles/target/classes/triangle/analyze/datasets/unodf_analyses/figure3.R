# Figure 3. Generalized Nestedness (GN) of three representative biological networks for each of the six organization levels. 

# Pulling the info to create figure 3: plot of N at different cut-offs for each systems
fig3 <- rbind(resultmol[[2]][which.max(resultmol[[2]][,2]), c(2,4,5,3,1)], # 1 spliceosome
              resultmol[[1]][which.max(resultmol[[1]][,2]), c(2,4,5,3,1)], # 2 C.elegans gene
              resultmol[[3]][which.max(resultmol[[3]][,2]), c(2,4,5,3,1)], # 3 yeast nuclear exosome
              resultind[[3]][which.max(resultind[[3]][,2]), c(2,4,5,3,1)], # 4 cranium Howell M
              resultind[[2]][which.max(resultind[[2]][,2]), c(2,4,5,3,1)], # 5 cranium Howell F
              resultind[[1]][which.max(resultind[[1]][,2]), c(2,4,5,3,1)], # 6 cranium Europe
              resultpop[[2]][which.max(resultpop[[2]][,2]), c(2,4,5,3,1)], # 7 sotalia
              resultpop[[3]][which.max(resultpop[[3]][,2]), c(2,4,5,3,1)], # 8 tursiops
              resultpop[[1]][which.max(resultpop[[1]][,2]), c(2,4,5,3,1)], # 9 hyena
              resultmep[[1]][which.max(resultmep[[1]][,2]), c(2,4,5,3,1)], # 10 Microsatellite frog
              resultmep[[2]][which.max(resultmep[[2]][,2]), c(2,4,5,3,1)], # 11 Microsatellite human
              resultmep[[3]][which.max(resultmep[[3]][,2]), c(2,4,5,3,1)], # 12 Microsatellite sparrow
              resultcom[[2]][which.max(resultcom[[2]][,2]), c(2,4,5,3,1)], # 13 Nc mangrove wet foodweb
              resultcom[[3]][which.max(resultcom[[3]][,2]), c(2,4,5,3,1)], # 14 Nc narragan foodweb
              resultcom[[1]][which.max(resultcom[[1]][,2]), c(2,4,5,3,1)], # 15 Nc baydry foodweb
             #resultcom[[2]][which.max(resultcom[[2]][,6]), c(6,8,9,7,1)], # Nrow mangrove wet foodweb
             #resultcom[[3]][which.max(resultcom[[3]][,6]), c(6,8,9,7,1)], # Nr narragan foodweb
             #resultcom[[1]][which.max(resultcom[[1]][,6]), c(6,8,9,7,1)], # Nr baydry foodweb
              resultmet[[1]][which.max(resultmet[[1]][,2]), c(2,3,4,3,1)], # 16 Genera Reef fishes
              resultmet[[2]][which.max(resultmet[[2]][,2]), c(2,3,4,3,1)], # 17 LD Reef fishes
              resultmet[[3]][which.max(resultmet[[3]][,2]), c(2,3,4,3,1)]) # 18 LDMS Reef fishes

#Picking the minimum significant cutoff
#fig3 <- rbind(resultmol[[2]][1, c(2,4,5)], # 1 spliceosome
#              resultmol[[1]][1, c(2,4,5)], # 2 C.elegans gene
#              resultmol[[3]][1, c(2,4,5)], # 3 yeast nuclear exosome
#              resultind[[3]][1, c(2,4,5)], # 4 cranium Howell M
#              resultind[[2]][1, c(2,4,5)], # 5 cranium Howell F
#              resultind[[1]][1, c(2,4,5)], # 6 cranium Europe
#              resultpop[[2]][1, c(2,4,5)], # 7 sotalia
#              resultpop[[3]][1, c(2,4,5)], # 8 tursiops
#              resultpop[[1]][3, c(2,4,5)], # 9 hyena
#              resultmep[[1]][2, c(2,4,5)], # 10 Microsatellite frog
#              resultmep[[2]][3, c(2,4,5)], # 11 Microsatellite human
#              resultmep[[3]][2, c(2,4,5)], # 12 Microsatellite sparrow
#              resultcom[[2]][1, c(2,4,5)], # 13 Nc mangrove wet foodweb
#              resultcom[[3]][1, c(2,4,5)], # 14 Nc narragan foodweb
#              resultcom[[1]][1, c(2,4,5)], # 15 Nc baydry foodweb
#              resultmet[[1]][2, c(2,3,4)], # 16 Genera Reef fishes
#              resultmet[[2]][2, c(2,3,4)], # 17 LD Reef fishes
#              resultmet[[3]][2, c(2,3,4)]) # 18 LDMS Reef fishes

#Using fixed cutoff, say 0.1
#fig3 <- rbind(resultmol[[2]][2, c(2,4,5)], # 1 spliceosome
#              resultmol[[1]][2, c(2,4,5)], # 2 C.elegans gene
#              resultmol[[3]][2, c(2,4,5)], # 3 yeast nuclear exosome
#              resultind[[3]][2, c(2,4,5)], # 4 cranium Howell M
#              resultind[[2]][2, c(2,4,5)], # 5 cranium Howell F
#              resultind[[1]][2, c(2,4,5)], # 6 cranium Europe
#              resultpop[[2]][2, c(2,4,5)], # 7 sotalia
#              resultpop[[3]][2, c(2,4,5)], # 8 tursiops
#              resultpop[[1]][2, c(2,4,5)], # 9 hyena
#              resultmep[[1]][2, c(2,4,5)], # 10 Microsatellite frog
#              resultmep[[2]][2, c(2,4,5)], # 11 Microsatellite human
#              resultmep[[3]][2, c(2,4,5)], # 12 Microsatellite sparrow
#              resultcom[[2]][2, c(2,4,5)], # 13 Nc mangrove wet foodweb
#              resultcom[[3]][2, c(2,4,5)], # 14 Nc narragan foodweb
#              resultcom[[1]][2, c(2,4,5)], # 15 Nc baydry foodweb
#              resultmet[[1]][2, c(2,3,4)], # 16 Genera Reef fishes
#              resultmet[[2]][2, c(2,3,4)], # 17 LD Reef fishes
#              resultmet[[3]][2, c(2,3,4)]) # 18 LDMS Reef fishes


rownames(fig3) <- c(names(resultmol)[2],names(resultmol)[1],names(resultmol)[3],
                    names(resultind)[3],names(resultind)[2],names(resultind)[1],
                    names(resultpop)[2],names(resultpop)[3],names(resultpop)[1],
                    names(resultmep)[1],names(resultmep)[2],names(resultmep)[3],
                    names(resultcom)[2],names(resultcom)[3],names(resultcom)[1],
                    names(resultmet)[1],names(resultmet)[2],names(resultmet)[3])

lab = rownames(fig3)

# plotting
par(mfrow=c(2,1), mar=c(0,4,4,1))

errbar(x=c(1:nrow(fig3)), y=fig3[,1], fig3[,2], fig3[,3], ylab="Unipartite nestedness (95%CI)", xlab="", pch=19, cex=1.2, cap=0.02, col=c("purple", "blue", "green", "yellow",  "orange", "red")[figS4[,6]], xaxt="n", yaxt="n", ylim=c(0,1), cex.lab=1)
#axis(1, at=1:nrow(fig3), las=1)
#legend("topright", c("Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=0.8, col=c("purple", "blue", "green", "yellow", "orange", "red"), bty="n")
axis(2, las=1, cex.axis=0.8)
legend("topright", c("(A)"), bty="n", cex=1)

# Plotting N corrected by connectance: plotting lmcon residuals per system.  Residuals means the difference between the observed value and the value predicted by the connectance (x-axis)
# Retrieving code from figuresS1.R!

par(mar=c(4,4,1,1))
plot(residuals(lmcon), pch=15, cex=1.2, las=1, col=c("purple", "blue", "green", "yellow", "orange", "red")[figS4[,6]], xlab="Biological system", ylab="Residuals (Nc~Connectance)", xaxt="n", yaxt="n", cex.lab=1)
axis(1, at=1:nrow(fig3), las=1, cex.axis=0.8)
axis(2, las=1, cex.axis=0.8)
legend("topright", c("(B)"), bty="n", cex=1)

legend("bottomleft", c("Molecular", "Individual", "Population", "Metapopulation", "Community", "Metacommunity"), lty=1, lwd=c(3, 3), cex=0.7, col=c("purple", "blue", "green", "yellow", "orange", "red"), bty="n")

