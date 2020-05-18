setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/faces/")

datos <- read.table("faces.mse",sep = "\t",header = FALSE)

rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())


setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/faces/")
datos <-read.table("faces.mse",sep = "\t",header = FALSE)


n <- nrow(datos)
labels <- c("Training","Test")
colors <- c("Training" = "blue","Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n),
                 errores=c(datos[,5]*100,datos[,7]*100),
                 class=c(rep(labels[1],n),rep(labels[2],n)))

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
  geom_line() +
  labs(x = "NERROR (x = número de épocas)",y = "Error %",color = "Legend") +
  scale_colour_manual(name= "",values=colors) +
  theme(legend.position='top') +
  theme(plot.title = element_text(hjust = 0.5)) + 
  ggtitle("Clasificación para faces")

plot
