        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x10001000     ; Initial Stack Pointer
        DCD Reset_Handler  ; Entry Point
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
        LDR R0, =SRC_BLOCK  ; Load address of source block into R0
        LDR R1, =DST_BLOCK  ; Load address of destination block into R1
        MOV R2, #10         ; Load loop counter (10 elements) into R2

Loop
        LDR R3, [R0], #4    ; Load 32-bit value from source and increment R0 by 4
        STR R3, [R1], #4    ; Store 32-bit value to destination and increment R1 by 4
        SUBS R2, R2, #1     ; Decrement loop counter
        BNE Loop            ; If R2 is not zero, repeat the loop

STOP
        B STOP              ; Infinite loop to halt execution

        AREA mydata, DATA, READWRITE
SRC_BLOCK
        DCD 0x11111111, 0x22222222, 0x33333333, 0x44444444, 0x55555555
        DCD 0x66666666, 0x77777777, 0x88888888, 0x99999999, 0xAAAAAAAA
DST_BLOCK
        SPACE 40            ; Reserve 40 bytes (10 x 4 bytes) for the destination block
        END
