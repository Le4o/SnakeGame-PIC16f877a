
_reset_snake:

;Snake.c,52 :: 		void reset_snake(){
;Snake.c,53 :: 		posX = rand() / SCREEN_WIDTH + 1;
	CALL       _rand+0
	MOVLW      8
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _posX+0
;Snake.c,54 :: 		posY = rand() / SCREEN_HEIGHT + 1;
	CALL       _rand+0
	MOVLW      188
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _posY+0
;Snake.c,56 :: 		}
L_end_reset_snake:
	RETURN
; end of _reset_snake

_generate_food:

;Snake.c,58 :: 		void generate_food(){
;Snake.c,59 :: 		food[0] = rand() / SCREEN_WIDTH + 1;
	CALL       _rand+0
	MOVLW      8
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _food+0
;Snake.c,60 :: 		food[1] = rand() / SCREEN_HEIGHT + 1;
	CALL       _rand+0
	MOVLW      188
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _food+1
;Snake.c,61 :: 		Glcd_Dot( food[0], food[1], 1);
	MOVF       _food+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       R0+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Snake.c,62 :: 		}
L_end_generate_food:
	RETURN
; end of _generate_food

_initiate_screen:

;Snake.c,65 :: 		void initiate_screen(){
;Snake.c,67 :: 		Glcd_Fill(0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,68 :: 		Glcd_Write_Text("SNAKE GAME", 25, 3, 0);
	MOVLW      ?lstr2_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,69 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_initiate_screen0:
	DECFSZ     R13+0, 1
	GOTO       L_initiate_screen0
	DECFSZ     R12+0, 1
	GOTO       L_initiate_screen0
	DECFSZ     R11+0, 1
	GOTO       L_initiate_screen0
	NOP
;Snake.c,72 :: 		Glcd_Fill(0x00);       //Cor branca
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,73 :: 		generate_food();
	CALL       _generate_food+0
;Snake.c,74 :: 		endgame = 0;
	CLRF       _endgame+0
;Snake.c,75 :: 		}
L_end_initiate_screen:
	RETURN
; end of _initiate_screen

_game_over:

;Snake.c,79 :: 		void game_over(){
;Snake.c,80 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,81 :: 		reset_snake();
	CALL       _reset_snake+0
;Snake.c,82 :: 		points = 0;
	CLRF       _points+0
;Snake.c,83 :: 		points_label[8] = '0';
	MOVLW      8
	ADDWF      _points_label+0, 0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;Snake.c,84 :: 		direction = RIGHT;
	MOVLW      3
	MOVWF      _direction+0
;Snake.c,85 :: 		Glcd_Fill(0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,86 :: 		Glcd_Write_Text("FIM DE JOGO !!!", 25, 3, 0);
	MOVLW      ?lstr3_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,87 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_game_over1:
	DECFSZ     R13+0, 1
	GOTO       L_game_over1
	DECFSZ     R12+0, 1
	GOTO       L_game_over1
	DECFSZ     R11+0, 1
	GOTO       L_game_over1
;Snake.c,88 :: 		reset_snake();
	CALL       _reset_snake+0
;Snake.c,89 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,90 :: 		endgame = 1;
	MOVLW      1
	MOVWF      _endgame+0
;Snake.c,91 :: 		}
L_end_game_over:
	RETURN
; end of _game_over

_speed_test:

;Snake.c,95 :: 		void speed_test(unsigned int milliseconds)
;Snake.c,97 :: 		while(milliseconds > 0)
L_speed_test2:
	MOVF       FARG_speed_test_milliseconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__speed_test65
	MOVF       FARG_speed_test_milliseconds+0, 0
	SUBLW      0
L__speed_test65:
	BTFSC      STATUS+0, 0
	GOTO       L_speed_test3
;Snake.c,99 :: 		delay_ms(1);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_speed_test4:
	DECFSZ     R13+0, 1
	GOTO       L_speed_test4
	DECFSZ     R12+0, 1
	GOTO       L_speed_test4
	NOP
;Snake.c,100 :: 		milliseconds--;
	MOVLW      1
	SUBWF      FARG_speed_test_milliseconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_speed_test_milliseconds+1, 1
;Snake.c,101 :: 		}
	GOTO       L_speed_test2
L_speed_test3:
;Snake.c,102 :: 		}
L_end_speed_test:
	RETURN
