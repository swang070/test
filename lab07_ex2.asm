;=================================================
; Name: Benjamin Lee
; Email:  blee073@ucr.edu
; 
; Lab: lab 7
; Lab section: 025
; TA: Dipan
; 
;=================================================
.orig x3000
LEA R0, instruction
PUTS

GETC
OUT

ADD R1, R0, #0
JSR SUB_COUNT_ONES

HALT
;===
; Data Block
;===                       
instruction			.STRINGZ "\nPlease enter a character: "
;==
; End of program
;==
.end

;===
; Subroutine: SUB_TAKE_IN_AND_PRINT_1_BITS
; Input: R1
; Postcondition:
; Return Value:
;===
.ORIG x3200       

SUB_COUNT_ONES                       
ST R1, BACKUP_R1_3200
ST R7, BACKUP_R7_3200

LD R2, DEC_ZERO
LD R3, BIT_COUNT
LD R4, DEC_TO_CHAR
ADD R1, R1, #0			; x + x = 2x
BRn INCREMENT

COUNTER                         
ADD R1, R1, R1			; x + x = 2x
ADD R1, R1, #0			; x + 0 = x
BRn INCREMENT
ADD R3, R3, #-1			; Decrement counter
BRp COUNTER			; if positive, iterate 
BR  PRINT

INCREMENT                         
ADD R2, R2, #1			; Shift ascii num [start from 0]
ADD R3, R3, #-1			; Decrement counter
BR COUNTER

PRINT                         
ADD R4, R2, R4			; Sum of DEC_TO_CHAR and DEC_ZER0 [whatever number it is at]
LEA R0, PROMPT			; Output prompt message to console
PUTS
ADD R0, R4, #0			; Echo to console the content from R4 [ADDed to R0]
OUT

; Restore registers used
LD R7, BACKUP_R7_3200
LD R7, BACKUP_R7_3200
RET
;===
; Subroutine Data Block
;===
BACKUP_R1_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1

DEC_ZERO		.FILL #0
DEC_TO_CHAR		.FILL x30
BIT_COUNT		.FILL #16

PROMPT			.STRINGZ "\nThe number of 1's is:  "  
;==
; End of Subroutine
;==
.END                
