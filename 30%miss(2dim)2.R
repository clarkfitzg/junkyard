# simulation based on 3 factor and 100 iteration for each cell:
# 1) test length (15,30,45)
# 2) sample size (500,1000,2000)
# 3) correlation of proficiency and propensity (0,0.4,0.8)
###############################################################
library(MASS)  
library(mirt)
library(psych)
library(doParallel)
# function for running simmulation
itemrecovery <- function(sample.size, nitem, corr ,seed) {
# function for generation of binery data
cut.function_grm <- function(variable,thr,diskr){
    dat <- matrix(0,nrow=length(variable),ncol=length(diskr))
    for(i in 1:length(diskr))
    {
        matr.temp <-matrix(0,nrow=length(variable),ncol=length(thr[[i]]) )
        for(k in 1:length(thr[[i]]))
        {
           matr.temp[,k] <- exp( diskr[i]*(variable - thr[[i]][k]) ) /
                            (1 + exp(diskr[i]*(variable - thr[[i]][k])))
        }
        w<-runif(n=length(variable),min=0,max=1)
        for (x in ncol(matr.temp):1)
        {
         matr.temp[,x] <- ifelse(w < matr.temp[,x],1,0)
        }
        dat[,i] <- rowSums(matr.temp)
    }
    return(dat)
}
#Set the seed and generate the parameters
require(MASS) 
require(mirt)
require(psych)
set.seed(seed)
Sigma <- matrix(c(1,corr,corr,1),2,2)
lat   <- mvrnorm(n=sample.size, mu = c(0,0), Sigma=Sigma)
xi    <- lat[,1]
xi.1  <- as.matrix(xi,ncol=1)
theta <- lat[,2]
theta.1 <- as.matrix(theta,ncol=1)
# Simulating the items Y_i as manifest indicators of xi
     # Simulating a new set of item difficulties of the items Y_i for each 
     # simulated data set, with the minimum item difficulty - 2.5 and the
     # maximum item difficulty 2.5
#dis =round((2*2.7)/nitem,2)
thr.xi  <- seq(-2.7,2.7,length.out=nitem) + rnorm(nitem,0,0.7)
fact.xi <- (max(thr.xi)- min(thr.xi)) / (2.5 -(-2.5))
thr.xi  <- (1/fact.xi)*thr.xi
thr.xi  <- thr.xi + (-2.5 - min(thr.xi))
thr.xi.1<- as.matrix(thr.xi + (-2.5 - min(thr.xi)),ncol=1)
     # Simulating a new set of item discriminations of the items Y_i for 
     # each simulated data set with item discriminations that range from 
     # 0.5 to 1.5
diskr.xi  <- runif(length(thr.xi),0.5,1.5)
diskr.xi.1 <- as.matrix(runif(length(thr.xi),0.5,1.5),ncol=1)
#data
complete.dat <- cut.function_grm(variable=xi,thr=as.list(thr.xi),diskr=diskr.xi)


# Simulating omitted items
# item difficulties and thresholds of the non-omission indicators are 
# not independent because more difficult items are more likely omitted
thr.theta <- 0.6*thr.xi + rnorm(length(thr.xi),0,1)
# In Condition A the thresholds range from -2.5 to -0.4 to obtain the
# intended proportion of omitted items
fact <- (max(thr.theta)- min(thr.theta)) / (-0.4 - (-2.5))
thr.theta <- (1/fact)*thr.theta
thr.theta <- thr.theta + (-2.5 - min(thr.theta))
# Simulating the Discrimination parameter of the non-omission 
# indicators
diskr.theta <- runif(length(thr.theta),1,2.2)
# Simulating the non-omission indicators based on the 2-PLM
resp.ind.dat <- cut.function_grm(variable=theta,
                                  thr=as.list(thr.theta),
                                  diskr=diskr.theta)
#resp.ind.dat[apply(resp.ind.dat, 1, function(row) {all(row == 0)}),] <- rbinom(nitem, 1, 0.6)
# Generating the incomplete data set with omitted and not-reached items
# 1. omitted items
missing.dat <- complete.dat
missing.dat[resp.ind.dat == 0] <- NA
#Remove rows with all NA
NAS              <- apply(missing.dat,1,function(row) all(is.na(row)))
missing.dat.NONA <- missing.dat[!NAS,]
xi.NONA          <- xi.1[!NAS,]
theta.NONA       <- theta.1[!NAS,]
complete.dat2 <- complete.dat[!NAS,]
resp.ind.dat2 <- resp.ind.dat[!NAS,]
#colnames(missing.dat.NONA) <-  paste("Item",1:nitem,sep="")
########### table for columns of complete data
col.com.freq  <- table(col(complete.dat2), as.matrix(complete.dat2),exclude=NULL)
col.com.ratio <- col.com.freq/nrow(complete.dat2)
col.com.q     <- mean(col.com.ratio[,1])
col.com.p     <- mean(col.com.ratio[,2]) #?
#############
missing2.dat  <- missing.dat.NONA
col.miss.freq  <- table(col(missing2.dat), as.matrix(missing2.dat),exclude=NULL)
col.miss.ratio <- col.miss.freq/nrow(missing2.dat)
col.miss.p     <- mean(col.miss.ratio[,2]) #?
# correlation between item mean in complete and incomplete data
col.cor.pc.pmis   <- cor(col.com.ratio[,2],col.miss.ratio[,2]) #?
##################################################
row.com.freq  <- table(row(complete.dat2), as.matrix(complete.dat2),exclude=NULL)
row.com.ratio <- row.com.freq/ncol(complete.dat2)
row.com.q     <- mean(row.com.ratio[,1])
row.com.p     <- mean(row.com.ratio[,2]) #?
##################
row.miss.freq <- table(row(missing2.dat), as.matrix(missing2.dat),exclude=NULL)
row.miss.ratio <- row.miss.freq/ncol(missing2.dat)
row.miss.q  <- mean(row.miss.ratio[,1])
row.miss.p  <- mean(row.miss.ratio[,2]) #?
row.miss.na <- mean(row.miss.ratio[,3])
# correlation between proportion of correct score in complete and incomplete data 
row.cor.pc.pmis <- cor(row.com.ratio[,2],row.miss.ratio[,2]) #? 
####
col.mis.freq  <- table(col(missing2.dat), as.matrix(missing2.dat),exclude=NULL) 
col.mis.ratio <- col.mis.freq/nrow(missing2.dat)
col.mis0    <- mean(col.mis.ratio[,1]) #?
col.mis1    <- mean(col.mis.ratio[,2]) #?
col.misNA   <- mean(col.mis.ratio[,3]) #?
col.mis.cor.p.NA <- cor(col.mis.ratio[,3],col.mis.ratio[,2]) #?
####
row.mis.freq  <- table(row(missing2.dat), as.matrix(missing2.dat),exclude=NULL)
row.mis.ratio <- row.mis.freq/ncol(missing2.dat)
row.mis0    <- mean(row.mis.ratio[,1]) #?
row.mis1    <- mean(row.mis.ratio[,2]) #?
row.misNA   <- mean(row.mis.ratio[,3]) #?
row.mis.completed <- row.mis.ratio[,1]+row.mis.ratio[,2]
row.mis.cor.pc.p   <- cor(row.mis.completed,row.mis.ratio[,2])#?
######################
twodim.dat <- cbind(missing.dat.NONA,resp.ind.dat2)
colnames(twodim.dat) <-  paste("Item",1:(2*nitem),sep="")
#estimate item parameters
nitem1=nitem+1
nitem2=2*nitem
string <-  sprintf('F1=1-%i 
                    F2=%i-%i 
                    COV=F1*F2',nitem,nitem1,nitem2)
mod    <- mirt.model(string)
twodim <- mirt(twodim.dat, mod, SE=F, verbose=F)  
#Extract estimated item parameters and compute bias and RMSE 
parameter1  <- as.data.frame(coef(twodim, simplify=TRUE)$items)
parameter2  <- transform(parameter1,b=-d/a1)
parameter3  <- parameter2[1:nitem,]
abi        <-   fscores(twodim, method = "EAP", full.scores = TRUE, full.scores.SE=TRUE,returnER = F)
es.abi.1     <-   as.matrix(abi[,'F1'],ncol=1)
es.abi.2     <-   as.matrix(abi[,'F2'],ncol=1)
EAP.reli   <-  unname(fscores(twodim, method = "EAP", full.scores = TRUE, full.scores.SE=TRUE,returnER = T))
bias.a  <- round(mean(parameter3[,1]-diskr.xi.1), 3) 
bias.b  <- round(mean(parameter3[,6]-thr.xi.1), 3)
mse.a   <- round(mean((parameter3[,1]-diskr.xi.1)^2), 3) 
mse.b   <- round(mean((parameter3[,6]-thr.xi.1)^2), 3)  
rmse.a  <- round(sqrt(mean((parameter3[,1]-diskr.xi.1)^2)), 3) 
rmse.b  <- round(sqrt(mean((parameter3[,6]-thr.xi.1)^2)), 3) 
cor.abi.1 <- round(cor(es.abi.1,xi.NONA),3)
cor.abi.2 <- round(cor(es.abi.2,theta.NONA),3)
cor.abi.12 <- round(cor(es.abi.1,es.abi.2),3)
EAP.rel.1 <- round(EAP.reli[1],3)
EAP.rel.2 <- round(EAP.reli[2],3)
fit     <- anova(twodim)
AIC     <- fit$AIC 
AICc    <- fit$AICc  
SABIC   <- fit$SABIC     
HQ      <- fit$HQ 
BIC     <- fit$BIC
logLik  <- fit$logLik
fit.M2  <- M2(twodim, na.rm = FALSE, calcNull = TRUE,impute=3)
M2       <- fit.M2$M2[1]
M2s      <- fit.M2$M2[2]
df       <- fit.M2$df[1]
dfs      <- fit.M2$df[2]   
p        <- fit.M2$p[1]
pss       <- fit.M2$p[2]
RMSEA    <- fit.M2$RMSEA[1]
RMSEAs   <- fit.M2$RMSEA[2] 
RMSEA_5  <- fit.M2$RMSEA_5[1]
RMSEA_5s <- fit.M2$RMSEA_5[2] 
RMSEA_95 <- fit.M2$RMSEA_95[1]
RMSEA_95s<- fit.M2$RMSEA_95[2]    
SRMSR    <- fit.M2$SRMSR[1]
SRMSRs   <- fit.M2$SRMSR[2]
TLI      <- fit.M2$TLI[1]
TLIs     <- fit.M2$TLI[2]
CFI      <- fit.M2$CFI[1]
CFIs     <- fit.M2$CFI[2]

#extr.2d       <- extract.item(twodim, 2)
Theta         <- matrix(seq(-6,+6,0.1))
Theta.2d      <- as.matrix(expand.grid(Theta, Theta))
test.info     <- round(testinfo(twodim, Theta.2d,degrees =c(45,45),3))
#plot(twodim, type = 'info')
x.max.info.1    <- Theta.2d[,1][which.max(test.info)]
x.max.info.2    <- Theta.2d[,2][which.max(test.info)]
test.info.max <- round(max(testinfo(twodim, Theta.2d,degrees =c(45,45),3)))
test.se.min   <- round(min(1/sqrt(test.info)),3)


ctt.out   <- score.multiple.choice(key=rep(1,nitem), data=missing.dat,
score = TRUE, totals = FALSE, ilabels = NULL, missing = FALSE, impute = "non", digits = 3,short=FALSE,skew=FALSE)
Item.r  <- round(mean(ctt.out$item.stats$r),3)
Item.p  <- round(mean(ctt.out$item.stats$mean),3)
A.Score <- round(mean(ctt.out$scores),3)
Alpha   <- round((ctt.out$alpha),3)
#Combine the results in a single data set 
result  <- data.frame(sample.size=sample.size, nitem=nitem, corr=corr, bias.a=bias.a,
                     bias.b=bias.b, mse.a=mse.a,mse.b=mse.b,
                     rmse.a=rmse.a, rmse.b=rmse.b, EAP.rel.1=EAP.rel.1,EAP.rel.2=EAP.rel.2,
                     cor.abi.1=cor.abi.1,cor.abi.2=cor.abi.2,cor.abi.12=cor.abi.12,
                     AIC=AIC, AICc=AICc, SABIC=SABIC, HQ=HQ, BIC=BIC,
                     logLik=logLik, x.max.info.1=x.max.info.1,x.max.info.2=x.max.info.2, 
                     test.info.max=test.info.max, test.se.min=test.se.min, 
                     col.com.p=col.com.p, col.miss.p=col.miss.p, col.cor.pc.pmis=col.cor.pc.pmis,
                     row.com.p=row.com.p, row.miss.p=row.miss.p, row.cor.pc.pmis=row.cor.pc.pmis,
                     col.mis0=col.mis0, col.mis1=col.mis1, col.misNA=col.misNA, col.mis.cor.p.NA=col.mis.cor.p.NA,
                     row.mis0=row.mis0, row.mis1=row.mis1, row.misNA=row.misNA, row.mis.cor.pc.p=row.mis.cor.pc.p,
                     M2=M2, M2s=M2s, df=df, dfs=dfs, p=p, pss=pss, RMSEA=RMSEA, RMSEAs=RMSEAs,
                     RMSEA_5=RMSEA_5,RMSEA_5s=RMSEA_5s, RMSEA_95=RMSEA_95,RMSEA_95s=RMSEA_95s,
                     SRMSR=SRMSR,SRMSRs=SRMSRs, TLI=TLI,TLIs=TLIs, CFI=CFI,CFIs=CFIs,
                     Item.r=Item.r, Item.p=Item.p, A.Score=A.Score, Alpha=Alpha) 
return(result)
}

write.table(matrix(c("Sample Size", "Test Length", "Correlation","Bias.a", "Bias.b",
                     "MSE.a","MSE.b", "RMSE.a",
                     "RMSE.b", "EAP.rel.1","EAP.rel.2","Cor.Abi.1","Cor.Abi.2",
                     "Cor.Abi.12","AIC","AICc","SABIC","HQ","BIC",
                     "logLik","x.max.info.1","x.max.info.2","Test.Info.max","Test.SE.min",
                     "col.com.p","col.miss.p","col.cor.pc.pmis",
                     "row.com.p","row.miss.p","row.cor.pc.pmis",
                     "col.mis0","col.mis1","col.mis0NA","col.mis.cor.p.NA",
                     "row.mis0","row.mis1","row.misNA","row.mis.cor.pc.p",
                     "M2","M2s","df","dfs","p", "pss","RMSEA","RMSEAs",
                     "RMSEA_5","RMSEA_5s","RMSEA_95","RMSEA_95s","SRMSR","SRMSRs",
                     "TLI","TLIs","CFI","CFIs",
                     "Item.r", "Item.p", "A.Score", "Alpha"),
                     1, 60),"30%MISS-2dim-m.csv", sep = ",", col.names = FALSE, row.names = FALSE)
#Define an empty data frame to store the simulation results 
result <- data.frame(sample.size=0, nitem=0, corr=0, bias.a=0, bias.b=0,
                      mse.a=0,mse.b=0, rmse.a=0,
                      rmse.b=0,EAP.rel.1=0,EAP.rel.2=0, cor.abi.1=0,cor.abi.2=0, cor.abi.12=0,
                      AIC=0, AICc=0, SABIC=0,
                      HQ=0, BIC=0, logLik=0,x.max.info.1=0,x.max.info.2=0,test.info.max=0, test.se.min=0,
                      col.com.p=0,col.miss.p=0,col.col.cor.pc.pmis=0,
                      row.com.p=0,row.miss.p=0,row.cor.pc.pmis=0,
                      col.mis0=0,col.mis1=0,col.misNA=0,col.mis.cor.p.NA=0,
                      row.mis0=0,row.mis1=0,row.misNA=0,row.mis.cor.pc.p=0,
                      M2=0, M2s=0,df=0,dfs=0, p=0, pss=0,RMSEA=0,RMSEAs=0,RMSEA_5=0,RMSEA_5s=0,
                      RMSEA_95=0,RMSEA_95s=0,SRMSR=0,SRMSRs=0,TLI=0,TLIs=0,CFI=0,CFIs=0,
                      Item.r=0, Item.p=0, A.Score=0, Alpha=0)

# all combination based on sample size, number of items and latent correlation
sample.size <- c(505, 1005, 2005)
test.length <- c(15, 30, 45) 
correlation <- c(0.0, 0.4, 0.8)
#Generate 100 random integers 
myseed <- sample.int(n = 1000000, size =3)
#write.csv(myseed, "simulation seeds.txt", row.names = FALSE)
#myseed.2 <- read.table("simulation seeds.txt", header = T)
core=detectCores()
registerDoParallel(cores=core-1)
#Run the loop and return the results across 100 iterations 
foreach(s=sample.size, .combine = cbind) %:% 
             foreach(t=test.length, .combine = cbind) %:%  
                foreach(k=correlation, .combine = cbind) %:%  
                  foreach(i=1:3, .combine = rbind) %dopar% {
result <-    itemrecovery(sample.size = sample.size[s], nitem = test.length[t],corr=correlation[k],seed = myseed[i])   
}
write.table(result,"30%miss-2dim-data.csv", sep = ",", col.names =F, row.names = T,append = TRUE)
result.m <- round(colMeans(result), 3) 
write.table(matrix(result.m, 1, 60),"30%MISS-2dim-m.csv", sep = ",", col.names = FALSE, row.names = FALSE, append = TRUE)
      


