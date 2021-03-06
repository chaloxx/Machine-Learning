setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/iris/")

datos <- read.table("iris.mse",sep = "\t",header = FALSE)

rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())


setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/iris/")
datos <-read.table("iris.mse",sep = "\t",header = FALSE)


n <- nrow(datos)
labels <- c("Training","Validación","Test")
colors <- c("Training" = "blue","Validación" = "green","Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n,1:n),
                 errores=c(datos[,2],datos[,3],datos[,4]),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)))

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
  geom_line() +
  labs(x = "NERROR (x*10 = número de épocas)",y = "MSE",color = "Legend") +
  scale_colour_manual(name= "",values=colors) +
  theme(legend.position='top') +
  theme(plot.title = element_text(hjust = 0.5)) + 
  ggtitle("Curvas de aprendizaje para iris")

plot
