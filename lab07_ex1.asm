;=================================================
; Name: Benjamin Lee
; Email:  blee073@ucr.edu
; 
; Lab: lab 7
; Lab section: 025
; TA: Dipan
;=================================================
.orig x3000

LD R0, sub_input
JSRR R0

ADD R5, R5, #1

LD R0, sub_output
JSRR R0

HALT

;===
;Local Data
;===
sub_input .FILL x3200
sub_output .FILL x3400

;=================================================
;Subroutine: SUB_INPUT_MULTI_DIGIT_NUM
;Parameter: 
;Postcondition: This subroutine returns a 5-digit number
;Return value: R5 
;=================================================

.orig x3200
;===
;Subroutine Instructions
;===

ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

RESET
AND R5, R5, #0
AND R6, R6, #0
LD R0, introMessage
PUTS
LD R1, neg
GETC
OUT
NOT R2, R0
ADD R2, R2, #1
ADD R2, R1, R2
BRz FLAG
LD R1, NEWLINE
NOT R2, R0
ADD R2, R2, #1
ADD R2, R1, R2
BRz ERROR
LD R1, pos
NOT R2, R0
ADD R2, R2, #1
LD R6, NEG_ONE
ADD R2, R1, R2
BRz DO_WHILE
LD R1, zero
NOT R2, R0
ADD R2, R2, #1
LD R3, count

fruit_loop1
ADD R4, R1, R2
BRz ADDER
ADD R1, R1, #1
ADD R3, R3, #-1
BRp fruit_loop1

END_fruit_loop1
BRnzp ERROR

DO_WHILE
GETC
OUT
LD R1, NEWLINE
NOT R2, R0
ADD R2, R2, #1
ADD R2, R1, R2
BRz END
ADD R6, R6, #1
LD R1, zero
NOT R2, R0
ADD R2, R2, #1
LD R3, count

fruit_loop2
ADD R4, R1, R2
BRz ADDER
ADD R1, R1, #1
ADD R3, R3, #-1
BRp fruit_loop2

END_fruit_loop2
BRnzp ERROR

ADDER
LD R3, offset
NOT R3, R3
ADD R3, R3, #1
ADD R0, R0, R3
ST R5, mult_num
LD R2, nine
LD R3, mult_num
WHILE
ADD R5, R5, R3
ADD R2, R2, #-1
BRp WHILE
ADD R5, R5, R0

END_ADDER
BRnzp DO_WHILE

END
ADD R6, R6, #0
BRn ERROR
LD R6, flagNum
BRn TWOS_COMP 
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200
RET

ERROR
LD R0, NEWLINE
OUT
LD R0, errorMessage
PUTS
BRnzp RESET
END_ERROR

TWOS_COMP 
NOT R5, R5
ADD R5, R5, #1
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200
RET

FLAG
LD R6, NEG_ONE
ST R6, flagNum
LD R6, NEG_ONE
BRnzp DO_WHILE
END_FLAG
;===
;Local Data
;===
offset .FILL #48
neg .FILL x2D
pos .FILL x2B
zero .FILL x30
count .FILL #10
NEWLINE .FILL x0A
NEG_ONE .FILL #-1
nine .FILL #9

flagNum .BLKW 1
mult_num .BLKW 1

BACKUP_R0_3200 .BLKW 1
BACKUP_R1_3200 .BLKW 1
BACKUP_R2_3200 .BLKW 1
BACKUP_R3_3200 .BLKW 1
BACKUP_R4_3200 .BLKW 1
BACKUP_R6_3200 .BLKW 1
BACKUP_R7_3200 .BLKW 1

introMessage .FILL x6000
errorMessage .FILL x6100
;=================================================
;Parameter (R5): Register with output intended value
;Postcondition: This subroutine outputs a multi-digit [R5]
;Return value: 
;=================================================

.orig x3400
;Subroutine Instructions
ST R0, BACKUP_R0_3400
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R7, BACKUP_R7_3400