; end of _speed_test

_snake_eat:

;Snake.c,105 :: 		void snake_eat(){
;Snake.c,106 :: 		snake_s++;
	INCF       _snake_s+0, 1
;Snake.c,107 :: 		generate_food();
	CALL       _generate_food+0
;Snake.c,108 :: 		points++;
	INCF       _points+0, 1
;Snake.c,110 :: 		points_label[7] = points / 10 + 48;
	MOVLW      7
	ADDWF      _points_label+0, 0
	MOVWF      FLOC__snake_eat+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _points+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__snake_eat+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,111 :: 		points_label[8] = points % 10 + 48;
	MOVLW      8
	ADDWF      _points_label+0, 0
	MOVWF      FLOC__snake_eat+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _points+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__snake_eat+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,112 :: 		Glcd_Write_Text( points_label, 70, 7, 1 );
	MOVF       _points_label+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      70
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      7
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,113 :: 		speed -= 5;
	MOVLW      5
	SUBWF      _speed+0, 1
	BTFSS      STATUS+0, 0
	DECF       _speed+1, 1
;Snake.c,114 :: 		}
L_end_snake_eat:
	RETURN
; end of _snake_eat

_main:

;Snake.c,118 :: 		int main() {
;Snake.c,119 :: 		TRISD = 255;
	MOVLW      255
	MOVWF      TRISD+0
;Snake.c,120 :: 		Glcd_Init ();   //Funcao do display para configuracao interna
	CALL       _Glcd_Init+0
;Snake.c,122 :: 		BEGIN:
___main_BEGIN:
;Snake.c,123 :: 		speed = 200;
	MOVLW      200
	MOVWF      _speed+0
	CLRF       _speed+1
;Snake.c,124 :: 		initiate_screen ();
	CALL       _initiate_screen+0
;Snake.c,125 :: 		Glcd_Rectangle(0,0,127,50, 1);
	CLRF       FARG_Glcd_Rectangle_x_upper_left+0
	CLRF       FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      127
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      50
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Snake.c,126 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,127 :: 		while (snake_s <= 30 && !endgame) {
L_main5:
	MOVF       _snake_s+0, 0
	SUBLW      30
	BTFSS      STATUS+0, 0
	GOTO       L_main6
	MOVF       _endgame+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main6
L__main59:
;Snake.c,129 :: 		if (PORTD.F4 == ON) { game_over (); goto BEGIN; }    //Botao de reset foi pressionado
	BTFSS      PORTD+0, 4
	GOTO       L_main9
	CALL       _game_over+0
	GOTO       ___main_BEGIN
L_main9:
;Snake.c,131 :: 		if (PORTD.F3 == ON) { direction = LEFT;}
	BTFSS      PORTD+0, 3
	GOTO       L_main10
	MOVLW      2
	MOVWF      _direction+0
L_main10:
;Snake.c,132 :: 		if (PORTD.F2 == ON) { direction = UP;}
	BTFSS      PORTD+0, 2
	GOTO       L_main11
	MOVLW      4
	MOVWF      _direction+0
L_main11:
;Snake.c,133 :: 		if (PORTD.F1 == ON) { direction = RIGHT;}
	BTFSS      PORTD+0, 1
	GOTO       L_main12
	MOVLW      3
	MOVWF      _direction+0
L_main12:
;Snake.c,134 :: 		if (PORTD.F0 == ON) { direction = BOTTOM;}
	BTFSS      PORTD+0, 0
	GOTO       L_main13
	MOVLW      5
	MOVWF      _direction+0
L_main13:
;Snake.c,136 :: 		speed_test(speed);  //Calcula a velocidade da cobra
	MOVF       _speed+0, 0
	MOVWF      FARG_speed_test_milliseconds+0
	MOVF       _speed+1, 0
	MOVWF      FARG_speed_test_milliseconds+1
	CALL       _speed_test+0
;Snake.c,138 :: 		switch (direction) {
	GOTO       L_main14
;Snake.c,141 :: 		case LEFT:
L_main16:
;Snake.c,142 :: 		posX--;
	DECF       _posX+0, 1
;Snake.c,143 :: 		if ( before_direction == RIGHT || posX < 1) { game_over(); break; }
	MOVF       _before_direction+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__main58
	MOVLW      1
	SUBWF      _posX+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main58
	GOTO       L_main19
L__main58:
	CALL       _game_over+0
	GOTO       L_main15
L_main19:
;Snake.c,144 :: 		snake [snake_s - 1][1] = posY;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       _posY+0, 0
	MOVWF      INDF+0
;Snake.c,145 :: 		snake [snake_s - 1][0] = posX;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       _posX+0, 0
	MOVWF      INDF+0
;Snake.c,146 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main20:
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Snake.c,147 :: 		snake [i][1] = snake [i+1][1];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,148 :: 		snake [i][0] = snake [i+1][0];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,146 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,149 :: 		}
	GOTO       L_main20
L_main21:
;Snake.c,150 :: 		before_direction = direction;
	MOVF       _direction+0, 0
	MOVWF      _before_direction+0
;Snake.c,151 :: 		break;
	GOTO       L_main15
;Snake.c,154 :: 		case UP:
L_main23:
;Snake.c,155 :: 		posY--;
	DECF       _posY+0, 1
;Snake.c,156 :: 		if ( before_direction == BOTTOM || posY < 1) { game_over(); break; }
	MOVF       _before_direction+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__main57
	MOVLW      1
	SUBWF      _posY+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main57
	GOTO       L_main26
L__main57:
	CALL       _game_over+0
	GOTO       L_main15
L_main26:
;Snake.c,157 :: 		snake [snake_s - 1][1] = posY;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       _posY+0, 0
	MOVWF      INDF+0
;Snake.c,158 :: 		snake [snake_s - 1][0] = posX;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       _posX+0, 0
	MOVWF      INDF+0
;Snake.c,159 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main27:
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main69:
	BTFSC      STATUS+0, 0
	GOTO       L_main28
;Snake.c,160 :: 		snake [i][1] = snake [i+1][1];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,161 :: 		snake [i][0] = snake [i+1][0];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,159 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,162 :: 		}
	GOTO       L_main27
L_main28:
;Snake.c,163 :: 		before_direction = direction;
	MOVF       _direction+0, 0
	MOVWF      _before_direction+0
;Snake.c,164 :: 		break;
	GOTO       L_main15
;Snake.c,167 :: 		case BOTTOM:
L_main30:
;Snake.c,168 :: 		posY++;
	INCF       _posY+0, 1
;Snake.c,169 :: 		if (before_direction == UP || posY > 49) { game_over(); break; }
	MOVF       _before_direction+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L__main56
	MOVF       _posY+0, 0
	SUBLW      49
	BTFSS      STATUS+0, 0
	GOTO       L__main56
	GOTO       L_main33
L__main56:
	CALL       _game_over+0
	GOTO       L_main15
L_main33:
;Snake.c,170 :: 		snake [snake_s - 1][1] = posY;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       _posY+0, 0
	MOVWF      INDF+0
;Snake.c,171 :: 		snake [snake_s - 1][0] = posX;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       _posX+0, 0
	MOVWF      INDF+0
;Snake.c,172 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main34:
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main70:
	BTFSC      STATUS+0, 0
	GOTO       L_main35
;Snake.c,173 :: 		snake [i][1] = snake [i+1][1];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,174 :: 		snake [i][0] = snake [i+1][0];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,172 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,175 :: 		}
	GOTO       L_main34
