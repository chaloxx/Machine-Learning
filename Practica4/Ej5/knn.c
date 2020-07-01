#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <stdbool.h>



int mayor(const void* x, const void* y){
  return (*(float*)x) > (*(float*)y);
}

/*defino una estructura para el clasificador naive bayes*/
struct KNN {
    int N_IN;           /*Total numbre of inputs*/
    int N_Class;        /*Total number of classes (outputs)*/

    int SEED;           /* semilla para la funcion rand(). Los posibles valores son:*/
                    /* SEED: -1: No mezclar los patrones: usar los primeros PR para entrenar
                                 y el resto para validar.Toma la semilla del rand con el reloj.
                              0: Seleccionar semilla con el reloj, y mezclar los patrones.
                             >0: Usa el numero leido como semilla, y mezcla los patrones. */

    float distMax; //Distancia máxima a la que deben estar los vecinos

};

struct DATOS {
    char *filename;      /* nombre del archivo para leer los datos */
    int N_IN;             /* N1: dimensiones de entrada */
    int PTOT;           /* cantidad TOTAL de patrones en el archivo .data */
    int PR;             /* cantidad de patrones de ENTRENAMIENTO */
                        /* cantidad de patrones de VALIDACION: PTOT - PR*/
    int PTEST;          /* cantidad de patrones de TEST (archivo .test) */

    /*matrices de datos*/
    float **data;                     /* train data */
    float **test;                     /* test  data */
    int *pred;                        /* salidas predichas ES UNA CLASE*/
    int *seq;      	       	      /* indice de acceso con la sequencia de presentacion de los patrones*/
};

int CONTROL;        /* nivel de verbosity */



/* -------------------------------------------------------------------------- */
/*define_matrix_datos: reserva espacio en memoria para todas las matrices de datos declaradas.
  Todas las dimensiones son leidas del archivo .net en la funcion arquitec()  */
/* -------------------------------------------------------------------------- */
int define_matrix_datos(struct DATOS *datos){
  int i,max;

  datos->seq=(int *)calloc(datos->PTOT,sizeof(int));
  for(i=0;i<datos->PTOT;i++) datos->seq[i]=i;  /* inicializacion del indice de acceso a los datos */

  datos->data=(float **)calloc(datos->PTOT,sizeof(float *));
  if(datos->PTEST) datos->test=(float **)calloc(datos->PTEST,sizeof(float *));

  if(datos->PTOT>datos->PTEST) max=datos->PTOT;
  else max=datos->PTEST;
  datos->pred=(int *)calloc(max,sizeof(int));

  if(datos->seq==NULL||datos->data==NULL||(datos->PTEST&&datos->test==NULL)||datos->pred==NULL) return 1;

  for(i=0;i<datos->PTOT;i++){
    datos->data[i]=(float *)calloc(datos->N_IN+1,sizeof(float));
	if(datos->data[i]==NULL) return 1;
  }
  for(i=0;i<datos->PTEST;i++){
    datos->test[i]=(float *)calloc(datos->N_IN+1,sizeof(float));
	if(datos->test[i]==NULL) return 1;
  }

  return 0;
}

/* ---------------------------------------------------------------------------------- */
/*arquitec: Lee el archivo .nb e inicializa el algoritmo en funcion de los valores leidos
  filename es el nombre del archivo .nb (sin la extension) */
