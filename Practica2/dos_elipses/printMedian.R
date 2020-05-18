setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/dos_elipses/")
datos <- read.table("vals",sep = "\t",header = FALSE)
cat(median(datos[,1]))
