setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica3/Ej3/dos_elipses/")
datos <- read.table("dos_elipses.mse",sep = "\t",header = FALSE)
i <- which.min(datos[,6])
cat(datos[i,5],datos[i,7])