/* ---------------------------------------------------------------------------------- */
int arquitec(char *filename,struct KNN *knn,struct DATOS *datos){
  FILE *b;
  char filepat[100];
  int i,j;
  /*bandera de error*/
  int error;

  time_t t;

  /*Paso 1:leer el archivo con la configuracion*/
  sprintf(filepat,"%s.knn",filename);
  b=fopen(filepat,"r");
  error=(b==NULL);
  if(error){
    printf("Error al abrir el archivo de parametros\n");
    return 1;
  }

  /* Dimensiones */
  fscanf(b,"%d",&knn->N_IN);
  fscanf(b,"%d",&knn->N_Class);
  datos->N_IN=knn->N_IN;

  /* Archivo de patrones: datos para train y para validacion */
  fscanf(b,"%d",&datos->PTOT);
  fscanf(b,"%d",&datos->PR);
  fscanf(b,"%d",&datos->PTEST);
  fscanf(b,"%f",&knn->distMax);

  /* Semilla para la funcion rand()*/
  fscanf(b,"%d",&knn->SEED);

  /* Nivel de verbosity*/
  fscanf(b,"%d",&CONTROL);

  fclose(b);


  if(error){
    printf("Error en la definicion de matrices del clasificador\n");
    return 1;
  }
  error=define_matrix_datos(datos);
  if(error){
    printf("Error en la definicion de matrices de datos\n");
    return 1;
  }


  /* Chequear semilla para la funcion rand() */
  if(knn->SEED==0) knn->SEED=time(&t);

  /*Imprimir control por pantalla*/
  printf("\nNaive Bayes con distribuciones normales:\nCantidad de entradas:%d",knn->N_IN);
  printf("\nCantidad de clases:%d",knn->N_Class);
  printf("\nArchivo de patrones: %s",filename);
  printf("\nCantidad total de patrones: %d",datos->PTOT);
  printf("\nCantidad de patrones de entrenamiento: %d",datos->PR);
  printf("\nCantidad de patrones de validacion: %d",datos->PTOT-datos->PR);
  printf("\nCantidad de patrones de test: %d",datos->PTEST);
  printf("\nDistancia máx: %f",knn->distMax);
  printf("\nSemilla para la funcion rand(): %d",knn->SEED);

  return 0;
}
/* -------------------------------------------------------------------------------------- */
/*read_data: lee los datos de los archivos de entrenamiento(.data) y test(.test)
  filenamepasado es el nombre de los archivos (sin extension)
  La cantidad de datos y la estructura de los archivos fue leida en la funcion arquitec()
  Los registros en el archivo pueden estar separados por blancos ( o tab ) o por comas    */
/* -------------------------------------------------------------------------------------- */
int read_data(char *filenamepasado,struct DATOS *datos){

  FILE *fpat;
  char filepat[100];
  float valor;
  int i,k,separador;
  /*bandera de error*/
  int error;

  sprintf(filepat,"%s.data",filenamepasado);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de datos\n");
    return 1;
  }

  datos->filename=filenamepasado;

  if(CONTROL>1) printf("\n\nDatos de entrenamiento:");

  for(k=0;k<datos->PTOT;k++){
	 if(CONTROL>1) printf("\nP%d:\t",k);
 	 for(i=0;i<datos->N_IN+1;i++){
	   fscanf(fpat,"%f",&valor);
	   datos->data[k][i]=valor;
	   if(CONTROL>1) printf("%f\t",datos->data[k][i]);
	   separador=getc(fpat);
	   if(separador!=',') ungetc(separador,fpat);
  	 }
  }
  fclose(fpat);

  if(!datos->PTEST) return 0;

  sprintf(filepat,"%s.test",filenamepasado);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de test\n");
    return 1;
  }

  if(CONTROL>1) printf("\n\nDatos de test:");

  for(k=0;k<datos->PTEST;k++){
	 if(CONTROL>1) printf("\nP%d:\t",k);
         for(i=0;i<datos->N_IN+1;i++){
	   fscanf(fpat,"%f",&valor);
	   datos->test[k][i]=valor;
	   if(CONTROL>1) printf("%f\t",datos->test[k][i]);
	   separador=getc(fpat);
	   if(separador!=',') ungetc(separador,fpat);
         }
  }
  fclose(fpat);

  return 0;

}

/* ------------------------------------------------------------ */
/* shuffle: mezcla el vector seq al azar.
   El vector seq es un indice para acceder a los patrones.
   Los patrones mezclados van desde seq[0] hasta seq[hasta-1]
   Esto permite separar la parte de validacion de la de train   */
