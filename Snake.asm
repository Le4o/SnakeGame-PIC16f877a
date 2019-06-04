
_reset_snake:

;Snake.c,54 :: 		void reset_snake(){
;Snake.c,55 :: 		posX = rand() / SCREEN_WIDTH + 1;
	CALL       _rand+0
	MOVLW      8
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _posX+0
;Snake.c,56 :: 		posY = rand() / SCREEN_HEIGHT + 1;
	CALL       _rand+0
	MOVLW      188
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _posY+0
;Snake.c,58 :: 		}
L_end_reset_snake:
	RETURN
; end of _reset_snake

_generate_food:

;Snake.c,60 :: 		void generate_food(){
;Snake.c,61 :: 		food[0] = rand() / SCREEN_WIDTH + 1;
	CALL       _rand+0
	MOVLW      8
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      _food+0
;Snake.c,62 :: 		food[1] = rand() / SCREEN_HEIGHT + 1;
	CALL       _rand+0
	MOVLW      188
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _food+1
;Snake.c,63 :: 		Glcd_Dot( food[0], food[1], 1);
	MOVF       _food+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       R0+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Snake.c,64 :: 		}
L_end_generate_food:
	RETURN
; end of _generate_food

_initiate_screen:

;Snake.c,67 :: 		void initiate_screen(){
;Snake.c,69 :: 		Glcd_Fill(0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,70 :: 		Glcd_Write_Text("SNAKE GAME", 25, 3, 0);
	MOVLW      ?lstr2_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,71 :: 		delay_ms(1000);
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
;Snake.c,74 :: 		Glcd_Fill(0x00);       //Cor branca
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,75 :: 		generate_food();
	CALL       _generate_food+0
;Snake.c,76 :: 		endgame = 0;
	CLRF       _endgame+0
;Snake.c,77 :: 		}
L_end_initiate_screen:
	RETURN
; end of _initiate_screen

_game_over:

;Snake.c,81 :: 		void game_over(){
;Snake.c,82 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,83 :: 		reset_snake();
	CALL       _reset_snake+0
;Snake.c,84 :: 		score = 0;
	CLRF       _score+0
;Snake.c,85 :: 		score_txt[8] = '0';
	MOVLW      8
	ADDWF      _score_txt+0, 0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;Snake.c,86 :: 		direction = 3;
	MOVLW      3
	MOVWF      _direction+0
;Snake.c,87 :: 		Glcd_Fill(0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,88 :: 		Glcd_Write_Text("FIM DE JOGO !!!", 25, 3, 0);
	MOVLW      ?lstr3_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,89 :: 		delay_ms(2000);
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
;Snake.c,90 :: 		reset_snake();
	CALL       _reset_snake+0
;Snake.c,91 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,92 :: 		endgame = 1;
	MOVLW      1
	MOVWF      _endgame+0
;Snake.c,93 :: 		}
L_end_game_over:
	RETURN
; end of _game_over

_speed_test:

;Snake.c,97 :: 		void speed_test(unsigned int milliseconds)
;Snake.c,99 :: 		while(milliseconds > 0)
L_speed_test2:
	MOVF       FARG_speed_test_milliseconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__speed_test53
	MOVF       FARG_speed_test_milliseconds+0, 0
	SUBLW      0
L__speed_test53:
	BTFSC      STATUS+0, 0
	GOTO       L_speed_test3
;Snake.c,101 :: 		delay_ms(1);
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
;Snake.c,102 :: 		milliseconds--;
	MOVLW      1
	SUBWF      FARG_speed_test_milliseconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_speed_test_milliseconds+1, 1
;Snake.c,103 :: 		}
	GOTO       L_speed_test2
L_speed_test3:
;Snake.c,104 :: 		}
L_end_speed_test:
	RETURN
; end of _speed_test

_snake_eat:

;Snake.c,107 :: 		void snake_eat(){
;Snake.c,108 :: 		snake_s++;
	INCF       _snake_s+0, 1
;Snake.c,109 :: 		generate_food();
	CALL       _generate_food+0
;Snake.c,110 :: 		score++;
	INCF       _score+0, 1
;Snake.c,112 :: 		score_txt[7] = score / 10 + 48;
	MOVLW      7
	ADDWF      _score_txt+0, 0
	MOVWF      FLOC__snake_eat+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _score+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__snake_eat+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Snake.c,113 :: 		score_txt[8] = score % 10 + 48;
	MOVLW      8
	ADDWF      _score_txt+0, 0
	MOVWF      FLOC__snake_eat+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _score+0, 0
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
;Snake.c,114 :: 		Glcd_Write_Text( score_txt, 70, 7, 1 );
	MOVF       _score_txt+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      70
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      7
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,115 :: 		speed -= 5;
	MOVLW      5
	SUBWF      _speed+0, 1
	BTFSS      STATUS+0, 0
	DECF       _speed+1, 1
;Snake.c,116 :: 		}
L_end_snake_eat:
	RETURN
