;=================================================
; Name: Benjamin Lee
; Email: blee073@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
START_HERE
  ; menu subroutine
  LD	R1,MENU_ADDR
  JSRR	R1
  ; Check return value of R1, and call subroutine in response to result.
  ADD	R6,R1,#0
  ADD	R6,R1,#-1
  BRz	CALL_BUSY
  
  ADD	R6,R1,#0
  ADD	R6,R1,#-2
  BRz	CALL_FREE

  ADD	R6,R1,#0
  ADD	R6,R1,#-3
  BRz	CALL_NUM_BUSY

  ADD	R6,R1,#0
  ADD	R6,R1,#-4
  BRz	CALL_NUM_FREE

  ADD	R6,R1,#0
  ADD	R6,R1,#-5
  BRz	CALL_MACH_STATUS

  ADD	R6,R1,#0
  ADD	R6,R1,#-6
  BRz	CALL_FIRST_FREE

  ADD	R6,R1,#0
  ADD	R6,R1,#-7
  BRz	END_PROG
 
  LEA	R0,Goodbye
  PUTS
  PUTS
  BRnzp END_PROG
  BR	START_HERE
CALL_BUSY
  LD	R0,ALL_BUSY_ADDR
  JSRR	R0
  ADD	R2,R2,#0
  BRz	PRINT_ALL_NOT_BUSY
  LEA	R0,ALLBUSY
  PUTS
  BR	START_HERE
PRINT_ALL_NOT_BUSY
  LEA	R0,ALLNOTBUSY
  PUTS
  BR	START_HERE
CALL_FREE
  LD	R0,ALL_FREE_ADDR
  JSRR	R0
  ADD	R2,R2,#0
  BRz	PRINT_ALL_NOT_FREE
  LEA	R0,FREE
  PUTS
  BR	START_HERE
PRINT_ALL_NOT_FREE
  LEA	R0,NOTFREE
  PUTS
  BR	START_HERE
CALL_NUM_BUSY
  LD	R0,NUM_BUSY_ADDR
  JSRR	R0
  LEA	R0,BUSYMACHINE1
  PUTS
  LD	R0,PRINT_NUM_ADDR
  JSRR	R0
  LEA	R0,BUSYMACHINE2
  PUTS
  BR	START_HERE
CALL_NUM_FREE
  LD	R0,NUM_FREE_ADDR
  JSRR	R0
  LEA	R0,FREEMACHINE1
  PUTS
  LD	R0,PRINT_NUM_ADDR
  JSRR	R0
  LEA	R0,FREEMACHINE2
  PUTS
  BR	START_HERE
CALL_MACH_STATUS
  LD	R0,GET_INPUT_ADDR
  JSRR	R0
  LD	R0,MACHINE_STAT_ADDR
  JSRR	R0
  LEA	R0,STATUS1
  PUTS
  ST	R2,MACHINE_STAT_RESULT
  ADD	R2,R1,#0
  LD	R0,PRINT_NUM_ADDR
  JSRR	R0
  LD	R2,MACHINE_STAT_RESULT
  BRp	PRINT_MACHINE_FREE
  LEA	R0,STATUS2
  PUTS
  BR	START_HERE
PRINT_MACHINE_FREE
  LEA	R0,STATUS3
  PUTS
  BR	START_HERE
CALL_FIRST_FREE
  LD	R0,FIRST_FREE_ADDR
  JSRR	R0
  ADD	R0,R2,#-16
  BRz	NONE_FREE
  LEA	R0,FIRSTFREE
  PUTS
  LD	R0,PRINT_NUM_ADDR
  JSRR	R0
  LEA	R0,FIRSTFREE2
  PUTS
  BR	START_HERE
NONE_FREE
  LEA	R0,FIRSTFREE3
  PUTS
  BR	START_HERE
END_PROG
  LEA	R0,Goodbye
  PUTS
  HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU_ADDR		.FILL x3300
