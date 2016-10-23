	   LXI H,4300
	   MOV E,M
	   INX H
	   MVI B,00
	   MVI C,00

EACH:	   MOV A,M
	   INX H
	   ANI 01
	   JNZ ODD
	   JMP EVE

BACK:	   DCR E
	   JNZ EACH
	   MOV A,B
	   STA 4200
	   MOV A,C
	   STA 4201
	   HLT

ODD:	   INR B
	   JMP BACK

EVE:	   INR C
	   JMP BACK
