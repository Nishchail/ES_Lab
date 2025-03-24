

	AREA RESET, DATA, READONLY
	EXPORT __Vectors

__Vectors
	
	DCD 0x1001000
	DCD Reset_Handler
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler

Reset_Handler
	
	LDR R0,=N1
	LDR R1,=N2
	LDR R2,[R0]
	LDR R3,[R1]
	LDR R4, =result
	MOV R5 ,#0

LOOP
	ADD R5,R5,R2
	SUBS R3,R3,#1
	BNE LOOP
	
	STR R5,[R4]
	
N1 DCD 10
N2 DCD 5

	AREA mydata, DATA, READWRITE
result DCD 0
		
	END
		