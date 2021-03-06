	.global main
	.func main
main:
	BL _scanf
	MOV R6, R0
	BL _scanf
	MOV R7, R0
	MOV R1, R6
	MOV R2, R7
	BL _count_partition
	MOV R4, R0
	MOV R1, R0
	MOV R2, R6
	MOV R3, R7
	BL _printf
	B main

_scanf:
	PUSH {LR}
	LDR R0, =format_str
	SUB SP, SP, #4
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	POP {PC}

_printf:
	PUSH {LR}
	LDR R0, =printf_str
	BL printf
	POP {PC}

_count_partition:
	CMP R1, #0
	MOVEQ R0, #1
	MOVEQ PC, LR
	CMP R1, #0
	MOVLT R0, #0
	MOVLT PC, LR
	CMP R2, #0
	MOVEQ R0, #0
	MOVEQ PC, LR
	PUSH {LR}
	PUSH {R1}
	PUSH {R2}
	SUB R1, R1, R2
	SUB R2, R2, #0
	BL _count_partition
	POP {R2}
	POP {R1}
	PUSH {R0}
	SUB R1, R1, #0
	SUB R2, R2, #1
	BL _count_partition
	POP {R3}
	ADD R0, R0, R3
	POP {PC}

.data
format_str:       .asciz "%d"
printf_str:       .asciz "There are %d partitions of %d using up to %d numbers.\n"
