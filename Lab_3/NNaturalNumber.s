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
	LDR R1, =10         ; Load n = 10 (Example)
    ADD R2, R1, #1      ; Compute (n + 1)
    MOV R3, #0          ; Clear R3 (used for MLA accumulation)

    MLA R0, R1, R2, R3  ; R0 = (R1 * R2) + R3
    LSR R0, R0, #1 		; Right shifting divides by 2    
	END 
	