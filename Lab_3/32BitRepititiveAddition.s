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
	LDR R0, =0x00000015  ; Load first number (R0 = 21)
    LDR R1, =0x00000010  ; Load second number (R1 = 16)

    MOV R2, #0           ; Clear upper result register (R2 = 0)
    MOV R4, R0           ; Store original multiplicand for addition

    ; Loop for repetitive addition
MULT_LOOP
    CMP R1, #0           ; Check if multiplier (R1) is 0
    BEQ DONE             ; If zero, exit loop

    ADDS R0, R0, R4      ; Add R4 to sum (R0 = R0 + R4)
    BCS INC_CARRY        ; If carry occurs, increment R2
    B CONTINUE_LOOP      ; Continue loop

INC_CARRY
    ADD R2, R2, #1       ; Increment carry (upper part of result)

CONTINUE_LOOP
    SUBS R1, R1, #1      ; Decrease R1 by 1
    BNE MULT_LOOP        ; Repeat loop until R1 == 0

DONE
    B DONE               ; Infinite loop (to halt execution)
	

    END
	