/* ------------------------------------------------------------ */
void shuffle(int hasta,struct DATOS *datos){
   float x;
   int tmp;
   int top,select;

   top=hasta-1;
   while (top > 0) {
	x = (float)rand();
	x /= (RAND_MAX+1.0);
	x *= (top+1);
	select = (int)x;
	tmp = datos->seq[top];
	datos->seq[top] = datos->seq[select];
	datos->seq[select] = tmp;
	top --;
   }
  if(CONTROL>3) {printf("End shuffle\n");fflush(NULL);}
}

double square(float x){
  return pow(x,2);
}


float calcularDistanciaEuclidea(float* input1, float* input2, unsigned dim){
  float dist = 0;
  for(unsigned i = 0; i<dim;i++) dist += square(input1[i]-input2[i]);
  return sqrt(dist);
}



/* ------------------------------------------------------------------------------ */
/*Calcula la clase de input encontrando los knn y haciendo una votación entre estos
para predecir la clase de input
/* ------------------------------------------------------------------------------ */
int output(struct KNN *knn,float *input,struct DATOS* datos){
  int i,res;
  float distancias[datos->PR][2],dist;
  unsigned class[knn->N_Class],index;

  //Cerear arreglo de clases
  for(i=0;i<knn->N_Class;i++) class[i] = 0;

  unsigned ctos = datos->PR;
  int total = 0;
  for(i=0; i<ctos; i++){
    index = datos->seq[i];
    dist = calcularDistanciaEuclidea(input,datos->data[index],knn->N_IN);
    if (dist <= knn->distMax){
      distancias[total][0] = dist;
      distancias[total][1] = (float)datos->data[index][knn->N_IN];
      total +=1;
    }

  }



  //Sumar votos
  for(total-=1; total>=0;total--)
    class[(unsigned)distancias[total][1]] +=1 ;


  unsigned max = 0;
  bool empate = false;
  //Tomar clase con más votos
  for(i=0;i<knn->N_Class;i++){
    if(class[i] > max){
      empate = false; //Por ahora no hay empate
      max = class[i];
      index = i;
    }
    //Chequear si hay empate
    else if(class[i] == max) empate = true;
  }

  //Si hay empate retorno la clase del punto más cercano
  if(empate)
    return (unsigned)distancias[1][1];

  //Si no hay empate retorno la clase ganadora
  return index;
}
/* ------------------------------------------------------------------------------ */
/*evaluar: calcula las clases predichas para un conjunto de datos
  la matriz S tiene que tener el formato adecuado ( definido en arquitec() )
  pat_ini y pat_fin son los extremos a tomar en la matriz
  usar_seq define si se accede a los datos directamente o a travez del indice seq
  los resultados (las propagaciones) se guardan en la matriz seq                  */
/* ------------------------------------------------------------------------------ */
float evaluar(struct KNN *knn,struct DATOS *datos,float **S,int pat_ini,int pat_fin,int usar_seq){

  float mse=0.0;
  int nu;
  int patron;

  for (patron=pat_ini; patron < pat_fin; patron ++) {

   /*nu tiene el numero del patron que se va a presentar*/
    if(usar_seq) nu = datos->seq[patron];
    else         nu = patron;

    /*Calcular predicción*/
    datos->pred[nu]=output(knn,S[nu],datos);

    /*actualizar error*/
    if(S[nu][knn->N_IN]!=(float)datos->pred[nu]) mse+=1.;
  }


  mse /= ( (float)(pat_fin-pat_ini));

  if(CONTROL>3) {printf("End prop\n");fflush(NULL);}

  return mse;
}

