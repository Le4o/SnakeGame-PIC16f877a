
//----------------------------------------//
// EQUIPE: ALFONSO MARTINEZ E             //
// LEONARDO SANTANA                       //
//                                        //
//  MICROPROCESSADOR: PIC16F877A          //
//                                        //
//  CLOCK: 16MHZ                          //
//                                        //
//   SNAKE GAME                           //
//                                        //
//----------------------------------------//

#define SCREEN_WIDTH 264
#define SCREEN_HEIGHT 700
#define OFF 0
#define ON 1
#define LEFT 2
#define RIGHT 3
#define UP 4
#define BOTTOM 5

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

//Variaveis

unsigned char direction = RIGHT;
unsigned char SNAKE[35][2];
unsigned char endgame= 0;
unsigned char food[2], snake_s = 5;
unsigned char posX = 5, posY = 5;
unsigned char points, *points_label = "Pontos:00";
unsigned char i;
unsigned char before_direction;
unsigned int speed = 200;

//Funcaoo para resetar a cobra em uma posicaoo aleatoria do display
void reset_snake(){
     posX = rand() / SCREEN_WIDTH + 1;
     posY = rand() / SCREEN_HEIGHT + 1;

}
//Funcao que gera uma comida na tela
void generate_food(){
     food[0] = rand() / SCREEN_WIDTH + 1;
     food[1] = rand() / SCREEN_HEIGHT + 1;
     Glcd_Dot( food[0], food[1], 1);
}

//Funcaoo para setar as configs inicias para inicar o jogo
void initiate_screen(){
     //Nome inicial
     Glcd_Fill(0xFF);
     Glcd_Write_Text("SNAKE GAME", 25, 3, 0);
     delay_ms(1000);

     //Jogo inicia
     Glcd_Fill(0x00);       //Cor branca
     generate_food();
     endgame = 0;
}

//Função que e chamada quando o player perde
//Reseta todos os atributos e printa na tela a mensagem de derrota
void game_over(){
     snake_s = 5;
     reset_snake();
     points = 0;
     points_label[8] = '0';
     direction = RIGHT;
     Glcd_Fill(0xFF);
     Glcd_Write_Text("FIM DE JOGO !!!", 25, 3, 0);
     delay_ms(2000);
     reset_snake();
     Glcd_Fill(0x00);
     endgame = 1;
}


// Funcao que sera usada como calculo de velocidade da cobrinha
void speed_test(unsigned int milliseconds)
 {
   while(milliseconds > 0)
   {
       delay_ms(1);
      milliseconds--;
    }
 }

//Funcao que e chamada quando a cobra come
void snake_eat(){
     snake_s++;
     generate_food();
     points++;

     points_label[7] = points / 10 + 48;
     points_label[8] = points % 10 + 48;
     Glcd_Write_Text( points_label, 70, 7, 1 );
     speed -= 5;
}



int main() {
    TRISD = 255;
    Glcd_Init ();   //Funcao do display para configuracao interna

    BEGIN:
    speed = 200;
    initiate_screen ();
    Glcd_Rectangle(0,0,127,50, 1);
    snake_s = 5;
    while (snake_s <= 30 && !endgame) {

        if (PORTD.F4 == ON) { game_over (); goto BEGIN; }    //Botao de reset foi pressionado

        if (PORTD.F3 == ON) { direction = LEFT;}
        if (PORTD.F2 == ON) { direction = UP;}
        if (PORTD.F1 == ON) { direction = RIGHT;}
        if (PORTD.F0 == ON) { direction = BOTTOM;}

        speed_test(speed);  //Calcula a velocidade da cobra

        switch (direction) {

            //Direcao para esquerda
            case LEFT:
                posX--;
                if ( before_direction == RIGHT || posX < 1) { game_over(); break; }
                snake [snake_s - 1][1] = posY;
                snake [snake_s - 1][0] = posX;
                for (i = 0; i < snake_s - 1; i++) {
                    snake [i][1] = snake [i+1][1];
                    snake [i][0] = snake [i+1][0];
                }
                before_direction = direction;
                break;

            //Direcao para cima
            case UP:
                posY--;
                if ( before_direction == BOTTOM || posY < 1) { game_over(); break; }
                snake [snake_s - 1][1] = posY;
                snake [snake_s - 1][0] = posX;
                for (i = 0; i < snake_s - 1; i++) {
                    snake [i][1] = snake [i+1][1];
                    snake [i][0] = snake [i+1][0];
                }
                before_direction = direction;
                break;

            //Direcao para baixo
            case BOTTOM:
                posY++;
                if (before_direction == UP || posY > 49) { game_over(); break; }
                snake [snake_s - 1][1] = posY;
                snake [snake_s - 1][0] = posX;
                for (i = 0; i < snake_s - 1; i++) {
                    snake [i][1] = snake [i+1][1];
                    snake [i][0] = snake [i+1][0];
                }
                before_direction = direction;
                break;

            //Direcao para direita
            case RIGHT:
                 posX++;
                if (before_direction == LEFT || posX > 126) { game_over(); break; }
                snake [snake_s - 1][1] = posY;
                snake [snake_s - 1][0] = posX;
                for (i = 0; i < snake_s - 1; i++) {
                    snake [i][0] = snake [i+1][0];
                    snake [i][1] = snake [i+1][1];
                }
                before_direction = direction;
                break;

            default:
                break;
            }

            // Caso o jogo nao tenha acabado, ele continua a desenha a cobra
            if (!endgame) {
                              //Desenha a snake
              for (i = 0; i < snake_s; i++) {
                  Glcd_Dot (snake [i][0], snake [i][1], 1);
              }

              Glcd_Dot (snake[0][0], snake [0][1], 0);

              if (posX == food [0] && posY == food [1]) {
                  snake_eat ();
              }

            }
            else  goto BEGIN;

    }
    //Jogador completa 30 pontos
    snake_s = 5;
    posX = 1;
    posY = 1;
    points = 0;
    direction = RIGHT;
    Glcd_Fill (0xFF);
    Glcd_Write_Text("VOC? VENCEU !!!", 25, 3, 0);
    delay_ms(2500);

    return 0;
}
