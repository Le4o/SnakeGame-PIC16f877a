#line 1 "C:/Users/junin/Desktop/SnakeGame/Snake.c"
#line 25 "C:/Users/junin/Desktop/SnakeGame/Snake.c"
char GLCD_DataPort at PORTC;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS at RB2_bit;
sbit GLCD_RW at RB3_bit;
sbit GLCD_EN at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;




 unsigned char  direction = 3;
 unsigned char  SNAKE[40][2];
 unsigned char  endgame= 0;
 unsigned char  food[2], snake_s = 5;
 unsigned char  posX = 5, posY = 5;
 unsigned char  score, *score_txt = "Score: 00";
 unsigned char  i;
unsigned int speed = 200;


void reset_snake(){
 posX = rand() /  264  + 1;
 posY = rand() /  700  + 1;

}

void generate_food(){
 food[0] = rand() /  264  + 1;
 food[1] = rand() /  700  + 1;
 Glcd_Dot( food[0], food[1], 1);
}


void initiate_screen(){

 Glcd_Fill(0xFF);
 Glcd_Write_Text("SNAKE GAME", 25, 3, 0);
 delay_ms(1000);


 Glcd_Fill(0x00);
 generate_food();
 endgame = 0;
}



void game_over(){
 snake_s = 5;
 reset_snake();
 score = 0;
 score_txt[8] = '0';
 direction = 3;
 Glcd_Fill(0xFF);
 Glcd_Write_Text("FIM DE JOGO !!!", 25, 3, 0);
 delay_ms(2000);
 reset_snake();
 Glcd_Fill(0x00);
 endgame = 1;
}



void speed_test(unsigned int milliseconds)
 {
 while(milliseconds > 0)
 {
 delay_ms(1);
 milliseconds--;
 }
 }


void snake_eat(){
 snake_s++;
 generate_food();
 score++;

 score_txt[7] = score / 10 + 48;
 score_txt[8] = score % 10 + 48;
 Glcd_Write_Text( score_txt, 70, 7, 1 );
 speed -= 5;
}



int main() {
 TRISD = 255;
 Glcd_Init ();

 Init:
 speed = 200;
 initiate_screen ();
 Glcd_Rectangle(0,0,127,50, 1);
 snake_s = 5;
 while (snake_s <= 30 && !endgame) {

 if (PORTD.F4 ==  1 ) { game_over (); break; }

 if (PORTD.F3 ==  1 ) direction =  2 ;
 if (PORTD.F2 ==  1 ) direction =  4 ;
 if (PORTD.F1 ==  1 ) direction =  5 ;
 if (PORTD.F0 ==  1 ) direction =  3 ;

 speed_test(speed);

 switch (direction) {


 case  2 :
 posX--;
 if (posX < 1) { game_over(); break;}
 snake [snake_s - 1][1] = posY;
 snake [snake_s - 1][0] = posX;
 for (i = 0; i < snake_s - 1; i++) {
 snake [i][1] = snake [i+1][1];
 snake [i][0] = snake [i+1][0];
 }
 break;


 case  4 :
 posY--;
 if (posY < 1) { game_over(); break; }
 snake [snake_s - 1][1] = posY;
 snake [snake_s - 1][0] = posX;
 for (i = 0; i < snake_s - 1; i++) {
 snake [i][1] = snake [i+1][1];
 snake [i][0] = snake [i+1][0];
 }
 break;


 case  5 :
 posX++;
 if (posX > 126) { game_over(); break;}
 snake [snake_s - 1][1] = posY;
 snake [snake_s - 1][0] = posX;
 for (i = 0; i < snake_s - 1; i++) {
 snake [i][0] = snake [i+1][0];
 snake [i][1] = snake [i+1][1];
 }
 break;


 case  3 :
 posY++;
 if (posY > 49) { game_over(); break; }
 snake [snake_s - 1][1] = posY;
 snake [snake_s - 1][0] = posX;
 for (i = 0; i < snake_s - 1; i++) {
 snake [i][1] = snake [i+1][1];
 snake [i][0] = snake [i+1][0];
 }
 break;

 default:
 break;
 }


 if (!endgame) {

 for (i = 0; i < snake_s; i++) {
 Glcd_Dot (snake [i][0], snake [i][1], 1);
 }

 Glcd_Dot (snake[0][0], snake [0][1], 0);

 if (posX == food [0] && posY == food [1]) {
 snake_eat ();
 }

 }
 else goto Init;

 }

 snake_s = 5;
 posX = 1;
 posY = 1;
 score = 0;
 direction = 3;
 Glcd_Fill (0xFF);
 Glcd_Write_Text("VOCÊ VENCEU !!!", 25, 3, 0);
 delay_ms(2500);

 return 0;
}
