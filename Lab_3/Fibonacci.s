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
	LDR R9, =N         ; Load address of N
	LDR R5, [R9]       ; Load value of N into R5
	LDR R0, =fib       ; Load address of fib array

	MOV R1, #0         ; First Fibonacci number
	MOV R2, #1         ; Second Fibonacci number

	STRB R1, [R0], #1  ; Store first number, move pointer
	SUBS R5, R5, #1    ; Decrement N
	BEQ STOP           ; If N == 0, stop

	STRB R2, [R0], #1  ; Store second number, move pointer
	SUBS R5, R5, #1    ; Decrement N
	BEQ STOP           ; If N == 0, stop

fib_loop
	ADD R3, R1, R2     ; R3 = R1 + R2
	STRB R3, [R0], #1  ; Store Fibonacci number, move pointer
	MOV R1, R2         ; Shift R1 ? R2
	MOV R2, R3         ; Shift R2 ? R3

	SUBS R5, R5, #1    ; Decrement counter
	BNE fib_loop       ; If not zero, repeat

STOP
	B STOP             ; Infinite loop
N DCD 0x08               ; Number of Fibonacci terms
	AREA mydata, DATA, READWRITE
fib DCD 0             ; Storage for Fibonacci numbers

	END
