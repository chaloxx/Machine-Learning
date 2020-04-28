#include <stdio.h>
#include <string.h>



#define TAM 126
#define TAM2 150
#define BUFF_SIZE 30

int main(int argc,char** argv){
  printf("%s,",argv[2]);
  FILE* fptr = fopen(argv[1],"r");
  fseek(fptr,-TAM,SEEK_END);
  char ch = fgetc(fptr);
  char data1[BUFF_SIZE], data2[BUFF_SIZE];
  int i = 0;
  // Parsear el test error
  for(;ch != '<' && i < BUFF_SIZE;i++){
    data1[i] = ch;
    ch = fgetc(fptr);
  }
  data1[i] = '\0';
  // i = 0;
  fseek(fptr,-TAM2,SEEK_END);
  ch = fgetc(fptr);
  // // Parsear el training error
  for(i=0;ch != ')' && i < BUFF_SIZE;i++){
    data2[i] = ch;
    ch = fgetc(fptr);
  }
  data2[i] = '\0';
  int j = 0;
  // // Escribir test error before pruning
  for(i = 0;data2[i] != '(';i++);
  for(++i;data2[i] == ' ';i++);
  for(j=i;data2[j] != '%';j++);
  data2[j] = '\0';
  printf("%s,",data2+i);
  // //Escribir test error after pruning
  for(i = 0;data1[i] != '(';i++);
  for(++i;data1[i] == ' ';i++);
  for(j = i;data1[j] != '%';j++);
  data1[j] = '\0';
  printf("%s\n",data1+i);
}
