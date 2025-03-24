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
    LDR R0, =N1         ; Load address of N1
    LDR R1, =N2         ; Load address of N2
    LDR R2, [R0]        ; Load value of N1 into R2
    LDR R3, [R1]        ; Load value of N2 into R3

gcd_loop
    CMP R3, #0          ; If R3 == 0, GCD is in R2
    BEQ store_gcd
    CMP R2, R3
    BHI subtract        ; If R2 > R3, subtract
    MOV R4, R2          ; Swap R2 and R3 if needed
    MOV R2, R3
    MOV R3, R4

subtract
    SUB R2, R2, R3      ; R2 = R2 - R3
    B gcd_loop          ; Repeat loop

store_gcd
    LDR R0, =gcd
    STR R2, [R0]        ; Store GCD (fixed from STRB to STR)

    ; LCM Calculation: LCM = (N1 * N2) / GCD
    LDR R0, =N1
    LDR R1, =N2
    LDR R4, [R0]        ; Reload N1
    LDR R5, [R1]        ; Reload N2
    LDR R6, =lcm
    MUL R7, R4, R5      ; R7 = N1 * N2
    UDIV R8, R7, R2     ; R8 = (N1 * N2) / GCD
    STR R8, [R6]        ; Store LCM

STOP
    B STOP              ; Infinite loop
N1 DCD 10
N2 DCD 15
    AREA mydata, DATA, READWRITE

gcd DCD 0
lcm DCD 0
    END
