rm(list = ls())
setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica1/Ej6")
library(data.table)

#datos <- read.table("res.txt",header=FALSE,sep=",",col.names=c("class","beforePrun","afterPrun"))
#bayes <- read.table("bayes.txt",header=FALSE,col.names = c("Min Error"))

datosTable <- as.data.table(datos)


beforePrun <- (datosTable[,sum(beforePrun)/20,by = class])[,2]
afterPrun <- datosTable[,sum(afterPrun)/20,by = class][,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(class,beforePrun,afterPrun))






datos2 <- read.table("res.txt",header=FALSE,sep=",",col.names=c("class","beforePrun","afterPrun"))
bayes2 <- read.table("bayes.txt",header=FALSE,col.names = c("Min Error"))


datosTable2 <- as.data.table(datos2)


beforePrun2 <- (datosTable2[,sum(beforePrun)/20,by = class])[,2]
afterPrun2 <- datosTable2[,sum(afterPrun)/20,by = class][,2]
class2 <- (datosTable2[!duplicated(class)])[,class]

matrix2 <- as.data.frame(cbind(class2,beforePrun2,afterPrun2))

plot(matrix[,1],matrix[,2],col="green",type="o",ylim=c(0,50),xlab="Valor de C",ylab="% de error")
points(matrix[,1],matrix[,3],col="brown",type="o")
points(matrix2[,1],matrix2[,2],col="blue",type="o")
points(matrix2[,1],matrix2[,3],col="yellow",type="o")
points(matrix[,1],bayes[,1],col="black",type="o")
points(matrix2[,1],bayes2[,1],col="violet",type="o")



labels <- c("Diagonal-before prunning","Diagonal-after prunning","Paralelo-before prunning", "Paralelo-after prunning","Diagonal Mín. Error","Paralelo Mín. Error")
color <- c("green","brown","blue","yellow","black","violet")

legend(1.9, 20, legend=labels,col=color, lty=1, cex=0.6,pch =1)





