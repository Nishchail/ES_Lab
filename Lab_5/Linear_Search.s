    AREA RESET, DATA, READWRITE
    EXPORT __Vectors

__Vectors
    DCD 0x1001000
    DCD Reset_Handler
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    LDR R0, =ARRAY      ; Load base address of ARRAY
    LDR R1, =SEARCH_KEY ; Load address of SEARCH_KEY
	LDR R7 , =RESULT
    LDR R1, [R1]        ; Load value of SEARCH_KEY
    MOV R2, #0          ; Index i = 0
	MOV R9 , #4;

SEARCH_LOOP
    CMP R2, #10         ; Check if i >= 10 (end of array)
    BHS NOT_FOUND       ; If yes, element is not in the array

	MUL R3 , R2 , R9	; Offset = i * 4 (for 32-bit numbers)
    LDR R4, [R0, R3]    ; Load array[i]

    CMP R4, R1          ; Compare array[i] with SEARCH_KEY
    BEQ FOUND           ; If found, go to FOUND

    ADD R2, R2, #1      ; i = i + 1
    B SEARCH_LOOP       ; Repeat loop
	
NOT_FOUND
    MOV R5, #-1         ; If not found, store -1
    STR R5,[R7]     	; Store result as -1

FOUND
    STR R2,[R7]    		; Store index of found element
    B DONE              ; Exit program

DONE
    B DONE              ; Infinite loop (end of execution)
	
ARRAY      DCD 10, 20, 30, 40, 50, 60, 70, 80, 90, 100  ; 10-element array
SEARCH_KEY DCD 40     ; Element to search for

    AREA DATA_AREA, DATA, READWRITE

RESULT     DCD 0      ; Stores the index if found, -1 if not found

    END
