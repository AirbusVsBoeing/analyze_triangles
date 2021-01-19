# Summary Generalized Nestedness analyses and null models
# 1. Package loading, Data import and reformat
# 2. Molecular level: a) Spliceosome proteins, b) Microsatellites
# 3. Individual level: a) Human cranium Europe, b)Human cranium Howells-F, c) Human cranium Howells-M
# 4. Population level: a) Spotted hyena, b) Dolphin Sotalia guianensis, c) Dolphin Tursiops truncatus
# 5. Community level: a) Food web Chesapeake, b)Food web Everglades, c)Food web Florida, d) Food web St.Marks
# 6. Meta-community level: a) Functional Reef fishes Length_Diet, b)L_D_Mobility, c)L_D_M_School size d) Taxonomic Reef fishes


# 1. Package loading, Data import and reformat -------------------------------

if(!require(vegan)){install.packages('vegan'); library(vegan)}
if(!require(sfsmisc)){install.packages('sfsmisc'); library(sfsmisc)}
if(!require(igraph)){install.packages('igraph'); library(igraph)}
if(!require(sna)){install.packages('sna'); library(sna)}

# installing the custom R package {UNODF}, see: https://bitbucket.org/maucantor/unodf/overview
if(!require(devtools)){install.packages('devtools'); library(devtools)} 
install_bitbucket("maucantor/unodf"); library(UNODF)

# setting iterations
iter=1000

# setting output folder
outfolder=paste(getwd(), "/output/", sep="")

# Data import
datamol <- import(dir="data", pattern="mol_", length=20)
dataind <- import(dir="data", pattern="ind_", length=21)
datapop <- import(dir="data", pattern="pop_", length=14)
datamep <- import(dir="data", pattern="mep_", length=20)
datacom <- import(dir="data", pattern="com_", length=15)
datamet <- import(dir="data", pattern="met_", length=22)


# Data formatting

# a. Yeast, Hyenas and foodwebs: transforming edgelists into matrices
datamol[[2]] <- el_mat(datamol[[2]], type="weighted", symmetric=F, numeric=FALSE)
datapop[[1]] <- el_mat(datapop[[1]], type="weighted", symmetric=TRUE, numeric=TRUE)
for(i in 1:3){ datacom[[i]] <- el_mat(datacom[[i]], type="weighted", symmetric=FALSE, numeric=TRUE) }

# b. Foodwebs: removing non-living nodes
datacom[[1]]<-datacom[[1]][1:122, 1:122]
datacom[[2]]<-datacom[[2]][1:91, 1:91]
datacom[[3]]<-datacom[[3]][1:31, 1:31]

# c. Reef fishes: Transforming bipartite into unipartite matrix using similarity index: Genera or functional groups of fished (rows) in sites (cols) into co-occorence of gen/fg in sites (Bray-Curtis quantitative similarity index)
for(i in 1:3){ datamet[[i]] <- as.matrix(1-vegdist(datamet[[i]], method="bray"))}

# d. ALL: rescaling links from minimum to the maximum weight link (to make it comparable)
for(j in 1:length(datamol)){ 
  datamol[[j]] <- as.matrix(datamol[[j]]/max(abs(datamol[[j]])))
  dataind[[j]] <- as.matrix(dataind[[j]]/max(abs(dataind[[j]])))
  datapop[[j]] <- as.matrix(datapop[[j]]/max(abs(datapop[[j]])))
  datamep[[j]] <- as.matrix(datamep[[j]]/max(abs(datamep[[j]])))
  datacom[[j]] <- as.matrix(datacom[[j]]/max(abs(datacom[[j]])))
  datamet[[j]] <- as.matrix(datamet[[j]]/max(abs(datamet[[j]])))
}

# e. All: removing possible zeroed row/columns
for(j in 1:length(dataind)){ 
  datamol[[j]] <- rmzero(datamol[[j]], what="both")
  dataind[[j]] <- rmzero(dataind[[j]], what="both")
  datapop[[j]] <- rmzero(datapop[[j]], what="both")
  datamep[[j]] <- rmzero(datamep[[j]], what="both")
  datacom[[j]] <- rmzero(datacom[[j]], what="both")
  datamet[[j]] <- rmzero(datamet[[j]], what="both")
}

