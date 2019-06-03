// ***********************************//
// Snake Game                         //     
// Sistemas Microprocessados I        //
//                                    //
// Alfonso Martinez                   //
// Leonardo Andrade                   //
// ***********************************//

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define SCREEN_WIDTH 264
#define SCREEN_HEIGHT 700
#define OFF 0
#define ON 1
#define LEFT 2
#define RIGHT 3
#define UP 4
#define BOTTOM 5

//Configuração das portas de acordo com o padrão do display
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

//Variáveis 
unsigned char snake [40][2];                        // Matriz para guardar a "imagem" da snake
unsigned char direction = 2;                        // Direção inicial para saída da snake
unsigned char food[2];                              // Vetor de posição da comida
unsigned char posX;                                 // Snake começa em uma posição aleatória
unsigned char posY;                                 //
unsigned char score, *txt_score = "Pontos: 00";     // Texto para display
unsigned char snake_s = 5;                          // Valor padrão do tamanho da cauda
unsigned char ind;

void reset_snake () {
    posX = rand () / SCREEN_WIDTH + 1;    
    posY = rand () / SCREEN_HEIGHT + 1;
}

//Gera um ponto na tela jogável para servir de comida
void generate_food () {
    short x;
    food[0] = rand () / SCREEN_WIDTH + 1;
    food[1] = rand () / SCREEN_HEIGHT + 1;       
    Glcd_Dot (food[0], food[1], 1);             
}

//Função que reseta as variavéis ao fim de jogo
void game_over () {
    snake_s = 5 //Tamanho padrão da snake
    reset_snake ();
    score = 0;
    txt_score[8] = '0';
    direction = 2;
    Glcd_Fill (0xFF);
    Glcd_Write_Text ("FIM DE JOGO !!!", 25, 3, 0);
    delay_ms (600);

    initiate_screen (); //Começa o jogo de novo
}

void initiate_screen () {

    //Nome inicial
    Glcd_Fill (0xFF);    //Cor preta
    Glcd_Write_Text ("SNAKE GAME", 25, 3, 0);
    delay_ms (1000);

    //Jogo inicia
    Glcd_Fill (0x00);    //Cor branca
    generate_food ();

    Glcd_Write_Text (txt_score, 0, 7, 1);
}

int main () {

    TRISD = 255;
    Glcd_Init ();   //Função do display para configuração interna

    initiate_screen ();

    while (snake_s <= 30) {
        
        if (PORTD.F4 == ON) { game_over (); break; }    //Botão de reset foi pressionado

        if (PORTD.F3 == ON) direction = LEFT;
        if (PORTD.F2 == ON) direction = UP;
        if (PORTD.F1 == ON) direction = BOTTOM;
        if (PORTD.F0 == ON) direction = RIGHT;

        switch (direction) {
        
            case LEFT:
                posX++;
                if (posX > 126) { game_over(); break;}
                snake [snake_s - 1][1] = posY;
                
                break;
            
            case UP:
        
                break;

            case BOTTOM:
        
                break;

            case RIGHT:
        
                break;

            default:
                break;
            }
        
    }

    return 0;
}