L_main35:
;Snake.c,176 :: 		before_direction = direction;
	MOVF       _direction+0, 0
	MOVWF      _before_direction+0
;Snake.c,177 :: 		break;
	GOTO       L_main15
;Snake.c,180 :: 		case RIGHT:
L_main37:
;Snake.c,181 :: 		posX++;
	INCF       _posX+0, 1
;Snake.c,182 :: 		if (before_direction == LEFT || posX > 126) { game_over(); break; }
	MOVF       _before_direction+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L__main55
	MOVF       _posX+0, 0
	SUBLW      126
	BTFSS      STATUS+0, 0
	GOTO       L__main55
	GOTO       L_main40
L__main55:
	CALL       _game_over+0
	GOTO       L_main15
L_main40:
;Snake.c,183 :: 		snake [snake_s - 1][1] = posY;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       _posY+0, 0
	MOVWF      INDF+0
;Snake.c,184 :: 		snake [snake_s - 1][0] = posX;
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       _posX+0, 0
	MOVWF      INDF+0
;Snake.c,185 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main41:
	MOVLW      1
	SUBWF      _snake_s+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main71:
	BTFSC      STATUS+0, 0
	GOTO       L_main42
;Snake.c,186 :: 		snake [i][0] = snake [i+1][0];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _SNAKE+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,187 :: 		snake [i][1] = snake [i+1][1];
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      R5+0
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,185 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,188 :: 		}
	GOTO       L_main41