/* --------------------------------------------------------------------------------------- */
/* Evaluar el algoritmo en el conjunto de entrenamiento, en el de validación y en el de test
 guardando los resultados
/* --------------------------------------------------------------------------------------- */
int hacerEvaluaciones(struct KNN *knn,struct DATOS *datos){

  int k,j;
  int error;
  int N_TOTAL;
  float train_error,valid_error,test_error,i,bestDist,minValidError = 1.0;
  FILE *fpredic;
  char filepat[100];



  N_TOTAL=datos->PR;//Cantidad de datos para entrenamiento

  /*efectuar shuffle inicial de los datos de entrenamiento si SEED != -1 (y hay validacion)*/
  if(knn->SEED>-1 && N_TOTAL<datos->PTOT){
    srand((unsigned)knn->SEED);
    shuffle(datos->PTOT,datos);
  }

 //Abrir archivo de errores
 char path[20];
 sprintf(path,"%s.error",datos->filename);
 FILE* ferror=fopen(path,"w");
 if(ferror == NULL){
   printf("Error al abrir el archivo de errores\n");
   return 1;
 }

 float distMax = knn->distMax;
 float delta = distMax/pow(10,3);// Término delta para hacer los incrementos
 for(i=0;i<=distMax;i+=delta){
    knn->distMax=i;
    //train_error=evaluar(knn,datos,datos->data,0,datos->PR,1);
    /*calcular error de validacion; si no hay, usar mse_train*/
    if(datos->PR==datos->PTOT) valid_error=train_error;
    else         valid_error=evaluar(knn,datos,datos->data,datos->PR,datos->PTOT,1);
    /*calcular error de test (si hay)*/
    //if (datos->PTEST>0) test_error =evaluar(knn,datos,datos->test,0,datos->PTEST,0);
    //else         test_error =0.;

    fprintf(ferror,"%f %f %f\n",train_error,valid_error,test_error);
    if(valid_error<minValidError){
      minValidError=valid_error;
      bestDist = knn->distMax;
    }
  }

  fclose(ferror);
  knn->distMax = bestDist;


  //Recalcular errores
  train_error=evaluar(knn,datos,datos->data,0,datos->PR,1);
  if(datos->PR==datos->PTOT) valid_error=train_error;
  else         valid_error=evaluar(knn,datos,datos->data,datos->PR,datos->PTOT,1);
  /*calcular error de test (si hay)*/
  if (datos->PTEST>0) test_error =evaluar(knn,datos,datos->test,0,datos->PTEST,0);
  else         test_error =0.;

  /*mostrar errores*/
  // printf("\nFin del entrenamiento: Mejor dist es %f\n\n",bestDist);
  // printf("Errores:\nEntrenamiento:%f%%\n",train_error*100.);
  // printf("Validacion:%f%%\nTest:%f%%\n",valid_error*100.,test_error*100.);
  // if(CONTROL) fflush(NULL);

  /* archivo de predicciones */
  sprintf(filepat,"%s.predic",datos->filename);
  fpredic=fopen(filepat,"w");
  error=(fpredic==NULL);
  if(error){
    printf("Error al abrir archivo para guardar predicciones\n");
    return 1;
  }
  for(k=0; k < datos->PTEST ; k++){
    for( j = 0 ;j< datos->N_IN;j++) fprintf(fpredic,"%f\t",datos->test[k][j]);
    fprintf(fpredic,"%d\n",datos->pred[k]);
  }

  fclose(fpredic);

  printf("%d %f %f\n",datos->N_IN,train_error,test_error);

  return 0;
}

/* ----------------------------------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------------------------------- */
int main(int argc, char **argv){

  /*bandera de error*/
  int error;

  if(argc!=2){
    printf("Modo de uso: nb <filename>\ndonde filename es el nombre del archivo (sin extension)\n");
    return 0;
  }

  struct KNN knn;
  struct DATOS datos;

  /* defino la estructura*/
  error=arquitec(argv[1],&knn,&datos);
  if(error){
    printf("Error en la definicion del clasificador\n");
    return 1;
  }

  /* leo los datos */
  error=read_data(argv[1],&datos);
  if(error){
    printf("Error en la lectura de datos\n");
    return 1;
  }

  /* Hacer evaluaciones*/
  error=hacerEvaluaciones(&knn,&datos);
  if(error){
    printf("Error en el entrenamiento\n");
    return 1;
  }

  return 0;

}
/* ----------------------------------------------------------------------------------------------------- */
