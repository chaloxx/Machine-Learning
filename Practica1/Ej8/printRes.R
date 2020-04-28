library(comprehenr)
library(chron)
library(tidyverse)

rm(list = ls())
setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica1/Ej8")
library(data.table)


datos <- read.table("xor.data",header=FALSE,sep=",",col.names=c('x0','x1','x2','x3','x4','x5','class'))
attach(datos)

class1 <- datos %>% filter(class == 1)
class0 <- datos %>% filter(class == 0)

plot(class1[,1],class1[,2],col = "red",xlab="x0",ylab="x1")
points(class0[,1],class0[,2],col = "blue")
axis(side=1,pos=c(0,0),at=c(-1,1),)
axis(side=2,pos=c(0,0),at=c(-1,1))
legend(0.8,-0.5,legend=c("0","1"),col=c("red","blue"), cex=0.7,pch=1,title="Clases")






entropy <- function(df){
  c0 <- df %>% filter(class == 0)
  c1 <- df %>% filter(class == 1)
  p0 <- nrow(c0)/200
  p1 <- nrow(c1)/200
  -(p0*log2(p0) + p1*log2(p1))
}


ganancia <- function(x){
  menores <- datos %>% filter(x0 <= x)
  mayores <- datos %>% filter(x0 > x)
  nrow(menores)/200*entropy(menores) + nrow(mayores)/200*entropy(mayores)
}

vals <- seq(from=-0.9,to=0.9,by=0.0001)
res <- vals

for (i in 1:length(vals)){
  res[i] <- 1-ganancia(vals[i])
}



index <- function(r,x){
  val = 0
  for (i in 1:length(r)){
    if(r[i] == x){
      val=i
    }
  } 
  val
}

