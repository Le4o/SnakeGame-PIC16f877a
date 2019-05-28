//#include "snake_bmp.c"

#define uchar unsigned char

char GLCD_DataPort at PORTC;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS  at RB2_bit;
sbit GLCD_RW  at RB3_bit;
sbit GLCD_EN  at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;

uchar SNAKE[40][2];
uchar dir = 2;
uchar food[2], LENGTH_SNAKE = 5;
uchar posX, posY = 1;
uchar score, *score_txt = "Score: 00";
uchar i;

void criar_comida(){
  food[0] = rand()/264 + 1;
  food[1] = rand()/700 + 1;
  Glcd_Dot(food[0], food[1], 1);
}

void gameover(){
    LENGTH_SNAKE = 5;
    PosX = 1;
    PosY = 1;
    score = 0;
    score_txt[8] = '0';
    dir = 2;
    Glcd_Fill(0xFF);
    Glcd_Write_Text("GAME OVER !!!",25,3,0);
    delay_ms(1000);
}

void main() {
 TRISD = 255;
 Glcd_Init();
 //Glcd_Image(snake_img);
 delay_ms(4000);
 Inicio:
 Glcd_Fill(0x00);
 criar_comida();

 for(i=0;i<5;i++){
  Glcd_Dot(i,0,1);
 }

 Glcd_Rectangle(0,0,127,50, 1);
 Glcd_Write_Text(score_txt,0,7,1);

 while(1){
  if(PORTD.F0==1)  dir = 3;
  if(PORTD.F1==1)  dir = 2;
  if(PORTD.F2==1)  dir = 1;
  if(PORTD.F3==1)  dir = 0;

  if(PORTD.F4==1){
   gameover();
   goto Inicio;
  }

  //para baixo
  if(dir==2){
   PosX++;
   if(PosX>126){ gameOver(); goto Inicio; }
   SNAKE[LENGTH_SNAKE - 1][0] = PosX;
   SNAKE[LENGTH_SNAKE - 1][1] = PosY;
   for(i=0; i<length_snake - 1; i++){
     SNAKE[i][0] = SNAKE[i+1][0];
     SNAKE[i][1] = SNAKE[i+1][1];
     }
  }

  //para direita
  if(dir==3){
   PosY++;
   if(PosY>49){ gameOver(); goto Inicio; }
   SNAKE[LENGTH_SNAKE - 1][1] = PosY;
   SNAKE[LENGTH_SNAKE - 1][0] = PosX;
   for(i=0; i<length_snake - 1; i++){
     SNAKE[i][1] = SNAKE[i+1][1];
     SNAKE[i][0] = SNAKE[i+1][0];
     }
  }

  //para cima
  if(dir==1){
   PosY--;
   if(PosY<1){ gameOver(); goto Inicio; }
   SNAKE[LENGTH_SNAKE - 1][1] = PosY;
   SNAKE[LENGTH_SNAKE - 1][0] = PosX;
   for(i=0; i<LENGTH_SNAKE - 1; i++){
     SNAKE[i][1] = SNAKE[i+1][1];
     SNAKE[i][0] = SNAKE[i+1][0];

   }
  }

  //para esquerda
  if(dir==0){
   PosX--;
   if(PosX<1){ gameOver(); goto Inicio; }
   SNAKE[LENGTH_SNAKE - 1][0] = PosX;
   SNAKE[LENGTH_SNAKE - 1][1] = PosY;
   for(i=0; i<LENGTH_SNAKE - 1; i++){
     SNAKE[i][1] = SNAKE[i+1][1];
     SNAKE[i][0] = SNAKE[i+1][0];

   }
  }

  //desenha a cobra
  for(i=0;i<LENGTH_SNAKE;i++){
   Glcd_Dot(SNAKE[i][0], SNAKE[i][1], 1);
  }

  Glcd_Dot(SNAKE[0][0], SNAKE[0][1], 0);//limpa o rastro deixado pela cobra

  //caso encontrar a comida
  if(PosX==food[0] && PosY==food[1]){
   LENGTH_SNAKE++;
   if(LENGTH_SNAKE>=38){//caso voce chegue ao nivel maximo
    LENGTH_SNAKE=5;
    PosX = 1;
    PosY = 1;
    score = 0;
    dir = 2;
    Glcd_Fill(0xFF);
    Glcd_Write_Text("VOCE GANHOU !!!",25,3,0);
    delay_ms(2000);
    goto Inicio;
   }
   criar_comida();
   score++;
   score_txt[7] = score/10 + 48;
   score_txt[8] = score%10 + 48;
   Glcd_Write_Text(score_txt, 0,7,1);
   }

  for(i = 0; i<450/LENGTH_SNAKE; i++){
   delay_ms(1);
  }
 }
}