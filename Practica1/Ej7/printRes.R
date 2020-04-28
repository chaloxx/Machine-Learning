rm(list = ls())
setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica1/Ej7")
library(data.table)

datos <- read.table("res.txt",header=FALSE,sep=",",col.names=c("class","nodes","trainError","testError"))


datosTable <- as.data.table(datos)


trainError <- (datosTable[,sum(trainError)/20,by = class])[,2]
testError <- (datosTable[,sum(testError)/20,by = class])[,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(class,trainError,testError))



datos2 <- read.table("res.txt",header=FALSE,sep=",",col.names=c("class","nodes","trainError","testError"))

datosTable2 <- as.data.table(datos2)


trainError2 <- (datosTable2[,sum(trainError)/20,by = class])[,2]
testError2 <- datosTable2[,sum(testError)/20,by = class][,2]
class2 <- (datosTable2[!duplicated(class)])[,class]

matrix2 <- as.data.frame(cbind(class2,trainError2,testError2))




plot(matrix[,1],matrix[,2],col="blue",type="o",ylim=c(0,50),xlab="Dimensionalidad",ylab="% de error")
points(matrix[,1],matrix[,3],col="red",type="o")
points(matrix2[,1],matrix2[,2],col="green",type="o")
points(matrix2[,1],matrix2[,3],col="violet",type="o")


labels <- c("Diagonal-training error", "Diagonal-test error","Paralelo-training error","Paralelo-test error")
color <- c("blue","red","green","violet")


legend(1.5, 50, legend=labels,col=color, lty=1, cex=0.7)

