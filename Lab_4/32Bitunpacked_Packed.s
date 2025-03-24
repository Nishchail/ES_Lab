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
    LDR R0, =UNPACKED   ; Load the address of unpacked bytes
    LDR R1, =PACKED     ; Load the address to store the packed value

    LDRB R2, [R0], #1   ; Load first byte (0x12) and increment pointer
    LSL R2, R2, #24     ; Shift left by 24 bits

    LDRB R3, [R0], #1   ; Load second byte (0x34)
    LSL R3, R3, #16     ; Shift left by 16 bits
    ORR R2, R2, R3      ; Combine with previous result

    LDRB R4, [R0], #1   ; Load third byte (0x56)
    LSL R4, R4, #8      ; Shift left by 8 bits
    ORR R2, R2, R4      ; Combine with previous result

    LDRB R5, [R0]       ; Load fourth byte (0x78)
    ORR R2, R2, R5      ; Combine with previous result

    STR R2, [R1]        ; Store packed 32-bit number at PACKED memory location

	
UNPACKED DCB 0x12, 0x34, 0x56, 0x78  ; Unpacked bytes

    AREA mydata, DATA, READWRITE

PACKED   DCD 0                       ; Memory space for packed result

    END