; end of _snake_eat

_main:

;Snake.c,120 :: 		int main() {
;Snake.c,121 :: 		TRISD = 255;
	MOVLW      255
	MOVWF      TRISD+0
;Snake.c,122 :: 		Glcd_Init ();   //Função do display para configuração interna
	CALL       _Glcd_Init+0
;Snake.c,124 :: 		Init:
___main_Init:
;Snake.c,125 :: 		speed = 200;
	MOVLW      200
	MOVWF      _speed+0
	CLRF       _speed+1
;Snake.c,126 :: 		initiate_screen ();
	CALL       _initiate_screen+0
;Snake.c,127 :: 		Glcd_Rectangle(0,0,127,50, 1);
	CLRF       FARG_Glcd_Rectangle_x_upper_left+0
	CLRF       FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      127
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      50
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Snake.c,128 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,129 :: 		while (snake_s <= 30 && !endgame) {
L_main5:
	MOVF       _snake_s+0, 0
	SUBLW      30
	BTFSS      STATUS+0, 0
	GOTO       L_main6
	MOVF       _endgame+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main6
L__main47:
;Snake.c,131 :: 		if (PORTD.F4 == ON) { game_over (); break; }    //Botão de reset foi pressionado
	BTFSS      PORTD+0, 4
	GOTO       L_main9
	CALL       _game_over+0
	GOTO       L_main6
L_main9:
;Snake.c,133 :: 		if (PORTD.F3 == ON) direction = LEFT;
	BTFSS      PORTD+0, 3
	GOTO       L_main10
	MOVLW      2
	MOVWF      _direction+0
L_main10:
;Snake.c,134 :: 		if (PORTD.F2 == ON) direction = UP;
	BTFSS      PORTD+0, 2
	GOTO       L_main11
	MOVLW      4
	MOVWF      _direction+0
L_main11:
;Snake.c,135 :: 		if (PORTD.F1 == ON) direction = BOTTOM;
	BTFSS      PORTD+0, 1
	GOTO       L_main12
	MOVLW      5
	MOVWF      _direction+0
L_main12:
;Snake.c,136 :: 		if (PORTD.F0 == ON) direction = RIGHT;
	BTFSS      PORTD+0, 0
	GOTO       L_main13
	MOVLW      3
	MOVWF      _direction+0
L_main13:
;Snake.c,138 :: 		speed_test(speed);  //Calcula a velocidade da cobra
	MOVF       _speed+0, 0
	MOVWF      FARG_speed_test_milliseconds+0
	MOVF       _speed+1, 0
	MOVWF      FARG_speed_test_milliseconds+1
	CALL       _speed_test+0
;Snake.c,140 :: 		switch (direction) {
	GOTO       L_main14
;Snake.c,143 :: 		case LEFT:
L_main16:
;Snake.c,144 :: 		posX--;
	DECF       _posX+0, 1
;Snake.c,145 :: 		if (posX < 1) { game_over(); break;}
	MOVLW      1
	SUBWF      _posX+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main17
	CALL       _game_over+0
	GOTO       L_main15
L_main17:
;Snake.c,146 :: 		snake [snake_s - 1][1] = posY;
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
;Snake.c,147 :: 		snake [snake_s - 1][0] = posX;
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
;Snake.c,148 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main18:
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
	GOTO       L__main56
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L_main19
;Snake.c,149 :: 		snake [i][1] = snake [i+1][1];
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
;Snake.c,150 :: 		snake [i][0] = snake [i+1][0];
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
;Snake.c,148 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,151 :: 		}
	GOTO       L_main18
L_main19:
;Snake.c,152 :: 		break;
	GOTO       L_main15
;Snake.c,155 :: 		case UP:
L_main21:
;Snake.c,156 :: 		posY--;
	DECF       _posY+0, 1
;Snake.c,157 :: 		if (posY < 1) { game_over(); break; }
	MOVLW      1
	SUBWF      _posY+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main22
	CALL       _game_over+0
	GOTO       L_main15
L_main22:
;Snake.c,158 :: 		snake [snake_s - 1][1] = posY;
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
;Snake.c,159 :: 		snake [snake_s - 1][0] = posX;
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
;Snake.c,160 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main23:
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
	GOTO       L__main57
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main57:
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;Snake.c,161 :: 		snake [i][1] = snake [i+1][1];
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
;Snake.c,162 :: 		snake [i][0] = snake [i+1][0];
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
;Snake.c,160 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,163 :: 		}
	GOTO       L_main23
L_main24:
;Snake.c,164 :: 		break;
	GOTO       L_main15
;Snake.c,167 :: 		case BOTTOM:
L_main26:
;Snake.c,168 :: 		posX++;
	INCF       _posX+0, 1
;Snake.c,169 :: 		if (posX > 126) { game_over(); break;}
	MOVF       _posX+0, 0
	SUBLW      126
	BTFSC      STATUS+0, 0
	GOTO       L_main27
	CALL       _game_over+0
	GOTO       L_main15
L_main27:
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
L_main28:
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
	GOTO       L__main58
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main58:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;Snake.c,173 :: 		snake [i][0] = snake [i+1][0];
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
;Snake.c,174 :: 		snake [i][1] = snake [i+1][1];
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
;Snake.c,172 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,175 :: 		}
	GOTO       L_main28
