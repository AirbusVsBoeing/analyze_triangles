# Figure S3.  Network metrics describing the centralization of the network and Generalized Nestedness in unipartite networks. 

# 1. Theoretical networks: Perfectly nested, Barabasi, Erdos-Renyi
# 2. Empirical networks
# 3. Plotting

# Loading
if(!require(igraph)){install.packages('igraph'); library(igraph)}
if(!require(NetIndices)){install.packages('NetIndices'); library(NetIndices)}
if(!require(RCurl)){install.packages('RCurl'); library(RCurl)}
if(!require(ggplot2)){install.packages('ggplot2'); library(ggplot2)}
if(!require(reshape2)){install.packages('reshape2'); library(reshape2)}


# 1. Simulated networks: perfectly nested, Barabasi, Erdos-Renyi ---------

# Simulated network size (number of nodes)
S=100

# Adjacency matrix for Perfectly nested network
nest.adj=matrix(0,S,S)
nest.adj[upper.tri(nest.adj)]=1
diag(nest.adj)=1
cmarg=apply(nest.adj,2,sum)
rmarg=apply(nest.adj,1,sum)
nest.adj=nest.adj[order(rmarg,decreasing=TRUE),order(cmarg,decreasing=TRUE)]
diag(nest.adj)=0 
E=sum(nest.adj)/2

# Networks: Nested, Barabasi, Erdos-Renyi
nest.net=graph.adjacency(nest.adj, mode="undirected")
ba.net<-barabasi.game(S,m=0.3*S,directed=FALSE)
er.net=erdos.renyi.game(S,E, type="gnm", )

# Adjacency matrix for Barabasi and Erdos-Renyi
ba.adj=get.adjacency(ba.net, sparse=F)
er.adj=get.adjacency(er.net, sparse=F)

# Connectance: checking if connectance is similar among theoretical networks
e.nest=length(E(nest.net))
e.ba=length(E(ba.net))
e.er=length(E(er.net))

v.nest=length(V(nest.net)) 
v.ba= length(V(ba.net))
v.er= length(V(er.net))

c.nest=e.nest/((v.nest)*(v.nest-1))
c.ba=e.ba/((v.ba)*(v.ba-1))
c.er=e.er/((v.er)*(v.er-1))

Conec=rbind(c.nest,c.ba,c.er); colnames(Conec)="Connectance"
Conec

# Plotting theoretical networks
par(mar=c(.1,.1,.1,.1), mfrow=c(1,3) )
plot.igraph(nest.net, layout= layout.circle, vertex.size=9, vertex.label.cex=.0, edge.arrow.size=.2)
plot.igraph(ba.net, layout= layout.circle, vertex.size=9, vertex.label.cex=.0, edge.arrow.size=.2)
plot.igraph(er.net, layout= layout.circle, vertex.size=9, vertex.label.cex=.0, edge.arrow.size=.2)
dev.off()


# Calculating centrality measures and "small-world properties": clustering coefficient and shortest_path 
centralizacoes=function(G){
  b=centralization.betweenness (G, directed = FALSE, nobigint = TRUE, normalized = TRUE)
  c=centralization.closeness (G, mode = c("out", "in", "all", "total"), normalized = TRUE)
  d=centralization.degree (G, mode = c("all", "out", "in", "total"), loops = FALSE, normalized = TRUE) 
  e=centralization.evcent (G, directed = FALSE, scale = TRUE, options = igraph.arpack.default, normalized = TRUE)
  t=transitivity(G) # not rescaled
  s=average.path.length(G, directed=F, unconnected=TRUE)
  cent=c(b$centralization,c$centralization,d$centralization,e$centralization,t,s)
}

nest.cent= centralizacoes(nest.net)
ba.cent= centralizacoes(ba.net)
er.cent= centralizacoes(er.net)

Result.cent=rbind(nest.cent, ba.cent,er.cent)
colnames(Result.cent)=c("betweness", "closeness","degree","eigenvector", "clustering","shortest_path")
rownames(Result.cent)=c("nest","ba", "er")
Result.cent


# Calculating unipartite nestedness for theoretical networks
nest.nest= N.unip(nest.adj)
ba.nest= N.unip(ba.adj)
er.nest= N.unip(er.adj)

