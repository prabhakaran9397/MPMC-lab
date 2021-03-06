.MODEL SMALL
.STACK 100H
.DATA
	STRING	DB 10H, ?, 10H DUP('$')
	NL	DB 0AH, '$'
.CODE
BEGIN:
	MOV AX, @DATA			; INITIALISE
	MOV DS, AX			

	MOV DX, OFFSET STRING		; SCAN		
	MOV AH, 0AH			
	INT 21H		

	MOV SI, OFFSET STRING+1		; LENGTH
	MOV CL, [SI]
	MOV CH, 0
	INC CX
	ADD SI, CX
	MOV [SI], '$' 			; REMOVING NEWLINE FROM STRING

	MOV DX, OFFSET NL		; PRINT NEWLINE
	MOV AH, 09H					
	INT 21H

	MOV DX, OFFSET STRING+2		; PRINT 
	MOV AH, 09H					
	INT 21H

	MOV AH, 4CH			; RETURN
	INT 21H				
END BEGIN

