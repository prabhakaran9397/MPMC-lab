.MODEL SMALL

.STACK 100H

.DATA
	STRING	DB 20H, ?, 20H DUP('$')
	REVSTR	DB 20H DUP('$')
	NL	DB 0DH, 0AH, '$'
	PROMPT	DB 'ENTER THE STRING TO CHECK IF ITS PALINDROME: $'
	PALIN	DB 'YES! PALINDROME$'
	NOPAL	DB 'NO! NOT A PALAINDROME$'

.CODE
BEGIN:
	MOV AX, @DATA
	MOV DS, AX

	LEA DX, PROMPT		; PRINT PROMPT
	MOV AH, 09H
	INT 21H

	LEA DX, STRING		; SCAN STRING
	MOV AH, 0AH
	INT 21H

;APPEND $ IN FRONT AND BACK OF STRING
	LEA SI, STRING+1	; LENGTH OF STRING IS STORED
	MOV CL, [SI]
	MOV CH, 0H
	MOV AL, '$'
	MOV [SI], AL		
	INC CX
	ADD SI, CX
	MOV [SI], AL
	DEC CX			; CX WILL HAVE LENGTH OF THE STRING

	LEA SI, STRING+1
	ADD SI, CX
	LEA DI, REVSTR

COPY:
	MOV BL, [SI]		; REVERSE COPY
	MOV [DI], BL
	INC DI
	DEC SI
	CMP BL, AL
	JNE COPY

	LEA DX, NL		; PRINT NEWLINE
	MOV AH, 09H
	INT 21H

	LEA SI, STRING+2
	LEA DI, REVSTR
PALCOMPARE:	
	DEC CX
	JZ YESPAL
	MOV AH, [SI]
	MOV BH, [DI]
	CMP AH, BH
	JE PALCOMPARE
	JNE NOTPAL

YESPAL:
	LEA DX, PALIN		; PRINT YES PALINDROME
	MOV AH, 09H
	INT 21H
	JMP OUT

NOTPAL:
	LEA DX, NOPAL		; PRINT NOT PALINDROME
	MOV AH, 09H
	INT 21H

OUT:
	MOV AH, 4CH
	INT 21H	
END BEGIN
