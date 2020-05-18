setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/gausianas/paralelo/")

datos <- read.table("paralelo.mse",sep = "\t",header = FALSE)
epocas <- 1:nrow(datos)
i <- which.min(datos[,6])
cat(datos[i,5],datos[i,7])