L_main42:
;Snake.c,189 :: 		before_direction = direction;
	MOVF       _direction+0, 0
	MOVWF      _before_direction+0
;Snake.c,190 :: 		break;
	GOTO       L_main15
;Snake.c,192 :: 		default:
L_main44:
;Snake.c,193 :: 		break;
	GOTO       L_main15
;Snake.c,194 :: 		}
L_main14:
	MOVF       _direction+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _direction+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _direction+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _direction+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	GOTO       L_main44
L_main15:
;Snake.c,197 :: 		if (!endgame) {
	MOVF       _endgame+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;Snake.c,199 :: 		for (i = 0; i < snake_s; i++) {
	CLRF       _i+0
L_main46:
	MOVF       _snake_s+0, 0
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main47
;Snake.c,200 :: 		Glcd_Dot (snake [i][0], snake [i][1], 1);
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _SNAKE+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Snake.c,199 :: 		for (i = 0; i < snake_s; i++) {
	INCF       _i+0, 1
;Snake.c,201 :: 		}
	GOTO       L_main46
L_main47:
;Snake.c,203 :: 		Glcd_Dot (snake[0][0], snake [0][1], 0);
	MOVF       _SNAKE+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       _SNAKE+1, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	CLRF       FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Snake.c,205 :: 		if (posX == food [0] && posY == food [1]) {
	MOVF       _posX+0, 0
	XORWF      _food+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	MOVF       _posY+0, 0
	XORWF      _food+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main51
L__main54:
;Snake.c,206 :: 		snake_eat ();
	CALL       _snake_eat+0
;Snake.c,207 :: 		}
L_main51:
;Snake.c,209 :: 		}
	GOTO       L_main52
L_main45:
;Snake.c,210 :: 		else  goto BEGIN;
	GOTO       ___main_BEGIN
L_main52:
;Snake.c,212 :: 		}
	GOTO       L_main5
L_main6:
;Snake.c,214 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,215 :: 		posX = 1;
	MOVLW      1
	MOVWF      _posX+0
;Snake.c,216 :: 		posY = 1;
	MOVLW      1
	MOVWF      _posY+0
;Snake.c,217 :: 		points = 0;
	CLRF       _points+0
;Snake.c,218 :: 		direction = RIGHT;
	MOVLW      3
	MOVWF      _direction+0
;Snake.c,219 :: 		Glcd_Fill (0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,220 :: 		Glcd_Write_Text("VOC? VENCEU !!!", 25, 3, 0);
	MOVLW      ?lstr4_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,221 :: 		delay_ms(2500);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main53:
	DECFSZ     R13+0, 1
	GOTO       L_main53
	DECFSZ     R12+0, 1
	GOTO       L_main53
	DECFSZ     R11+0, 1
	GOTO       L_main53
	NOP
	NOP
;Snake.c,223 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;Snake.c,224 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
