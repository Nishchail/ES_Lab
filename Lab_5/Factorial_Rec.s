    AREA RESET, DATA, READWRITE
    EXPORT __Vectors

__Vectors
    DCD 0x1001000
    DCD Reset_Handler
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
    EXPORT Factorial

Reset_Handler
    LDR R0, =NUMBER  ; Load address of input number
    LDR R0, [R0]     ; Load the value of NUMBER into R0
    BL Factorial     ; Call the recursive factorial function
    LDR R1, =RESULT  ; Load address of RESULT
    STR R0, [R1]     ; Store the factorial result in RESULT

DONE
    B DONE           ; Infinite loop (to prevent further execution)

Factorial
    PUSH {LR}        ; Save return address on stack

    CMP R0, #1       ; Check if n <= 1
    BLS BASE_CASE    ; If true, return 1

    PUSH {R0}        ; Save n before recursion
    SUB R0, R0, #1   ; Compute n - 1
    BL Factorial     ; Recursive call: fact(n-1)

    POP {R1}         ; Restore original n
    MUL R0, R1, R0   ; Compute n * fact(n-1)

    POP {LR}         ; Restore return address
    BX LR            ; Return from function

BASE_CASE
    MOV R0, #1       ; Return 1 if n == 0 or n == 1
    POP {LR}         ; Restore return address
    BX LR            ; Return from function
	
NUMBER  DCD 5     ; Input number for factorial

    AREA DATA_AREA, DATA, READWRITE

RESULT  DCD 0     ; Store factorial result

    END
