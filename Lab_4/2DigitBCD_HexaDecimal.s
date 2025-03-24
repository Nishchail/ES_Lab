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
    LDR R0, =BCD_NUM      ; Load the address of the BCD number
    LDRB R0, [R0]         ; Load the BCD number into R0

    AND R1, R0, #0xF0     ; Mask upper nibble (e.g., 0x20 from 0x25)
	LSR R1, R1, #4        ; Shift right to get decimal value (e.g., 2 from 0x20)

    AND R2, R0, #0x0F     ; Mask lower nibble (e.g., 0x05 from 0x25)

	MOV R3, #10           ; Load 10 into R3
    MUL R1, R1, R3        ; Multiply upper digit by 10 (e.g., 2 * 10 = 20)
    ADD R1, R1, R2        ; Add lower digit (e.g., 20 + 5 = 25 in decimal or 0x19 in hex)

    LDR R4, =HEX_RESULT   ; Load address to store the result
    STRB R1, [R4]         ; Store converted hex value

BCD_NUM    DCB 0x25        ; Example BCD input (25 BCD = 0x19 Hex)
    AREA mydata, DATA, READWRITE

HEX_RESULT DCB 0           ; Memory location for output

    END
