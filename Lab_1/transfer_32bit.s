        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x10001000  ; Initial Stack Pointer
        DCD Reset_Handler  ; Entry Point
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
        LDR R0, =SRC       ; Load the address of SRC into R0
        LDR R1, =DST       ; Load the address of DST into R1
        LDR R2, [R0]       ; Load 32-bit value from SRC into R2
        STR R2, [R1]       ; Store 32-bit value into DST

STOP
        B STOP             ; Infinite loop to halt execution

        AREA mydata, DATA, READWRITE
SRC     DCD 0x12345678      ; Source 32-bit data
DST     DCD 0               ; Destination location (initially 0)
        END
