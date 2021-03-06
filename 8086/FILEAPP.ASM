.MODEL SMALL

.STACK 100H

.DATA
	FILENAME DB 'TESTFILE.TXT', 0H
	WRITVAL DB 80H DUP('$'), 0H
	READVAL DB 80H DUP('$'), 0H
	NEWLINE DB 0DH, 0AH, '$', 0H
	HANDLE DW ?, 0H

.CODE
BEGIN:	MOV AX, @DATA
	MOV DS, AX
;;;;;;;;;;;;;;;;;;;;;;;	OPEN THE FILE IN READ & WRITE MODE
	LEA DX, FILENAME
	MOV CX, 0000H
	MOV AX, 3D02H
	INT 21H
	MOV HANDLE, AX
;;;;;;;;;;;;;;;;;;;;;;; READ FROM THE FILE
	LEA DX, READVAL
	MOV CX, 0FFFFH
	MOV BX, HANDLE
	MOV AX, 3F00H
	INT 21H
;;;;;;;;;;;;;;;;;;;;;;; FIND THE LENGTH
	MOV DI, 0000H
	LEA SI, READVAL
	MOV AL,	'$'
DO:	CMP [SI], AL
	JE DONE
	INC DI
	INC SI
	JMP DO
DONE:	DEC DI
;;;;;;;;;;;;;;;;;;;;;;; SEEK TILL THE END OF FILE
	MOV DX, DI
	MOV CX, 0000H
	MOV BX, HANDLE
	MOV AX, 4200H
	INT 21H
;;;;;;;;;;;;;;;;;;;;;;; GET INPUT TO WRITE
	LEA DX, WRITVAL
	MOV AH, 0AH
	INT 21H
;;;;;;;;;;;;;;;;;;;;;;; WRITE IN THE FILE
	LEA DX, WRITVAL+2
	LEA SI, WRITVAL+1
	MOV CL, [SI]
	MOV CH, 0H
	INC CX
	ADD [SI], CX
	MOV AL, '$'
	MOV [SI], AL
	INC CX
	MOV BX, HANDLE
	MOV AX, 4000H
	INT 21H
;;;;;;;;;;;;;;;;;;;;;;; CLOSE THE FILE
	MOV BX, HANDLE
	MOV AH, 3EH
	INT 21H
;;;;;;;;;;;;;;;;;;;;;;;
	MOV AH, 4CH
	INT 21H
END BEGIN
