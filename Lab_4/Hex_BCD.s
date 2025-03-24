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
    LDR R0, =HEX_NUM      ; Load the address of the hex number
    LDRB R0, [R0]         ; Load the hex number into R0

    ; Step 1: Extract Hundreds Digit (HEX / 100)
    MOV R1, R0            ; Copy original hex number
    MOV R2, #100          ; Load 100 into R2
    UDIV R3, R1, R2       ; R3 = R1 / 100 (Get hundreds place)
    MUL R4, R3, R2        ; R4 = R3 * 100 (Get back subtracted part)
    SUB R1, R1, R4        ; R1 = R1 - (hundreds * 100)

    ; Step 2: Extract Tens Digit ((HEX % 100) / 10)
    MOV R2, #10           ; Load 10 into R2
    UDIV R5, R1, R2       ; R5 = R1 / 10 (Get tens place)
    MUL R4, R5, R2        ; R4 = R5 * 10 (Get back subtracted part)
    SUB R1, R1, R4        ; R1 = R1 - (tens * 10) (Get ones place)

    ; Step 3: Pack into BCD (Hundreds, Tens, Ones)
    LSL R3, R3, #8        ; Move hundreds to upper byte
    LSL R5, R5, #4        ; Move tens to middle nibble
    ORR R6, R3, R5        ; Combine hundreds and tens
    ORR R6, R6, R1        ; Combine with ones

    ; Store result in memory
    LDR R8, =BCD_RESULT   ; Load address to store BCD result
    STR R6, [R8]         ; Store converted BCD value

HEX_NUM    DCB 0x7B       ; Example input: Hex 0x7B (Decimal 123)
    
	AREA mydata, DATA, READWRITE

BCD_RESULT DCD 0          ; Memory location for output

    END
