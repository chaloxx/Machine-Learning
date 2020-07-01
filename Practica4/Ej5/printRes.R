rm(list = ls())
library(data.table)
library(ggplot2)
library(tidyverse)


prob = "paralelo"
setwd(paste("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica4/Ej5/",prob,sep=""))
datos <- read.table(paste(prob,".nn.info",sep=""),header=FALSE,sep=" ",col.names=c("class","trainError","testError"))

datosTable <- as.data.table(datos)


trainError <- (datosTable[,sum(trainError)/20,by = class])[,2]
testError <- (datosTable[,sum(testError)/20,by = class])[,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(class,trainError*100,testError*100))





datos2 <- read.table(paste(prob,".tree.info",sep=""),header=FALSE,sep=" ",col.names=c("class","nodos","trainError","testError"))

datosTable2 <- as.data.table(datos2)


trainError2 <- (datosTable2[,sum(trainError)/20,by = class])[,2]
testError2 <- datosTable2[,sum(testError)/20,by = class][,2]
class2 <- (datosTable2[!duplicated(class)])[,class]

matrix2 <- as.data.frame(cbind(class2,trainError2,testError2))


datos3 <- read.table(paste(prob,".nb.info",sep=""),header=FALSE,sep=" ",col.names=c("class","trainError","testError"))

datosTable3 <- as.data.table(datos3)


trainError3 <- (datosTable3[,sum(trainError)/20,by = class])[,2]
testError3 <- datosTable3[,sum(testError)/20,by = class][,2]
class3 <- (datosTable3[!duplicated(class)])[,class]

matrix3 <- as.data.frame(cbind(class3,trainError3*100,testError3*100))


datos4 <- read.table(paste(prob,".knn.info",sep=""),header=FALSE,sep=" ",col.names=c("class","trainError","testError"))


datosTable4 <- as.data.table(datos4)


trainError4 <- (datosTable4[,sum(trainError)/20,by = class])[,2]
testError4 <- datosTable4[,sum(testError)/20,by = class][,2]
class4 <- (datosTable4[!duplicated(class)])[,class]

matrix4 <- as.data.frame(cbind(class4,trainError4*100,testError4*100))



labels <- c("Redes-Train","Redes-Test","Árboles-Train","Árboles-Test","Naive Bayes-Train","Naive Bayes-Test","KNN-Train","KNN-Test")
colors <- c("Redes-Train" = "red","Redes-Test" = "blue","Árboles-Train" = "yellow","Árboles-Test" = "green","Naive Bayes-Train"="black","Naive Bayes-Test"="darkorange","KNN-Train"="violet","KNN-Test"="dimgray")
df <- data.frame(dimension=c(matrix[,1],matrix[,1],matrix[,1],matrix[,1],matrix[,1],matrix[,1],matrix[,1],matrix[,1]),
                 errores=c(matrix[,2],matrix[,3],matrix2[,2],matrix2[,3],matrix3[,2],matrix3[,3],matrix4[,2],matrix4[,3]),
                 class=c(rep(labels[1],5),rep(labels[2],5),rep(labels[3],5),rep(labels[4],5),rep(labels[5],5),rep(labels[6],5),rep(labels[7],5),rep(labels[8],5)))

plot <-  ggplot(df,aes(x=dimension,y=errores,colour=as.factor(class))) +
         geom_line() +
         geom_point()+
         labs(x = "Dimensionalidad",y = "Error %",color = "Legend") +
         scale_colour_manual(name= "",values=colors) +
         theme(legend.position='top') +
         theme(plot.title = element_text(hjust = 0.5)) + 
         ggtitle(paste("Problema",prob))

plot

  