ALL_BUSY_ADDR		.FILL x3600
ALL_FREE_ADDR		.FILL x3900
NUM_BUSY_ADDR		.FILL x4200
NUM_FREE_ADDR		.FILL x4500
MACHINE_STAT_ADDR	.FILL x4800
FIRST_FREE_ADDR		.FILL x5100
GET_INPUT_ADDR		.FILL x5400
PRINT_NUM_ADDR		.FILL x5700
;Other data 
MACHINE_STAT_RESULT	.FILL xFFFF
;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.orig x3300
;HINT back up 
ST	R7,BACKUP_R7_3300
MENU_LOOP
  LD	R0,MENU_STR_ADDR
  PUTS
  GETC					; take input
  OUT					; echo
  ADD	R1,R0,#0			; copy input to R1
  AND	R0,R0,#0
  ADD	R0,R0,#10
  OUT
  ADD	R0,R1,#0
  ; check if input < 1
  LD	R2,MENU_ASCII_48		
  ADD	R1,R1,R2
  ADD	R1,R1,#-1			
  BRn	MENU_ERROR
  ; check if input > 7
  ADD	R1,R0,#0
  LD	R2,MENU_ASCII_55
  ADD	R1,R1,R2
  BRp	MENU_ERROR
  ADD	R1,R0,#0
  LD	R2,MENU_ASCII_48
  ADD	R1,R1,R2
  BRnzp	END_MENU
  ;if here, then 1 <= input <= 7. end loop
MENU_ERROR
  LEA	R0,Error_message_1
  PUTS
  BRnzp	MENU_LOOP
END_MENU
  ;HINT Restore
  AND	R0,R0,#0
  AND	R2,R2,#0
  LD	R7,BACKUP_R7_3300
  RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"	; error string