# f. All symmetric matrices (not food webs): making sure diagonal=0
for(i in 1:3){ 
  diag(datamol[[i]]) = 0
  diag(dataind[[i]]) = 0
  diag(datapop[[i]]) = 0
  diag(datamep[[i]]) = 0
  diag(datamet[[i]]) = 0
}

# g. All: Ordering matrices
for(i in 1:3){ 
  datamol[[i]] <- ordermat(datamol[[i]], symmetry=TRUE)
  dataind[[i]] <- ordermat(dataind[[i]], symmetry=TRUE)
  datapop[[i]] <- ordermat(datapop[[i]], symmetry=TRUE)
  datamep[[i]] <- ordermat(datamep[[i]], symmetry=TRUE)
  datacom[[i]] <- ordermat(datacom[[i]], symmetry=FALSE)
  datamet[[i]] <- ordermat(datamet[[i]], symmetry=TRUE)
}




# 2. Molecular level -------------------------------

# creating empty objects to receive results
# Contains all binarized matrices for all cut-off levels in each system at this level
cutmol <- list(list(), list(), list())
# Contains matrices with empirical N in each cut-off for each system
unimol <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(unimol)) { colnames(unimol[[i]])<- c("Nc", "Nr")}
# Contains all 1000 random matrices for each cut-off in each system
randmol <- list(vector("list", 10), vector("list", 10), vector("list", 10))
# Contains all Nc and Nr for each 1000 random matrix in all cutofss in each system
unirandmol <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:length(cutmol)){ colnames(unirandmol[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
# Results summary
resultmol <- list()
names(cutmol) <- names(unimol) <- names(randmol) <- names(unirandmol) <- names(datamol)


# Applying link weight cut-off [0, 0.9]
for(i in 1:length(cutmol)){ cutmol[[i]] <- cutoff(datamol[[i]], cut=seq(0, 0.9, length.out=10))}

# Unipartite nestedness
for(i in 1:length(cutmol)){  for(j in 1:nrow(unimol[[1]])){ unimol[[i]][j,] <- as.numeric(unodf(cutmol[[i]][[j]])) }}

# Removing zeroed rows/columns
for(i in 1:length(cutmol)){  for(j in 1:10){ cutmol[[i]][[j]] <- rmzero(cutmol[[i]][[j]], what="both") } }

# Null model analysis
# Creating 1000 random matrices for each cut-off (10) of each system at molecular level (2)
for(j in 1:3){  for(i in 1:length(cutmol[[2]])){
    randmol[[j]][[i]] <- null2(cutmol[[j]][[i]], iter, symmetric=TRUE)
  }}

# Calculation Random Nestedness distribution
for(j in 1:length(unirandmol)){
  for(k in 1:length(cutmol[[2]])){
    for(i in 1:iter){
      auxn <- as.numeric(unodf(randmol[[j]][[k]][,,i]))
      unirandmol[[j]][i,   k] <- auxn[1]
      unirandmol[[j]][i,k+10] <- auxn[2]
    }
  }
}

# Printing results
for(i in 1:length(unimol)){ 
resultmol[[i]] <- printresult(emp = unimol[[i]], rand = unirandmol[[i]], iter=iter, cuts=nrow(unimol[[2]]), save=TRUE, file=paste(outfolder, names(datamol)[i], ".txt", sep=""))
}
names(resultmol) <- names(datamol)
resultmol



# 3. Individual level -----------------------------------------------------

# creating empty objects to receive results
cutind <- list(list(), list(), list())
uniind <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(uniind)) { colnames(uniind[[i]])<- c("Nc", "Nr")}
randind <- list(vector("list", 10), vector("list", 10), vector("list", 10))
unirandind <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:3){ colnames(unirandind[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
resultind <- list()
names(cutind) <- names(uniind) <- names(randind) <- names(unirandind) <- names(dataind)


# Applying link weight cut-off [0.0, 0.9]
for(i in 1:length(cutind)){ cutind[[i]] <- cutoff(dataind[[i]],cut=seq(0, 0.9, length.out=10)) }

# Unipartite nestedness
for(i in 1:length(cutind)){  for(j in 1:nrow(uniind[[1]])){ uniind[[i]][j,] <- as.numeric(unodf(cutind[[i]][[j]])) }}

# Removing zeroed rows/columns
for(i in 1:length(cutind)){  for(j in 1:10){ cutind[[i]][[j]] <- rmzero(cutind[[i]][[j]], what="both") } }

# Null model analysis
# Creating 1000 random matrices for each cut-off (i in 1:10) of each system at individual level (j in 1:3)
for(j in 1:length(randind)){
  for(i in 1:length(cutind[[1]])){
    randind[[j]][[i]] <- null2(cutind[[j]][[i]], iter, symmetric=TRUE)
  }
}

# Calculation Random Nestedness distribution
for(j in 1:length(unirandind)){
  for(k in 1:length(cutind[[1]])){
    for(i in 1:iter){
      auxn <- as.numeric(unodf(randind[[j]][[k]][,,i]))
      unirandind[[j]][i,   k] <- auxn[1]
      unirandind[[j]][i,k+10] <- auxn[2]
    }
  }
}

# Printing results
for(i in 1:length(uniind)){ resultind[[i]] <- printresult(emp = uniind[[i]], rand = unirandind[[i]], iter=iter, cuts=nrow(uniind[[1]]), save=TRUE, file=paste(outfolder, names(dataind)[i], ".txt", sep="")) }
names(resultind) <- names(dataind)
resultind



# 4. Population level -----------------------------------------------------

# creating empty objects to receive results
cutpop <- list(list(), list(), list())
unipop <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(unipop)) { colnames(unipop[[i]])<- c("Nc", "Nr")}
randpop <- list(vector("list", 10), vector("list", 10), vector("list", 10))
unirandpop <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:3){ colnames(unirandpop[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
resultpop <- list()
names(cutpop) <- names(unipop) <- names(randpop) <- names(unirandpop) <- names(datapop)


# Applying link weight cut-off [0, 0.9]
for(i in 1:length(cutpop)){ cutpop[[i]] <- cutoff(datapop[[i]],cut=seq(0, 0.9, length.out=10)) }

# Unipartite nestedness
for(i in 1:length(cutpop)){  for(j in 1:nrow(unipop[[1]])){ unipop[[i]][j,] <- as.numeric(unodf(cutpop[[i]][[j]])) }}

# Removing zeroed rows/columns
for(i in 1:length(cutpop)){  for(j in 1:10){ cutpop[[i]][[j]] <- rmzero(cutpop[[i]][[j]], what="both") } }

# Null model analysis
# Creating 1000 random matrices for each cut-off (i in 1:10) of each system at individual level (j in 1:3)
for(j in 1:length(randpop)){
  for(i in 1:length(cutpop[[1]])){
      randpop[[j]][[i]] <- null2(cutpop[[j]][[i]], iter, symmetric=TRUE)  
  }
}

# Calculation Random Nestedness distribution
for(j in 1:length(unirandpop)){
  for(k in 1:10){
    for(i in 1:iter){
      if(dim(randpop[[j]][[k]][,,i])[1]==0){
        unirandpop[[j]][i,   k] <- NA
        unirandpop[[j]][i,k+10] <- NA
      } else {
      auxn <- as.numeric(unodf(randpop[[j]][[k]][,,i]))
      unirandpop[[j]][i,   k] <- auxn[1]
      unirandpop[[j]][i,k+10] <- auxn[2]
      }
    }
  }
}

# Printing results
for(i in 1:length(unipop)){ resultpop[[i]] <- printresult(emp = unipop[[i]], rand = unirandpop[[i]], iter=iter, cuts=length(cutpop[[1]]), save=TRUE, file=paste(outfolder, names(datapop)[i], ".txt", sep="")) }
names(resultpop) <- names(datapop)
resultpop



# 5. Meta-Population level -----------------------------------------------------

# creating empty objects to receive results
cutmep <- list(list(), list(), list())
unimep <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(unimep)) { colnames(unimep[[i]])<- c("Nc", "Nr")}
randmep <- list(vector("list", 10), vector("list", 10), vector("list", 10))
unirandmep <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:3){ colnames(unirandmep[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
resultmep <- list()
names(cutmep) <- names(unimep) <- names(randmep) <- names(unirandmep) <- names(datamep)


# Applying link weight cut-off [0, 0.9]
for(i in 1:length(cutmep)){ cutmep[[i]] <- cutoff(datamep[[i]],cut=seq(0, 0.9, length.out=10)) }

# Unipartite nestedness
for(i in 1:length(cutmep)){  for(j in 1:nrow(unimep[[1]])){ unimep[[i]][j,] <- as.numeric(unodf(cutmep[[i]][[j]])) }}

# Removing zeroed rows/columns
for(i in 1:length(cutmep)){  for(j in 1:10){ cutmep[[i]][[j]] <- rmzero(cutmep[[i]][[j]], what="both") } }

# Null model analysis
# Creating 1000 random matrices for each cut-off (i in 1:10) of each system at individual level (j in 1:3)
for(j in 1:length(randmep)){
  for(i in 1:length(cutmep[[1]])){
    randmep[[j]][[i]] <- null2(cutmep[[j]][[i]], iter, symmetric=FALSE)  
  }
}

# Calculation Random Nestedness distribution
for(j in 1:length(unirandmep)){
  for(k in 1:10){
    for(i in 1:iter){
      if(dim(randmep[[j]][[k]][,,i])[1]==0){
        unirandmep[[j]][i,   k] <- NA
        unirandmep[[j]][i,k+10] <- NA
      } else {
        auxn <- as.numeric(unodf(randmep[[j]][[k]][,,i]))
        unirandmep[[j]][i,   k] <- auxn[1]
        unirandmep[[j]][i,k+10] <- auxn[2]
      }
    }
  }
}

# Printing results
for(i in 1:length(unimep)){ resultmep[[i]] <- printresult(emp = unimep[[i]], rand = unirandmep[[i]], iter=iter, cuts=length(cutmep[[1]]), save=FALSE)}, file=paste(outfolder, names(datamep)[i], ".txt", sep="")) }
names(resultmep) <- names(datamep)
resultmep



# 6. Community level ------------------------------------------------------

cutcom <- list(list(), list(), list())
unicom <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(unicom)) { colnames(unicom[[i]])<- c("Nc", "Nr")}
randcom <- list(vector("list", 10), vector("list", 10), vector("list", 10))
unirandcom <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:length(unicom)){ colnames(unirandcom[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
resultcom <- list()
names(cutcom) <- names(unicom) <- names(randcom) <- names(unirandcom) <- names(datacom)


# Applying link weight cut-off [0, 0.9]
for(i in 1:length(cutcom)){ cutcom[[i]] <- cutoff(datacom[[i]],cut=seq(0, 0.9, length.out=10)) }

# Unipartite nestedness
for(i in 1:length(cutcom)){ 
  for(j in 1:nrow(unicom[[1]])){ 
    if(is.null(dim(cutcom[[i]][[j]]))){   unicom[[i]][j,] <- c(NA, NA)
    }else{
      unicom[[i]][j,] <- as.numeric(unodf(cutcom[[i]][[j]]))
    }
}}

# Removing zeroed rows/columns
for(i in 1:length(cutcom)){  for(j in 1:10){ cutcom[[i]][[j]] <- rmzero(cutcom[[i]][[j]], what="both") } }
                
# Null model analysis
# Creating 1000 random matrices for each cut-off (i in 1:10) of each system at individual level (j in 1:3)
for(j in 1:length(randcom)){
  for(i in 1:length(cutcom[[1]])){
    if(is.null(dim(cutcom[[j]][[i]]))){   randcom[[j]][[i]] <- 0
    }else{
    randcom[[j]][[i]] <- null2(cutcom[[j]][[i]], iter, symmetric=FALSE) # food webs are not symmetric
    }
  }
}

# Calculation Random Nestedness distribution
for(j in 1:length(unirandcom)){
  for(k in 1:length(cutcom[[1]])){
    for(i in 1:iter){
      if(is.null(dim(randcom[[j]][[k]]))){
        unirandcom[[j]][i,   k] <- NA
        unirandcom[[j]][i,k+10] <- NA
      } else {
      auxn <- as.numeric(unodf(randcom[[j]][[k]][,,i]))
      unirandcom[[j]][i,   k] <- auxn[1]
      unirandcom[[j]][i,k+10] <- auxn[2]
      }
    }
  }
}

# Printing results
for(i in 1:length(unicom)){ resultcom[[i]] <- printresult(emp = unicom[[i]], rand = unirandcom[[i]], iter=iter, cuts=length(cutcom[[1]]), save=TRUE, file=paste(outfolder, names(datacom)[i], ".txt", sep="")) }
names(resultcom) <- names(datacom)
resultcom



# 7. Meta-Community level -------------------------------------------------

# creating empty objects to receive results
cutmet <- list(list(), list(), list())
unimet <- list(matrix(NA, 10, 2), matrix(NA, 10, 2), matrix(NA, 10, 2)); for(i in 1: length(unimet)) { colnames(unimet[[i]])<- c("Nc", "Nr")}
randmet <- list(vector("list", 10), vector("list", 10), vector("list", 10))
unirandmet <- list(matrix(NA, iter, 20), matrix(NA, iter, 20), matrix(NA, iter, 20)); for(i in 1:length(unimet)){ colnames(unirandmet[[i]]) <- c(paste("Nc0.", 0:9, sep=""), paste("Nr0.", 0:9, sep=""))}
resultmet <- list()
names(cutmet) <- names(unimet) <- names(randmet) <- names(unirandmet) <- names(datamet)
                
# Applying link weight cut-off [0.0, 0.9]
for(i in 1:length(cutmet)){ cutmet[[i]] <- cutoff(datamet[[i]],cut=seq(0, 0.9, length.out=10)) }
                
# Unipartite nestedness
for(i in 1:length(cutmet)){  for(j in 1:nrow(unimet[[1]])){ unimet[[i]][j,] <- as.numeric(unodf(cutmet[[i]][[j]])) }}
                
# Removing zeroed rows/columns
for(i in 1:length(cutmet)){  for(j in 1:10){ cutmet[[i]][[j]] <- rmzero(cutmet[[i]][[j]], what="both") } }
                
# Null model analysis
# Creating 1000 random matrices for each cut-off (i in 1:10) of each system at individual level (j in 1:3)
for(j in 1:length(randmet)){
  for(i in 1:length(cutmet[[1]])){
    randmet[[j]][[i]] <- null2(cutmet[[j]][[i]], iter, symmetric=TRUE)
  }
}
          
# Calculation Random Nestedness distribution
for(j in 1:length(unirandmet)){
  for(k in 1:length(cutmet[[1]])){
    for(i in 1:iter){
      if(dim(randmet[[j]][[k]][,,i])[1]==0){
        unirandmet[[j]][i,  k] <- NA
        unirandmet[[j]][i,k+10] <- NA
      } else {
        auxn <- as.numeric(unodf(randmet[[j]][[k]][,,i]))
        unirandmet[[j]][i,  k] <- auxn[1]
        unirandmet[[j]][i,k+10] <- auxn[2]
      }
    }
  }
}
                
# Printing results
for(i in 1:length(unimet)){ resultmet[[i]] <- printresult(emp = unimet[[i]], rand = unirandmet[[i]], iter=iter, cuts=nrow(unimet[[1]]), save=TRUE, file=paste(outfolder, names(datamet)[i], ".txt", sep="")) }
names(resultmet) <- names(datamet)
resultmet