Result.nest=rbind(nest.nest, ba.nest, er.nest); rownames(Result.nest)=c("nest","ba","er")






# 2. Empirical networks ---------------------------------------------------

# Network adjacency matrices in figure2.R:
fig2 

# Empirical nestedness in figure3.R
fig3

# Empirical centrality measures
figS3 <- list()
figS3.cent <- matrix(NA, length(fig2), 6)
for(i in 1: length(fig2)){
  figS3[[i]]      <- graph.adjacency(fig2[[i]], mode="undirected")
  figS3.cent[i, ] <- centralizacoes(figS3[[i]])
}
colnames(figS3.cent)=c("betweness", "closeness","degree","eigenvector", "clustering", "shortest_path")
rownames(figS3.cent)=rownames(fig3)

figS3.cent






# 3. Plotting -------------------------------------------------------------

# theoretical networks
m_central = melt(Result.cent, id.vars = "Grupo")
m_central$variable = rep(Result.nest$Nc,6)
m_central$Grupo = as.factor(m_central$Var2)
m_central$Nivel=as.factor(rep(c("Nested", "Barabasi", "Erdos-Renyi"),6))
ggplot(m_central, aes(variable, value, group = Grupo, color = Grupo)) + geom_point(aes(shape=Nivel), size=5)+geom_line() + theme_bw() + xlab("Nestedness") + ylab("Centralization")+
  theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank())


# empirical networks
me_central = melt(figS3.cent, id.vars = "Grupo")
me_central$variable = rep(fig3[,1],6)
me_central$Grupo = as.factor(me_central$Var2)
me_central$Nivel = as.factor(rep(c("molecular","individual","population","metapopulation","community","metacommunity"), 6))
ggplot(me_central, aes(variable, value, group = Grupo, color = Grupo)) + geom_point(aes(shape=Nivel), size=5)+geom_line() + theme_bw() + xlab("Nestedness") + ylab("Centralization")+
  theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank())


# all (using raw nestedness)
ma_central = rbind(m_central, me_central)
#ggplot(ma_central, aes(variable, value, group = Grupo, color = Grupo)) + geom_point()+geom_line() + theme_bw() + xlab("Nestedness") + ylab("Centralization") + labs(title="Centrality and Small-world X Nestedness")
ggplot(ma_central, aes(variable, value, group = Grupo, color = Grupo)) + geom_point(aes(shape=Nivel),size=5) + scale_shape_manual(values=1:length(levels(ma_central$Nivel)))+geom_line() + theme_bw() + xlab("Generalized Nestedness") + ylab("Centralization") + theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) 



### Correcting nestedness for connectance

# check code in figuresS4.R
figS4
# getting Nc and connectance for empirical networks
empi = figS4[, c(3,2)]
# getting Nc and connectance for theoretical networks
theo = cbind(Result.nest[,1], Conec)
# all together
figS3_correc <- rbind(theo, empi); colnames(figS3_correc)=c("Nc", "Connectance")

lmcorrec <- lm(Nc ~ Connectance, data=as.data.frame(figS3_correc))
summary(lmcorrec)
resid(lmcorrec)


# all (using residuals Nestedness x Connectance to correct for connectance)
a1 = rep(resid(lmcorrec)[1:3], 6)
a2 = rep(resid(lmcorrec)[4:21], 6)
nest_correc = c(a1, a2)

ma_central_correc = rbind(m_central, me_central)
ma_central_correc$variable = nest_correc

# all metrics
ggplot(ma_central_correc, aes(variable, value, group = Grupo, color = Grupo)) + geom_point(aes(shape=Nivel),size=5) + scale_shape_manual(values=1:length(levels(ma_central_correc$Nivel)))+geom_line() + theme_bw() + xlab("Residuals Nc~Connectance") + ylab("Centralization") + theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank())

# removing shortest path
ggplot(ma_central_correc[c(1:15, 19:108),], aes(variable, value, group = Grupo, color = Grupo)) + geom_point(aes(shape=Nivel),size=4) + scale_shape_manual(values=1:length(levels(ma_central_correc$Nivel)))+geom_line() + theme_bw() + xlab("Residuals Nc~Connectance") + ylab("Centralization") +  theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank())









