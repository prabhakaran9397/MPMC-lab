	   LXI H,4300
	   MOV E,M
	   INX H
	   MVI B,00
	   MVI C,00
	   MVI D,00

EACH:	   MOV A,M
	   INX H
	   CPI 00
	   JZ ZER
	   ANI 80
	   JNZ NEG
	   JMP POS

BACK:	   DCR E
	   JNZ EACH
	   MOV A,B
           STA 4200
           MOV A,C
           STA 4201
           MOV A,D
           STA 4202
           HLT

ZER:	   INR B
	   JMP BACK

NEG:	   INR C
	   JMP BACK

POS:	   INR D
	   JMP BACK
