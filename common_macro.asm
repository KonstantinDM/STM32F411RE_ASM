   MACRO	             ; start macro definition
$label MOVLo $p1,$p2
      MOVW $p1,$p2
   MEND               ; end macro definition

   MACRO	             ; start macro definition
$label MOVUp $p1,$p2
      MOVT $p1,$p2
   MEND               ; end macro definition

   MACRO	             ; start macro definition
$label CALL $p1
      BL $p1
   MEND               ; end macro definition

   MACRO	             ; start macro definition
      RET
      BX LR
   MEND               ; end macro definition

   MACRO	             ; start macro definition
$label JMP $p1
      B $p1
   MEND               ; end macro definition

 END