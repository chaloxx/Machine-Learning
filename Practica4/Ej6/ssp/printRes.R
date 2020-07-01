rm(list = ls())

library(data.table)
library(ggplot2)
library(tidyverse)




setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica4/Ej6/ssp/")
datos <-read.table("bp.info",sep = "\t",header = FALSE)
datos <- data.frame(class = datos[,1],trainError = datos[,2], validError = datos[,3], testError = datos[,4])
datosTable <- as.data.table(datos)


trainError <- (datosTable[,sum(trainError)/20,by=class])[,2]
validError <- (datosTable[,sum(validError)/20,by=class])[,2]
testError <- datosTable[,sum(testError)/20,by=class][,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(trainError,validError,testError))



n <- nrow(matrix)
labels <- c("Entrenamiento","Validación","Test")
colors <- c("Entrenamiento" = "blue","Validación" = "red", "Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n,1:n),
                 errores=c(matrix[,1],matrix[,2],matrix[,3]),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)) )

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
         geom_line() +
         labs(x = "NERROR (x*200 = número de épocas)",y = "MSE",color = "Legend") +
         scale_colour_manual(name= "",values=colors) +
         theme(legend.position='top') +
         theme(plot.title = element_text(hjust = 0.5)) + 
         ggtitle("SSP con NN")

plot



datos <-read.table("knn.info",sep = " ",header = FALSE,col.names = c("class","trainError","validError","testError"))
datosTable <- as.data.table(datos)


trainError <- (datosTable[,sum(trainError)/20,by=class])[,2]
validError <- (datosTable[,sum(validError)/20,by=class])[,2]
testError <- datosTable[,sum(testError)/20,by=class][,2]
class <- (datosTable[!duplicated(class)])[,class]

matrix <- as.data.frame(cbind(trainError,validError,testError))



n <- nrow(matrix)
labels <- c("Entrenamiento","Validación","Test")
colors <- c("Entrenamiento" = "blue","Validación" = "red", "Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n,1:n),
                 errores=c(matrix[,1],matrix[,2],matrix[,3]),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)) )

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
  geom_line() +
  labs(x = "Número de vecinos",y = "MSE",color = "Legend") +
  scale_colour_manual(name= "",values=colors) +
  theme(legend.position='top') +
  theme(plot.title = element_text(hjust = 0.5)) + 
  ggtitle("SSP con KNN")

plot