LD R2, DEC_10000
NOT R2, R2
ADD R2, R2, #1
LD R3, NEG_ONE_3400
LD R4, offset_3400
ST R5, currentReg
AND R1, R5, #-1
BRzp LOOP_1
LD R0, NEG_3400
OUT
NOT R5, R5
ADD R5, R5, #1
ST R5, currentReg

LOOP_1
ADD R3, R3, #1
ADD R5, R5, R2
BRzp LOOP_1
ADD R0, R3, R4
OUT
ADD R3, R3, #-1
LD R5, currentReg
ADD R3, R3, #0
BRn END_WHILE_1

WHILE_1
ADD R5, R5, R2
ADD R3, R3, #-1
BRzp WHILE_1
END_WHILE_1
ST R5, currentReg
LD R2, DEC_1000
NOT R2, R2
ADD R2, R2, #1    
LD R3, NEG_ONE_3400

LOOP_2
ADD R3, R3, #1
ADD R5, R5, R2
BRzp LOOP_2  
ADD R0, R3, R4
OUT
LD R5, currentReg
ADD R3, R3, #0
BRz END_WHILE_2

WHILE_2
ADD R5, R5, R2
ADD R3, R3, #-1
BRp WHILE_2

END_WHILE_2
ST R5, currentReg
LD R2, DEC_100
NOT R2, R2
ADD R2, R2, #1
LD R3, NEG_ONE_3400

LOOP_3
ADD R3, R3, #1
ADD R5, R5, R2
BRzp LOOP_3  
ADD R0, R3, R4
OUT
LD R5, currentReg
ADD R3, R3, #0
BRz END_WHILE_3

WHILE_3
ADD R5, R5, R2
ADD R3, R3, #-1
BRp WHILE_3
ST R5, currentReg

END_WHILE_3
LD R2, DEC_10
NOT R2, R2
ADD R2, R2, #1
LD R3, NEG_ONE_3400

LOOP_4
ADD R3, R3, #1
ADD R5, R5, R2
BRzp LOOP_4  
ADD R0, R3, R4
OUT
LD R5, currentReg
ADD R3, R3, #0
BRz END_WHILE_4

WHILE_4
ADD R5, R5, R2
ADD R3, R3, #-1
BRp WHILE_4
ST R5, currentReg
END_WHILE_4
LD R2, DEC_1
NOT R2, R2
ADD R2, R2, #1
LD R3, NEG_ONE_3400

LOOP_5
ADD R3, R3, #1
ADD R5, R5, R2
BRzp LOOP_5  
ADD R0, R3, R4
OUT
LEA R0, NEWLINE3400
PUTS
LD R0, BACKUP_R0_3400
LD R1, BACKUP_R1_3400
LD R2, BACKUP_R2_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R7, BACKUP_R7_3400
RET
;===
; Subroutine Data
;===
offset_3400 .FILL #48
NEG_3400 .FILL x2D
pos_3400 .FILL x2B
zero_3400 .FILL x30
DEC_10000 .FILL #10000
DEC_1000 .FILL #1000
DEC_100 .FILL #100
DEC_10 .FILL #10
DEC_1 .FILL #1
NEG_ONE_3400 .FILL #-1
NEWLINE3400 .FILL x0A

currentReg.BLKW 1

BACKUP_R0_3400 .BLKW 1
BACKUP_R1_3400 .BLKW 1
BACKUP_R2_3400 .BLKW 1
BACKUP_R3_3400 .BLKW 1
BACKUP_R4_3400 .BLKW 1
BACKUP_R5_3400 .BLKW 1
BACKUP_R7_3400 .BLKW 1
;===
;Remote data
;===
.ORIG x6000
intro .STRINGZ"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.ORIG x6100
error_mes .STRINGZ"ERROR INVALID INPUT\n"

;===
; End of program
;===
.end