MENU_STR_ADDR .FILL x6000			; input message string
BACKUP_R7_3300	.FILL	x0			; return address store
MENU_ASCII_48	.FILL	#-48
MENU_ASCII_55	.FILL	#-55
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.orig x3600
ST	R7,BACKUP_R7_3600
LD	R6,BUSYNESS_ADDR_ALL_MACHINES_BUSY	; LD busyness vec addr to R6
LDR	R1,R6,#0				; LD busyness vec into R1
LD	R3,COUNTER_16_3600			; LD 16 bit counter to parse bits
AND	R2,R2,#0				; Return = 0; default not all machines busy
ALL_MACH_BUSY_LOOP
  ADD	R1,R1,#0				; set the busyness vec register as last used
  BRn	ALL_MACHINES_BUSY_END			; if <0, 1st = 1 i.e. at least 1 is free 
						; Return 0 (R2 is already set to 0 by default, so go to end
  ADD	R1,R1,R1				; bit shift to the left the busyness vec
  ADD	R3,R3,#-1				; decrement counter
  BRp	ALL_MACH_BUSY_LOOP			; iterate while counter > 0
; if here, counter <= 0 + no bits were 1 (no machines were free)
; all machines are busy. return value = 1 and go to end.
  ADD	R2,R2,#1		
ALL_MACHINES_BUSY_END
  ;HINT Restore
  AND 	R0,R0,#0
  AND	R1,R1,#0
  AND	R3,R3,#0
  AND	R6,R6,#0
  LD	R7,BACKUP_R7_3600
  RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000
BACKUP_R7_3600			.FILL x0
COUNTER_16_3600	.FILL #16
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.orig x3900
;HINT back up 
ST	R7,BACKUP_R7_3900
LD	R6,BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR	R1,R6,#0
LD	R3,COUNTER_16_3900
AND	R2,R2,#0
ALL_MACH_FREE_LOOP
  ADD	R1,R1,#0
  BRzp	ALL_MACH_FREE_END
  ADD	R1,R1,R1
  ADD	R3,R3,#-1
  BRp	ALL_MACH_FREE_LOOP
  ADD	R2,R2,#1	
ALL_MACH_FREE_END
  ;HINT Restore
  AND	R0,R0,#0
  AND	R1,R1,#0
  AND	R3,R3,#0
  AND	R6,R6,#0
  LD	R7,BACKUP_R7_3900
  RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000
BACKUP_R7_3900			.FILL x0
COUNTER_16_3900
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.orig x4200
;HINT back up 
ST	R7,BACKUP_R7_4200
LD	R6,BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR	R1,R6,#0
LD	R3,COUNTER_16_4200
AND	R2,R2,#0
NUM_BUSY_MACH_LOOP
  ADD	R1,R1,#0
  BRzp	INCREMENT_LOOP_4200
POST_CHECK_NUM_BUSY_MACHINES
  ADD	R1,R1,R1
  ADD	R3,R3,#-1
  BRp	NUM_BUSY_MACH_LOOP
  BRnzp	NUM_BUSY_MACH_END	
INCREMENT_LOOP_4200
  ADD	R2,R2,#1
  BRnzp	POST_CHECK_NUM_BUSY_MACHINES	
NUM_BUSY_MACH_END
  ;HINT Restore
  LD	R7,BACKUP_R7_4200
  RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000
BACKUP_R7_4200			.FILL x0
COUNTER_16_4200			.FILL #16
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.orig x4500
ST	R7,BACKUP_R7_4500
LD	R6,BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR	R1,R6,#0
LD	R3,COUNTER_16_4500
AND	R2,R2,#0
NUM_FREE_MACH_LOOP
  ADD	R1,R1,#0
  BRn	INCREMENT_LOOP_4500
POST_CHECK_NUM_FREE_MACHINES
  ADD	R1,R1,R1
  ADD	R3,R3,#-1
  BRp	NUM_FREE_MACH_LOOP
  BRnzp	NUM_FREE_MACH_END
INCREMENT_LOOP_4500
  ADD	R2,R2,#1
  BRnzp	POST_CHECK_NUM_FREE_MACHINES
NUM_FREE_MACH_END
  ;HINT Restore
  LD	R7,BACKUP_R7_4500
  RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000
BACKUP_R7_4500			.FILL x0
COUNTER_16_4500			.FILL #16


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.orig x4800
;HINT back up 
ST	R7,BACKUP_R7_4800
ADD	R6,R1,#0			; copy machine number we want to check in R1 to R6
LD	R4,FIFTEEN			; LD 15 into R4
NOT	R6,R6
ADD	R6,R6,#1			; add 1 to mach num we want to check for 2's comp
ADD	R4,R4,R6			; R4 <- 15 - num to check, R4 = # of left shifts
LD	R6,BUSYNESS_ADDR_MACHINE_STATUS
LDR	R2,R6,#0
MACH_STAT_PRELOOP
ADD	R4,R4,#0
BRz	DETERMINE_STAT			;if 0, then break
MACH_STAT_LOOP
ADD	R2,R2,R2	
ADD	R4,R4,#-1
BRp	MACH_STAT_LOOP
DETERMINE_STAT
ADD	R2,R2,#0
BRzp	MACH_IS_BUSY
AND	R2,R2,#0
ADD	R2,R2,#1
BRnzp	MACH_STAT_END
MACH_IS_BUSY
AND	R2,R2,#0
MACH_STAT_END
;HINT Restore
AND	R3,R3,#0
AND	R4,R4,#0
AND	R6,R6,#0
LD	R7,BACKUP_R7_4800
RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xD000
BACKUP_R7_4800			.FILL x0
FIFTEEN				.FILL #15
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.orig x5100
;HINT back up 
ST	R7,BACKUP_R7_5100		; save return address
LD	R6,BUSYNESS_ADDR_FIRST_FREE	; ld address of busyness vec to R6
LDR	R1,R6,#0			; ld actual busyness vec into R1
AND	R2,R2,#0			; set R2 to 0; designated lower (outer) counter
AND	R3,R3,#0	
ADD	R3,R3,#15			; set R3 to 15; designated upper (inner) counter
FIRST_FREE_LOOP
  ADD	R3,R3,#0
  BRz	CHECK_IF_FIRST			; 15th bit check
  ADD	R1,R1,R1			; bit shift 
  ADD	R3,R3,#-1			; loop R3 amount of times
  BRp	FIRST_FREE_LOOP
CHECK_IF_FIRST	
  ADD	R1,R1,#0			; if R1 < 0, then bit R2 is the first free
  BRn	END_FIRST_FREE_LOOP
  ADD	R2,R2,#1			; else check bit R2 + 1
  AND	R3,R3,#0			; do this by shifting [15 - (R2 + 1)] times
  ADD	R3,R3,#15
  NOT	R7,R2
  ADD	R7,R7,#1
  ADD	R3,R3,R7
  ADD	R7,R2,#-16
  BRz	END_FIRST_FREE_LOOP		; if none free, leave R2 as 16
  LDR	R1,R6,#0			; reload bit vector to bit shift again
  BRnzp	FIRST_FREE_LOOP
END_FIRST_FREE_LOOP
  ;HINT Restore
  LD	R7,BACKUP_R7_5100
  RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xD000
BACKUP_R7_5100			.FILL x0

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x5400
ST	R7,BACKUP_R7_5400
BEGINNING
  LEA	R0,prompt  
  PUTS
;R0-input R1-working reg R3-use symbol R4-sign check R5-value R6-counter R7-work
  LD	R6,input_count_6	; max input of 6	parsing counter
  AND	R5,R5,#0		; rolling sum
  AND	R4,R4,#0		; sign bit, default is 0=pos 1=neg
  AND	R3,R3,#0		; symbol bit 0=no 1=yes
  
LOOP
  GETC			;input char to R0 and echo it	
  ADD	R1,R0,#0
  LD	R7,NEWLINE
  ADD	R1,R1,R7
  BRnp	OUTPUT_CHAR
POST_OUT
  ; if < 48
  ADD	R1,R0,#0	; copy inputted char to R1
  LD	R7,MINUS_48	; LD -48
  ADD	R1,R1,R7	; R1 <- input - 48
  BRn	LESS_48		; if input < 0 then is < 48 (0)
  ;if > 57
  ADD	R1,R0,#0	; copy inputted char to R1
  LD	R7,MINUS_57	; LD -57
  ADD	R1,R1,R7	; R1 <- input - 57
  BRp	GREATER_57	; if input > -1 then is > than 57 (9)
  ; from here input is 48 < x < 57. 
  ; if first char
  ADD	R1,R6,#0	; copy current counter to R1
  ADD	R1,R1,#-6	; decrement counter by 6
  BRz	FIRST_CHAR	; first char check
  ; if not first char, proceed. First R5 * 10
  ADD	R5,R5,R5	; x + x = 2x
  ADD	R7,R5,R5	; 2x + 2x = 4x
  ADD	R7,R7,R7	; 4x + 4x = 8x
  ADD	R5,R5,R7	; 8x + 2x = 10x
  ; add input to R5
  LD	R7,MINUS_48	; prepare conversion from dec to ascii
  ADD	R0,R0,R7	; convert
  ADD	R5,R5,R0	; add dec input to 10 * prev sum.
  ADD	R6,R6,#-1	; decrement counter
  BRp	LOOP		; if pos, iterate loop again until not pos
  BRz	END
OUTPUT_CHAR
  OUT
  BRnzp	POST_OUT
OUTPUT_ERROR_NEWLINE
  LD	R0,NEWLINE_char
  OUT
  BRnzp	GREATER
NEGATIVE		; 2's comp
  NOT	R5,R5
  ADD	R5,R5,#1
  BRnzp	END_SUBR
FIRST_CHAR		; is first char, so R5=0. add input -> R5, decrement counter by 2 instead of 1
  LD	R7,MINUS_48
  ADD	R0,R0,R7	; convert inputto dec from ascii
  ADD	R5,R0,R5	; R5 <- inputted dec val + R5. (R5 init 0)
  ADD	R6,R6,#-2	; decrement counter by 2 bc no sign bit 
  BRnzp	LOOP
IS_NEWLINE
  ; check if first char
  ADD	R1,R6,#0	; copy current counter to R1
  ADD	R1,R1,#-6	; subtract 6
  BRz	OUTPUT_ERROR_NEWLINE	;if 0, then 1st char = newline. Is wrong. 
  ;if newline, check if second char
  ADD	R1,R6,#0
  ADD	R1,R1,#-5	; subtract 5
  BRnp	END		; if the result > 0, not second char. go to end.
  ; newline was the second char. check if symbol flag = 1
  ADD	R1,R3,#0	; copy symbol flag to R1
  ADD	R1,R1,#-1	; decrement
  BRz	OUTPUT_ERROR_NEWLINE ;if the result = 0, symbol flag = 1. This means
  BRnp	END		;that 1st char = sign, 2nd char = newline. is wrong. 
			; newline was 2nd char, first char NOT sign symbol.
			; R5 should be 1 digit dec number.
IS_PLUS
  ; if plus, check if first char
  ADD	R1,R6,#0
  ADD	R1,R1,#-6
  BRnp	GREATER_57	; if result != 0, then not first char
  ; symbol is a + and is first char.
  ADD	R4,R4,#0	; set R4 to 0 [should already be]
  ADD	R3,R3,#1	; set flag = 1. 
  ADD	R6,R6,#-1	; decrement counter
  BRnzp	LOOP		; iterate
IS_MINUS
  ;if minus, check if first char
  ADD	R1,R6,#0
  ADD	R1,R1,#-6
  BRnp	GREATER_57	; if result != 0, not first char
  ; symbol is a - and is first char.
  ADD	R4,R4,#1	; set R4 to 1 bc neg value
  ADD	R3,R3,#1	; set R3 to 1 [sign symbol used]
  ADD	R6,R6,#-1	; decrement
  BRnzp	LOOP		; iterate
LESS_48
  ;check for '+'
  LD	R7,PLUS
  ADD	R1,R0,#0
  ADD	R1,R1,R7
  BRz	IS_PLUS		; check if '+'
  
  ;check for '-'
  LD	R7,MINUS
  ADD	R1,R0,#0
  ADD	R1,R1,R7
  BRz	IS_MINUS	; check if '-'

  ;check if \n
  LD	R7,NEWLINE
  ADD	R1,R0,#0
  ADD	R1,R1,R7
  BRz	IS_NEWLINE	; check if '\n'
;if input < 48, is not '+', is not '-', is not '\n', then wrong. 

GREATER_57		;if input > 57, error
  ADD	R1,R0,#0
  ADD	R1,R1,#-10
  BRnp	OUTPUT_ERROR_NEWLINE
GREATER	
  LEA	R0,Error_message_2
  PUTS
  BRnzp	BEGINNING	; start over
END
  ; check sign bit, perform two's complement or not
  ADD	R1,R4,#0	; copy current sign bit to R1
  ADD	R1,R1,#-1	; decrement
  BRz	NEGATIVE	; < 0 if sign bit = 1, new value = 0
END_SUBR
  LD	R0,NEWLINE_char
  OUT			; print newline
  ADD	R1,R5,#0	; R1 <- R5
; check if 0 to 15
  ADD	R1,R1,#0
  BRn	GREATER		; output error and retake input if < 0
  ADD	R2,R1,#-15
  BRp	GREATER		; output error and retake input if NUM - 15 > 15.
  LD	R7,BACKUP_R7_5400
  RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
BACKUP_R7_5400	.FILL	x0
NEWLINE		.FILL	#-10
MINUS		.FILL	#-45
PLUS		.FILL	#-43
NEWLINE_char	.FILL	#10
MINUS_57	.FILL	#-57
MINUS_48	.FILL	#-48
input_count_6	.FILL	#6	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x5700
ST	R7,BACKUP_R7_5700
ADD	R5,R2,#0	
AND	R2,R2,#0
ADD	R6,R5,#0
LOOP_ONE
  LD	R1,TEN_THOUSAND
  ADD	R5,R1,R5
  BRzp	INCREMENT1
  LD	R0,add_48
  ADD	R0,R2,R0
  ADD	R2,R2,#0
  BRz	POST_OUT1
  OUT
POST_OUT1
  ADD	R5,R6,#0
  AND	R2,R2,#0
  BRnzp	LOOP_TWO
INCREMENT1
  ADD	R6,R5,#0
  ADD	R2,R2,#1
  BRnzp	LOOP_ONE
LOOP_TWO
  LD	R1,THOUSAND
  ADD	R5,R1,R5
  BRzp	INCREMENT2
  LD	R0,add_48
  ADD	R0,R2,R0
  ADD	R2,R2,#0
  BRz	POST_OUT2
  OUT
POST_OUT2
  ADD	R5,R6,#0
  AND	R2,R2,#0
  BRnzp	LOOP_THREE
INCREMENT2
  ADD	R6,R5,#0
  ADD	R2,R2,#1
  BRnzp	LOOP_TWO
LOOP_THREE	
  LD	R1,HUNDRED
  ADD	R5,R1,R5
  BRzp	INCREMENT3
  LD	R0,add_48
  ADD	R0,R2,R0
  ADD	R2,R2,#0
  BRz	POST_OUT3
  OUT
POST_OUT3
  ADD	R5,R6,#0
  AND	R2,R2,#0
  BRnzp	LOOP_FOUR
INCREMENT3
  ADD	R6,R5,#0
  ADD	R2,R2,#1
  BRnzp	LOOP_THREE
LOOP_FOUR
  LD	R1,TEN
  ADD	R5,R1,R5
  BRzp	INCREMENT4
  LD	R0,add_48
  ADD	R0,R2,R0
  ADD	R2,R2,#0
  BRz	POST_OUT4
  OUT
POST_OUT4
  ADD	R5,R6,#0
  AND	R2,R2,#0
  BRnzp	LOOP_FIVE
INCREMENT4
  ADD	R6,R5,#0
  ADD	R2,R2,#1
  BRnzp	LOOP_FOUR
LOOP_FIVE
  LD	R1,ONE
  ADD	R5,R1,R5
  BRzp	INCREMENT5
  LD	R0,add_48
  ADD	R0,R2,R0
  OUT
  ADD	R5,R6,#0
  AND	R2,R2,#0
  BRnzp	ENDING
INCREMENT5
  ADD	R6,R5,#0
  ADD	R2,R2,#1
  BRnzp	LOOP_FIVE
ENDING
LD	R7,BACKUP_R7_5700
RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
add_48		.FILL	#48
BACKUP_R7_5700	.FILL	x0
TEN_THOUSAND	.FILL	#-10000
THOUSAND	.FILL	#-1000
HUNDRED		.FILL	#-100
TEN		.FILL	#-10
ONE		.FILL	#-1

.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
