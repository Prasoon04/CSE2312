	.global main
	.func main

main:
	BL _prompt1
	BL _scanf
	MOV R4, R0
	MOV R1, R0
	BL _prompt2
	BL _getchar
	MOV R5, R0
	BL _prompt1
	BL _scanf
	MOV R6, R0
	MOV R1, R0
@	BL _printf
	MOV R1, R4
	MOV R2, R5
	MOV R3, R6
	BL _compare
	MOV R1, R0
	BL _printval
	B main

_prompt1:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #14
	LDR R1, =prompt1_str
	SWI 0
	MOV PC, LR

_scanf:
	MOV R4, LR
	SUB SP, SP, #4
	LDR R0, =format_str
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	MOV PC, R4

_prompt2:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #39
	LDR R1, =prompt2_str
	SWI 0
	MOV PC, LR

_getchar:
	MOV R7, #3
	MOV R0, #0
	MOV R2, #1
	LDR R1, =read_char
	SWI 0
	LDR R0, [R1]
	AND R0, #0xFF
	MOV PC, LR

_printval:
	MOV R4, LR
	LDR R0, =print_res
	BL printf
	MOV LR, R4
	MOV PC, LR

@ _printf:
@	MOV R7, LR
@	LDR R0, =print_str
@	MOV R1, R1
@	BL printf
@	MOV PC, R7

_compare:
	MOV R4, LR
	CMP R2, #'+'
	BLEQ _add
	CMP R2, #'-'
	BLEQ _sub
	CMP R2, #'*'
	BLEQ _mul
	CMP R2, #'M'
	BLEQ _max
	MOV PC, R4

_add:
	MOV R0, R1
	ADD R0, R3
	MOV PC, LR

_sub:
	MOV R0, R1
	SUB R0, R3
	MOV PC, LR
	
_mul:
	MOV R0, R1
	MUL R0, R3
	MOV PC, LR

_max:
	CMP R1, R3
	MOVLE R1, R3
	MOV R0, R1
	MOV PC, LR

.data
format_str:   .asciz     "%d"
prompt1_str:  .ascii     "Type a number:"
prompt2_str:  .ascii     "Enter a operation from '+','-','*','M':"
read_char:    .ascii     " "
print_str:    .asciz     "The number entered was: %d\n"
print_res:     .asciz     "Result = %d\n"
