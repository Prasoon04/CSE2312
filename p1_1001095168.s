/******************************************************************************
* @FILE p1_1001095168
* @BRIEF A simple calculator with addition, subtraction, multiplication and   *  maximum number functionality.
*
* @AUTHOR PRASOON GAUTAM
*
*****************************************************************************/

	.global main
	.func main

main:
	BL _scanf
	MOV R6, R0
	BL _getchar
	MOV R7, R0
	BL _scanf
	MOV R8, R0
	BL _compare
	MOV R1, R0
	BL _printf
	B main

_scanf:
	MOV R4, LR
	SUB SP, SP, #4
	LDR R0, =format_str
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	MOV PC, R4

_getchar:
	MOV R7, #3
	MOV R0, #0
	MOV R2, #1
	LDR R1, =read_char
	SWI 0
	LDR R0, [R1]
	AND R0, #0xFF
	MOV PC, LR

_compare:
	PUSH {LR}
	CMP R7, #'+'
	BEQ _sum
	CMP R7, #'-'
	BEQ _diff
	CMP R7, #'*'
	BEQ _mul
	CMP R7, #'M'
	BEQ _max
	POP {PC}

_sum:
	PUSH {LR}
	ADD R0, R6, R8
	POP {PC}

_diff:
	PUSH {LR}
	SUB R0, R6, R8
	POP {PC}

_mul:
	PUSH {LR}
	MUL R0, R6, R8
	POP {PC}

_max:
	PUSH {LR}
	CMP R6, R8
	MOVGE R0, R6
	POP {PC}

_printf:
	PUSH {LR}
	LDR R0, =printf_str
	MOV R1, R1
	BL printf
	POP {PC}

.data
format_str:	.asciz	"%d"
read_char:	.ascii	" "
printf_str:	.asciz	"%d\n"





