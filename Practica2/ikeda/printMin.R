setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/ikeda/")
datos <- read.table("ikeda.mse",sep = "\t",header = FALSE)
i<- which.min(datos[,3])
cat(datos[i,7])
