#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

double aux(int pot){
   return (float) (rand() % 10) / pow(10,pot);
}

// Generar número "real" aleatorio en el intervalo [leftLim,rightLim]
double floatRanGen(double leftLim, double rightLim){
  double diff = rightLim-leftLim;
  double res = 0, dec = 0, cent = 0, mil = 0, partEnt = 0;
  do{
  partEnt = rand() % ((int)floor(diff)+1);
  dec = aux(1);
  cent = dec + aux(2);
  mil = cent + aux(3);
  res = partEnt + mil;
  } while(res > diff);
  return leftLim + res;
}

double square(double x){
  return pow(x,2);
}

// Calcular densidad normal para val
float calcularNormal(float val, float desvEst, float mean){
  double var = pow(desvEst,2);
  return 1/(sqrt(2*M_PI) * desvEst) * exp(-square(val-mean)/(2*var) );

}


// Generar n puntos en d dimensiones siguiendo una distribución normal
// parametrizada por una constante c y con centro mean
void genPoints(int d, int n, double desvEst, double mean, double vals[][d+1]){
  // Calculamos cuanto vale la normal en la mediana
  double maxNormal = calcularNormal(mean,desvEst,mean);
  printf("El mean es %f y la desvEst %f\n",mean,desvEst);
  //Extremos del intervalo
  double leftLim = mean-5*desvEst, rightLim = mean+5*desvEst,probs[d];
  printf("leftLim: %f, rightLim: %f\n",leftLim,rightLim );
  // Calcular n puntos con centro en (n,n,...,n)
  for(int i = 0; i < n;i++){
       // Calcular punto aleatorio de d dimensiones
       for(int j = 0;j < d ;j++){
         double x = 0,y = 0, densX = 0;
         do{
           //x pertenece al intervalo [mean-5*desvEst,mean+5*desvEst]
           x = floatRanGen(leftLim,rightLim);
           // y pertenece al intervalo [0,maxNormal]
           y = floatRanGen(0,maxNormal);
           densX = calcularNormal(x,desvEst,mean);
         }while(y > densX); //Rechazo el punto si y es mayor a su densidad
         vals[i][j] = x;
         probs[j] = y;
       }
       //Obtener densidad del punto
       vals[i][d] = 1;
       for(int k = 0;k < d;k++)
             vals[i][d] = vals[i][d]*probs[k];
  }
}


int writeNames(int n){
  FILE *fptr = fopen("ej1.names","w");
  if (fptr == NULL){
    printf("Error\n");
    return 1;
  }
  for(int i = 0;i < n;i++){
    fprintf(fptr, "%d\n",i);
    if (i+1 < n) fprintf(fptr,",");
  }
  fprintf(fptr, ".\n");
  for(int i = 0; i < n;i++)
    fprintf(fptr, "x%d:continuous.\n",i);
  fclose(fptr);
  return 0;
}


int writeEntries(int n, int d, double entries[n][d+1]){
  FILE *fptr = fopen("ej1.data","w");
  if (fptr == NULL){
    printf("Error\n");
    return 1;
  }

  for(int i = 0; i < n;i++)

    for(int j = 0; j < d+1; j++){
      fprintf(fptr,"%f",entries[i][j]);
      if(j < d)fprintf(fptr,",");
      else fprintf(fptr, "\n");
    }
  fclose(fptr);
  return 0;
}

void showRes(int n, int d, double vals[n][d+1], int class){
  printf("%s\n",path);
  char path[10];
  path = sprintf(path,"clase%d.R",class);
  FILE* fptr = fopen(path,"w");
  if (fptr ==  NULL) {
    printf("Error\n");
    return;
  }
  for(int i = 0; i < d;i++){
    fprintf(fptr,"col_%d <- c(",class+i);
    for(int j = 0; j < n;j++){
      fprintf(fptr,"%f",vals[j][i]);
      if (j+1 < n) fprintf(fptr,",");
    }
    fprintf(fptr,")\n");
  }
  fclose(fptr);
}



// Agregar clase a la matriz de valores
void addClass(int d,int n, double class,double vals[n][d+1]){
  for(int i = 0; i < n; i++)
      vals[i][d] = class;
}


int main(int argc, char** argv){
   if(argc != 4){
      printf("Cantidad de argumentos inválida\n");
      return 0;
   }
   time_t t;
   //Inicializar generador
   srand(time(&t));
   //constante
   double c = atof(argv[3]);
   //cantidad de samples, dimensión
   int d = atoi(argv[1]), n = atoi(argv[2]);
   if (n % 2 == 0){
     printf("Error. El número de samples tiene que ser un número par\n");
   }
   double desvEst = c*sqrt(d);
   writeNames(d);
   double vals[n][d+1];
   genPoints(d,n/2,desvEst,1,vals);
   showRes(n/2,2,vals,1);
   addClass(d,n/2,1,vals);
   genPoints(d,n/2,desvEst,-1,vals+n/2);
   showRes(n/2,2,vals+n/2,0);
   addClass(d,n/2,0,vals+n/2);
   writeEntries(n,d,vals);
}