L_main29:
;Snake.c,176 :: 		break;
	GOTO       L_main15
;Snake.c,179 :: 		case RIGHT:
L_main31:
;Snake.c,180 :: 		posY++;
	INCF       _posY+0, 1
;Snake.c,181 :: 		if (posY > 49) { game_over(); break; }
	MOVF       _posY+0, 0
	SUBLW      49
	BTFSC      STATUS+0, 0
	GOTO       L_main32
	CALL       _game_over+0
	GOTO       L_main15
L_main32:
;Snake.c,182 :: 		snake [snake_s - 1][1] = posY;
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
;Snake.c,183 :: 		snake [snake_s - 1][0] = posX;
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
;Snake.c,184 :: 		for (i = 0; i < snake_s - 1; i++) {
	CLRF       _i+0
L_main33:
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
	GOTO       L__main59
	MOVF       R1+0, 0
	SUBWF      _i+0, 0
L__main59:
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;Snake.c,185 :: 		snake [i][1] = snake [i+1][1];
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
;Snake.c,184 :: 		for (i = 0; i < snake_s - 1; i++) {
	INCF       _i+0, 1
;Snake.c,187 :: 		}
	GOTO       L_main33
L_main34:
;Snake.c,188 :: 		break;
	GOTO       L_main15
;Snake.c,190 :: 		default:
L_main36:
;Snake.c,191 :: 		break;
	GOTO       L_main15
;Snake.c,192 :: 		}
L_main14:
	MOVF       _direction+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _direction+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _direction+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _direction+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	GOTO       L_main36
L_main15:
;Snake.c,195 :: 		if (!endgame) {
	MOVF       _endgame+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;Snake.c,197 :: 		for (i = 0; i < snake_s; i++) {
	CLRF       _i+0
L_main38:
	MOVF       _snake_s+0, 0
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main39
;Snake.c,198 :: 		Glcd_Dot (snake [i][0], snake [i][1], 1);
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
;Snake.c,197 :: 		for (i = 0; i < snake_s; i++) {
	INCF       _i+0, 1
;Snake.c,199 :: 		}
	GOTO       L_main38
L_main39:
;Snake.c,201 :: 		Glcd_Dot (snake[0][0], snake [0][1], 0);
	MOVF       _SNAKE+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       _SNAKE+1, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	CLRF       FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Snake.c,203 :: 		if (posX == food [0] && posY == food [1]) {
	MOVF       _posX+0, 0
	XORWF      _food+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
	MOVF       _posY+0, 0
	XORWF      _food+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
L__main46:
;Snake.c,204 :: 		snake_eat ();
	CALL       _snake_eat+0
;Snake.c,205 :: 		}
L_main43:
;Snake.c,207 :: 		}
	GOTO       L_main44
L_main37:
;Snake.c,208 :: 		else  goto Init;
	GOTO       ___main_Init
L_main44:
;Snake.c,210 :: 		}
	GOTO       L_main5
L_main6:
;Snake.c,212 :: 		snake_s = 5;
	MOVLW      5
	MOVWF      _snake_s+0
;Snake.c,213 :: 		posX = 1;
	MOVLW      1
	MOVWF      _posX+0
;Snake.c,214 :: 		posY = 1;
	MOVLW      1
	MOVWF      _posY+0
;Snake.c,215 :: 		score = 0;
	CLRF       _score+0
;Snake.c,216 :: 		direction = 3;
	MOVLW      3
	MOVWF      _direction+0
;Snake.c,217 :: 		Glcd_Fill (0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Snake.c,218 :: 		Glcd_Write_Text("VOCÊ VENCEU !!!", 25, 3, 0);
	MOVLW      ?lstr4_Snake+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Snake.c,219 :: 		delay_ms(2500);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	DECFSZ     R11+0, 1
	GOTO       L_main45
	NOP
	NOP
;Snake.c,221 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;Snake.c,222 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
