 #include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>
#define  COTA  8*M_PI
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



bool pred1(double r, double theta){
  return r >= theta / (4*M_PI) && r <= (theta+M_PI)/(4*M_PI);
}

bool pred2(double r, double theta){
  return  r < theta / (4*M_PI) && r >(theta-M_PI)/(4*M_PI);
}


void genPolarCoord(double xOrigen,double yOrigen,double* vals,bool (*pred) (double,double), double class){
  double r = 0, theta = 0;
  do{
    r = floatRanGen(0,1); // Generar radio entre 0 y 1
    theta = floatRanGen(-COTA,COTA); // Generamos un ángulo en términos de radianes
  }while(!pred(r,theta));
  vals[0] = xOrigen +  r * cos(theta) ; // Coordenada x
  vals[1] = yOrigen +  r * sin(theta); // Coordenada
  vals[2] = class;
}

void showRes(int n, int d, double vals[n][d+1], char* path){
  printf("%s\n",path);
  FILE* fptr = fopen(path,"w");
  if (fptr ==  NULL) {
    printf("Error\n");
    return;
  }
  for(int i = 0; i < d;i++){
    fprintf(fptr,"col_%d <- c(",i);
    for(int j = 0; j < n;j++){
      fprintf(fptr,"%f",vals[j][i]);
      if (j+1 < n) fprintf(fptr,",");
    }
    fprintf(fptr,")\n");
  }
  fclose(fptr);
}




int writeEntries(int n, int d, double entries[n][d+1]){
  FILE *fptr = fopen("ej3.data","w");
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

void addClass(int d,int n, double class,double vals[n][d+1]){
  for(int i = 0; i < n; i++)
      vals[i][d] = class;
}

int writeNames(int n){
  FILE *fptr = fopen("ej3.names","w");
  if (fptr == NULL){
    printf("Error\n");
    return 1;
  }
  for(int i = 0;i < n;i++){
    fprintf(fptr, "%d",i);
    if (i+1 < n) fprintf(fptr,",");
  }
  fprintf(fptr, ".\n");
  for(int i = 0; i < n;i++)
    fprintf(fptr, "x%d:continuous.\n",i);
  fclose(fptr);
  return 0;
}

int main(int argc, char** argv){
  if (argc != 4){
    printf("Error en la cantidad de argumentos\n");
    return 1;
  }
  time_t t;
  srand(time(&t));
  // Cantidad de samples
  int n = atoi(argv[1]);
  // Coordenadas de referencia
  double xOrigen = atof(argv[2]), yOrigen = atof(argv[3]);
  // Matriz para llenar con datos
  double vals[n][3];
  int i = 0;
  writeNames(2);
  for(; i < n/2;i++)
      genPolarCoord(xOrigen,yOrigen,vals[i],pred1,0);
  for(; i < n;i++)
      genPolarCoord(xOrigen,yOrigen,vals[i],pred2,1);
  writeEntries(n,2,vals);
}
