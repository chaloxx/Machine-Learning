#include <stdio.h>
#include <string.h>

#define TAM 126
#define TAM2 360

int main(int argc,char** argv){
  printf("%s,",argv[2]);
  FILE* fptr = fopen(argv[1],"r");
  char ch = fgetc(fptr);
  char data1[30], data2[30];
  fseek(fptr,-TAM,SEEK_END);
  int i = 0;
  // Parsear el test error
  while(ch != '<'){
    data1[i] = ch;
    i++;
    ch = fgetc(fptr);
  }
  data1[i] = '\0';
  i = 0;
  fseek(fptr,-TAM2,SEEK_END);
  ch = fgetc(fptr);
  // Parsear el training error
  while(ch != '<'){
    data2[i] = ch;
    i++;
    ch = fgetc(fptr);
  }
  fclose(fptr);
  char* token = NULL;
  //Escribir cantidad de nodos
  token = strtok(data2," ");
  printf("%s,",token);
  //Escribir training error
  token = strtok(data2," ");
  int j = 0;
  for(i = 0;token[i] != '(';i++);
  i++;
  for(;token[i] == ' ';i++);
  for(j = i;token[j] != '%';j++);
  token[j] = '\0';
  printf("%s,",token+i);
  //Escribir test error
  for(i = 0;data1[i] != '(';i++);
  i++;
  for(;data1[i] == ' ';i++);
  for(j = i;data1[j] != '%';j++);
  data1[j] = '\0';
  printf("%s\n",data1+i);
}
