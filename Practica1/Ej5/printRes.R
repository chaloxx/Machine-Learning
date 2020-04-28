rm(list = ls())
setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica1/Ej5")
library(data.table)

datos <- read.table("res.txt",header=FALSE,sep=",",col.names=c("class","size","trainingError","testError"))
length <- nrow(datos)

datosTable <- as.data.table(datos)


trainingError <- (datosTable[,sum(trainingError)/20,by = class])[,2]
testError <- datosTable[,sum(testError)/20,by = class][,2]
size <- (datosTable[,sum(size)/20,by = class])[,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(class,trainingError,testError,size))
names(matrix) <- c("trainingSize:","trainingError","testError","size of tree(nodes)")
log <- 0:5


plot(log,matrix[,2],col="yellow",xlim=c(0,5),ylim=c(0,16),xlab="Esc. logarítmica \n (El tamaño del training set es 125*2^x)",ylab="% de error",main="Paralelo:Training error vs test error",type="o")
points(log,matrix[,3],col="green",type="o")
text(c(2,2),c(12,8),labels=c("Test error","Training error"))

plot(log,matrix[,4],type="o",col="darkgreen",xlab="Escala logarítmica \n (el tamaño del training set es 125*2^x)",ylab="Cantidad de nodos",main="Paralelo: Cantidad de nodos")

