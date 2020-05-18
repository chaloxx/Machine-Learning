rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/ssp/")
datos <-read.table("ssp.mse",sep = "\t",header = FALSE)
n <- nrow(datos)
labels <- c("Entrenamiento","Penalización de pesos","Test")
colors <- c("Entrenamiento" = "blue","Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n),
                 errores=c(datos[,2],datos[,4]),
                 class=c(rep(labels[1],n),rep(labels[3],n)) )

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
         geom_line() +
         labs(x = "NERROR (x*200 = número de épocas)",y = "MSE",color = "Legend") +
         scale_colour_manual(name= "",values=colors) +
         theme(legend.position='top') +
         theme(plot.title = element_text(hjust = 0.5)) + 
         ggtitle("Regularización por weight-decay (gamma = 10^-7)")

plot

colors <- c("Penalización de pesos" = "red")
df <- data.frame(epoca=1:n,
                 errores=datos[,3],
                 class=rep(labels[2],n))
plot2 <- ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
         geom_line() +
         labs(x = "NERROR (x*200 = número de épocas)",y = "",color = "Legend") +
         scale_colour_manual(name= "",values=colors) +
         theme(plot.title = element_text(hjust = 0.5)) +
         theme(legend.position='none') +
         ggtitle("Término de penalización")
plot2
