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
	LDR R0 , =ARRAY
	LDR R1 , =LENGTH 
	LDR R1 ,[R1]
	MOV R2, #0 
	MOV R11 , #4
	
OUTER 
	CMP R2 , R1  ; WHETHER I < LENGTH 
	BHI DONE  ; IF I > LENGTH -> EXIT 
	
	MOV R3 , R2  ; STORING MINIDX = I 
	ADD R4 ,R2, #1  ; J = I + 1 
	
INNER 
	CMP R4 , R1  ; WHETHER J < LENGTH 
	BHS SWAP ; IF YES -> GO BACK TO OUTER 
	
	MUL R7 , R3 , R11 ; GETTING THE MINIDX OFFSET FOR ARRAY 
	LDR R5 , [R0 , R7] ;  MOVING THAT PARTICULAR VALUE IN REGISTER 
	
	MUL R8 , R4 , R11 ; GETTING THE OFFSET VALUE 
	LDR R6 , [R0 , R8] ; MOVING THE VALUE WE GOT FROM OFFSET INTO R6
	
	CMP R6 , R5  ; NOW COMPARING BOTH THESE VALUES 
	BHS SKIP ; 
	
	MOV R3 , R4 ; MINIDX = J 
	
SKIP
	ADD R4 , R4 , #1 ; J = J +1
	B INNER 

SWAP
	CMP R3, R2
	BEQ NEXT 
	
	MUL R9, R3, R11    ; Offset for minIndex
    LDR R5, [R0, R9]   ; Load array[minIndex]

    MUL R10, R2, R11    ; Offset for i
    LDR R6, [R0, R10]  ; Load array[i]
	
	STR R6, [R0, R9]   ; array[minIndex] = array[i]
    STR R5, [R0, R10]  ; array[i] = array[minIndex]
	
NEXT 
	ADD R2 , R2 , #1
	B OUTER

DONE 
	B DONE 
	
ARRAY   DCD 50, 20, 40, 10, 30  ; Unsorted array
LENGTH DCD 5 
	END 
	 