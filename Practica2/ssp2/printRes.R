rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())


setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/ssp2/")
datos <-read.table("b1.mse",sep = "\t",header = FALSE)
datos2 <-read.table("b10.mse",sep = "\t",header = FALSE)
datos3 <-read.table("b20.mse",sep = "\t",header = FALSE)



n <- nrow(datos)
labels <- c("Batch:1","Batch:10","Batch:20")
colors <- c("Batch:1" = "blue","Batch:10" = "red", "Batch:20" = "green")
df <- data.frame(epoca=c(1:n,1:n,1:n),
                 errores=c(datos[,2],datos2[,2],datos3[,2]),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)))

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
  geom_line() +
  labs(x = "NERROR (x*200 = número de épocas)",y = "MSE",color = "Legend") +
  scale_colour_manual(name= "",values=colors) +
  theme(legend.position='top') +
  theme(plot.title = element_text(hjust = 0.5)) + 
  ggtitle("Curvas de aprendizaje para batches de distinto tamaño")

plot
