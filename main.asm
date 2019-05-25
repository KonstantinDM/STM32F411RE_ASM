 INCLUDE common_macro.asm
 INCLUDE ports.asm
 INCLUDE rcc.asm

STACK_TOP EQU 0x20000100

    PRESERVE8
    THUMB
            
    AREA RESET, CODE, READONLY

    ; Таблица векторов прерываний
    DCD STACK_TOP ; Указатель на вершину стека
    DCD Start     ; Вектор сброса

    ENTRY

; Начало программы
Start    PROC

      MOV32 R0, RCC_EN_GPIOC_BB ; Разрешить тактирование PORTС
      MOV   R1, #1
      STR   R1, [R0]
      
      ; Подтянем 1 пин к верху
      MOV32 R0, GPIOC_PUPDR
      MOV   R1, #(GPIO_MODE_PP_PU << 2)
      STR   R1, [R0]

      ; Пин 0 на выход и пин 1 на вход
      MOV32 R0, GPIOC_MODER
      MOV   R1, #GPIO_MODE_OUT :OR: (GPIO_MODE_IN << 2)
      STR   R1, [R0]

      MOV32 R2, GPIOC_OUT_PIN_0_BB	; Выходной порт светодиодов
   ENDP

; Мигание
Blink    PROC

      MOV   R1, #1	; Переключить светодиоды
      STR   R1, [R2]

      CALL Pause

      MOV   R1, #0   ; Переключить светодиоды
      STR   R1, [R2]

      CALL Pause

      JMP Blink
   ENDP

; Пауза
Pause    PROC
      
      MOV32 R0, #5333333 ; Почти 1 секунда на частоте 16 мгц (16млн / 3)
gcd
      SUBS  R0, R0, #1
      BNE   gcd
      RET
   ENDP 

 END
