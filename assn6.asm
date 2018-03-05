;=================================================
; Name: Theodore Nguyen
; Email: tnguy223@ucr.edu
; 
; Assignment name: Assignment 6
; Lab section: 1
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
MAIN_LOOP
	LD	R1,MENU_ADDR		;call MENU
	JSRR	R1
	ADD	R6,R1,#0		;copy the option returned by MENU into R6
	ADD	R6,R6,#-1
	BRz	OPTION_1
	
	ADD	R6,R1,#0
	ADD	R6,R6,#-2
	BRz	OPTION_2

	ADD	R6,R1,#0
	ADD	R6,R6,#-3
	BRz	OPTION_3
	
	ADD	R6,R1,#0
	ADD	R6,R6,#-4
	BRz	OPTION_4
	
	ADD	R6,R1,#0
	ADD	R6,R6,#-5
	BRz	OPTION_5
	
	ADD	R6,R1,#0
	ADD	R6,R6,#-6
	BRz	OPTION_6
	
	ADD	R6,R1,#0
	ADD	R6,R6,#-7
	BRz	OPTION_7
;you should nehver get here if MENU is returning proper numbers
	LEA	R0,Goodbye
	PUTS
	PUTS
	BRnzp 	OPTION_7
OPTION_1
	LD	R0,ALL_MACHINES_BUSY_ADDR
	JSRR	R0
	ADD	R2,R2,#0
	BRz	NOT_ALL_BUSY
	LEA	R0,ALLBUSY
	PUTS
	BRnzp	MAIN_LOOP
NOT_ALL_BUSY
	LEA	R0,ALLNOTBUSY
	PUTS
	BRnzp	MAIN_LOOP

OPTION_2
	LD	R0,ALL_MACHINES_FREE_ADDR
	JSRR	R0
	ADD	R2,R2,#0
	BRz	NOT_ALL_FREE
	LEA	R0,FREE
	PUTS
	BRnzp	MAIN_LOOP
NOT_ALL_FREE
	LEA	R0,NOTFREE
	PUTS
	BRnzp	MAIN_LOOP

OPTION_3	
	LD	R0,NUM_BUSY_MACHINES_ADDR
	JSRR	R0
	LEA	R0,BUSYMACHINE1
	PUTS
	
	LD	R0,PRINT_NUMBER_ADDR
	JSRR	R0

	LEA	R0,BUSYMACHINE2
	PUTS
	BRnzp	MAIN_LOOP
OPTION_4
	LD	R0,NUM_FREE_MACHINES_ADDR
	JSRR	R0
	LEA	R0,FREEMACHINE1
	PUTS
	
	LD	R0,PRINT_NUMBER_ADDR
	JSRR	R0

	LEA	R0,FREEMACHINE2
	PUTS
	BRnzp	MAIN_LOOP
OPTION_5
	LD	R0,GET_INPUT_ADDR		;load address of subroutine that takes integer input
	JSRR 	R0				;jump to subroutine
	LD	R0,MACHINE_STATUS_ADDR		
	JSRR	R0
	LEA	R0,STATUS1
	PUTS
	ST	R2,MACHINE_STATUS_RESULT
	ADD	R2,R1,#0
	LD	R0,PRINT_NUMBER_ADDR
	JSRR	R0
	LD	R2,MACHINE_STATUS_RESULT
	BRp	MACHINE_STATUS_IS_FREE
	LEA	R0,STATUS2
	PUTS
	BRnzp	MAIN_LOOP
MACHINE_STATUS_IS_FREE
	LEA	R0,STATUS3
	PUTS
	BRnzp	MAIN_LOOP
OPTION_6
	LD	R0,FIRST_FREE_ADDR
	JSRR	R0
	ADD	R0,R2,#-16
	BRz	NOFREEADDRS
	LEA	R0,FIRSTFREE
	PUTS
	LD	R0,PRINT_NUMBER_ADDR
	JSRR	R0
	LEA	R0,FIRSTFREE2
	PUTS
	BRnzp	MAIN_LOOP
NOFREEADDRS
	LEA	R0,FIRSTFREE3
	PUTS
	BRnzp	MAIN_LOOP

OPTION_7
	LEA	R0,Goodbye
	PUTS
	HALT
;---------------	
;Data
;---------------
;Add address for subroutines
	MENU_ADDR	.FILL	x3300
	ALL_MACHINES_BUSY_ADDR	.FILL	x3600
	ALL_MACHINES_FREE_ADDR	.FILL	x3900
	NUM_BUSY_MACHINES_ADDR	.FILL	x4200
	NUM_FREE_MACHINES_ADDR	.FILL	x4500
	MACHINE_STATUS_ADDR	.FILL	x4800
	FIRST_FREE_ADDR		.FILL	x5100
	GET_INPUT_ADDR		.FILL	x5400
	PRINT_NUMBER_ADDR	.FILL	x5700
;Other data 
	toASCII		.FILL	#48
	MACHINE_STATUS_RESULT	.FILL	xFFFF
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





.orig x3300
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
;HINT back up 
	ST	R7,menu_R7_store		;store return address
MENU_BEGINNING
	LD	R0,Menu_string_addr		;load menu intro message & print
	PUTS
	
	GETC					;takes an input
	OUT					;prints input char
	ADD	R1,R0,#0			;copy input char to R1
	AND	R0,R0,#0
	ADD	R0,R0,#10
	OUT
	ADD	R0,R1,#0
	;check if inputted char < 1
	LD	R2,MENU_minus_48		
	ADD	R1,R1,R2
	ADD	R1,R1,#-1			
	BRn	MENU_ERROR
	;check if inputted char > 7
	ADD	R1,R0,#0
	LD	R2,MENU_minus_55
	ADD	R1,R1,R2
	BRp	MENU_ERROR
	ADD	R1,R0,#0
	LD	R2,MENU_minus_48
	ADD	R1,R1,R2
	BRnzp	MENU_END
	;if here, then 1 <= inputted char <= 7. go to end.
MENU_ERROR
	LEA	R0,Error_message_1		;load and print error
	PUTS
	BRnzp	MENU_BEGINNING
MENU_END
;HINT Restore
	AND	R0,R0,#0
	AND	R2,R2,#0
	LD	R7,menu_R7_store		;reload return address and return
	RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"	;error string
Menu_string_addr .FILL x6000			;input message string
menu_R7_store	.FILL	x0			;return addres storage
MENU_minus_48	.FILL	#-48
MENU_minus_55	.FILL	#-55




.orig x3600
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 
	ST	R7,ALL_MACHINES_BUSY_R7

	LD	R6,BUSYNESS_ADDR_ALL_MACHINES_BUSY	;load busyness vec addr to R6
	LDR	R1,R6,#0			;load busyness vec into R1
	LD	R3,ALL_MACHINES_BUSY_16bit_ctr	;load 16 bit ctr to parse bits
	AND	R2,R2,#0		;set return to 0; default not all machinesbusy
ALL_MACHINES_BUSY_LOOP
	ADD	R1,R1,#0		;set the busyness vec reg as last used reg
	BRn	ALL_MACHINES_BUSY_END	;if neg, 1stbit = 1;at least one free 
				;machine, so not all machines are busy. Return 0 (R2
				;is already set to 0 by default, so go to end
	ADD	R1,R1,R1		;bit shift to the left the busyness vec
	ADD	R3,R3,#-1		;decrease 16 bit parsing ctr
	BRp	ALL_MACHINES_BUSY_LOOP	;while there is still bits to parse, go loop
;if here, then there are no more bits to parse & no bits were 1 (no machines free)
;meaning that all machines are busy. set return value to 1 and go to the end.
	ADD	R2,R2,#1		
ALL_MACHINES_BUSY_END
;HINT Restore
	AND 	R0,R0,#0
	AND	R1,R1,#0
	AND	R3,R3,#0
	AND	R6,R6,#0
	LD	R7,ALL_MACHINES_BUSY_R7
	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB000
ALL_MACHINES_BUSY_R7	.FILL	x0
ALL_MACHINES_BUSY_16bit_ctr	.FILL	#16




.orig x3900
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 
	ST	R7,ALL_MACHINES_FREE_R7
	LD	R6,BUSYNESS_ADDR_ALL_MACHINES_FREE
	LDR	R1,R6,#0
	LD	R3,ALL_MACHINES_FREE_16bit_ctr
	AND	R2,R2,#0
ALL_MACHINES_FREE_LOOP
	ADD	R1,R1,#0
	BRzp	ALL_MACHINES_FREE_END
	ADD	R1,R1,R1
	ADD	R3,R3,#-1
	BRp	ALL_MACHINES_FREE_LOOP
	ADD	R2,R2,#1	

ALL_MACHINES_FREE_END
;HINT Restore
	AND	R0,R0,#0
	AND	R1,R1,#0
	AND	R3,R3,#0
	AND	R6,R6,#0
	LD	R7,ALL_MACHINES_FREE_R7
	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB000
ALL_MACHINES_FREE_R7	.FILL	x0
ALL_MACHINES_FREE_16bit_ctr	.FILL	#16



.orig x4200
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 
	ST	R7,NUM_BUSY_MACHINES_R7
	LD	R6,BUSYNESS_ADDR_NUM_BUSY_MACHINES
	LDR	R1,R6,#0
	LD	R3,NUM_BUSY_MACHINES_16bit_ctr
	AND	R2,R2,#0
NUM_BUSY_MACHINES_LOOP
	ADD	R1,R1,#0
	BRzp	NUM_BUSY_MACHINES_INCREMENT
POST_CHECK_NUM_BUSY_MACHINES
	ADD	R1,R1,R1
	ADD	R3,R3,#-1
	BRp	NUM_BUSY_MACHINES_LOOP
	BRnzp	NUM_BUSY_MACHINES_END	

NUM_BUSY_MACHINES_INCREMENT
	ADD	R2,R2,#1
	BRnzp	POST_CHECK_NUM_BUSY_MACHINES	

NUM_BUSY_MACHINES_END
;HINT Restore
	LD	R7,NUM_BUSY_MACHINES_R7
	RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB000
NUM_BUSY_MACHINES_R7	.FILL	x0
NUM_BUSY_MACHINES_16bit_ctr	.FILL #16



.orig x4500
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
	ST	R7,NUM_FREE_MACHINES_R7
	LD	R6,BUSYNESS_ADDR_NUM_FREE_MACHINES
	LDR	R1,R6,#0
	LD	R3,NUM_FREE_MACHINES_16bit_ctr
	AND	R2,R2,#0
NUM_FREE_MACHINES_LOOP
	ADD	R1,R1,#0
	BRn	NUM_FREE_MACHINES_INCREMENT
POST_CHECK_NUM_FREE_MACHINES
	ADD	R1,R1,R1
	ADD	R3,R3,#-1
	BRp	NUM_FREE_MACHINES_LOOP
	BRnzp	NUM_FREE_MACHINES_END
NUM_FREE_MACHINES_INCREMENT
	ADD	R2,R2,#1
	BRnzp	POST_CHECK_NUM_FREE_MACHINES
NUM_FREE_MACHINES_END
;HINT Restore
	LD	R7,NUM_FREE_MACHINES_R7
	RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB000
NUM_FREE_MACHINES_R7	.FILL	x0
NUM_FREE_MACHINES_16bit_ctr	.FILl	#16





.orig x4800
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
;HINT back up 
	ST	R7,MACHINE_STATUS_R7
		
	ADD	R6,R1,#0			;copy machine number we want to check in R1 to R6
	LD	R4,FIFTEEN			;load 15 into R4
	NOT	R6,R6				;flip bits of machine number we want to check
	ADD	R6,R6,#1			;add 1 to machine number we want to check 4 2's comp
	ADD	R4,R4,R6			;R4 <-- 15 - num_want_to_check. Now, R4= # left shifts

	LD	R6,BUSYNESS_ADDR_MACHINE_STATUS
	LDR	R2,R6,#0
MACHINE_STATUS_PRELOOP
	ADD	R4,R4,#0
	BRz	DETERMINE_STATUS	;if already 0, then dont enter do-while;
MACHINE_STATUS_LOOP
	ADD	R2,R2,R2	
	ADD	R4,R4,#-1
	BRp	MACHINE_STATUS_LOOP

DETERMINE_STATUS
	ADD	R2,R2,#0
	BRzp	MACHINE_IS_BUSY
	AND	R2,R2,#0
	ADD	R2,R2,#1
	BRnzp	MACHINE_STATUS_END
MACHINE_IS_BUSY
	AND	R2,R2,#0
MACHINE_STATUS_END
;HINT Restore
	AND	R3,R3,#0
	AND	R4,R4,#0
	AND	R6,R6,#0
	LD	R7,MACHINE_STATUS_R7
	RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xB000
MACHINE_STATUS_R7	.FILL	x0
FIFTEEN		.FILL	#15




.orig x5100
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
;HINT back up 
	ST	R7,FIRST_FREE_R7		;save return address
	
	LD	R6,BUSYNESS_ADDR_FIRST_FREE	;load address of busyness vec to R6
	LDR	R1,R6,#0			;load actual busyness vec into R1
	AND	R2,R2,#0	;set R2=0; this will be our "lower" (outer) counter
	AND	R3,R3,#0	
	ADD	R3,R3,#15	;set R3=15; this will be our "upper" (inner) counter

FIRST_FREE_LOOP
	ADD	R3,R3,#0		
	BRz	FIRST_FREE_CHECK	;this is 15th bit
	ADD	R1,R1,R1			;bit shift the busyness vec
	ADD	R3,R3,#-1			;a total of R3 times
	BRp	FIRST_FREE_LOOP
FIRST_FREE_CHECK	
	ADD	R1,R1,#0			;if R1 is negative, then bit R2 is the first free
	BRn	FIRST_FREE_END
	ADD	R2,R2,#1		;if not, we check bit R2+1
	AND	R3,R3,#0		;to do this, we want to shift 15 - (R2 + 1) times
	ADD	R3,R3,#15
	NOT	R7,R2
	ADD	R7,R7,#1
	ADD	R3,R3,R7
	ADD	R7,R2,#-16
	BRz	FIRST_FREE_END	;there is no free-leave R2 as 16
	LDR	R1,R6,#0		;and then reload our bit vec to bit shift again
	BRnzp	FIRST_FREE_LOOP
FIRST_FREE_END
;HINT Restore
	LD	R7,FIRST_FREE_R7
	RET

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB000
FIRST_FREE_R7	.FILL	x0







.orig x5400
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

	ST	R7,GET_INPUT_R7
BEGINNING
	LEA	R0,prompt  
	PUTS

	
;R0:input;R1:working register;R3:use symbol?;R4:what sign?;R5:actual value;R6:counter;R7:work
	LD	R6,input_counter	;can input max 6 chars	PARSING COUNTER
	AND	R5,R5,#0		;clear R5.		ROLLING SUM
	AND	R4,R4,#0		;clear R4.		SIGN BIT. DEFAULT 0=pos,1=neg
	AND	R3,R3,#0		;clear R3.		SYMBOL BIT.0=no,1=yes
	
LOOP			;Main loop
	GETC			;input a char to R0 and echo it	
	ADD	R1,R0,#0
	LD	R7,NEWLINE
	ADD	R1,R1,R7
	BRnp	OUTPUT_CHAR
POST_OUT
	;if this is less than 48
	ADD	R1,R0,#0	;copy inputted char to R1
	LD	R7,MINUS_48	;load -48 to check against inputted value
	ADD	R1,R1,R7	; R1 <- inputted char - 48
	BRn	LESS_48		;if inputted char is negative, then it is less than 48 (0)
	
	;if this is greater than 57
	ADD	R1,R0,#0	;copy inputted char to R1
	LD	R7,MINUS_57	;load -57 to check against inputted value
	ADD	R1,R1,R7	;R1 <- inputted char - 57
	BRp	GREATER_57	;if inputted char is positive, then it is > than 57 (9)

;we have deduced inputted char x satisfies 48 < x < 57. 
	
	;if this is the first character
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRz	FIRST_CHAR	;react slightly differently if this 1st char is digit
	;if this is not the first char, react normally. First multiply R5 by 10
	ADD	R5,R5,R5	; 2x = x + x
	ADD	R7,R5,R5	; 4x = 2x + 2x
	ADD	R7,R7,R7	; 8x = 4x + 4x
	ADD	R5,R5,R7	; 10x = 2x + 8x
	;then add the inputted char to R5
	LD	R7,MINUS_48	;load conv to dec from ASCII for digits
	ADD	R0,R0,R7	;convert to decimal for inputted char
	ADD	R5,R5,R0	;finally, add decimal inputted char to 10*previous sum.
	;decrement counter and branch accordingly
	ADD	R6,R6,#-1	;decrement counter
	BRp	LOOP		;if we can input more, go back to beginning of loop
	BRz	END		;if no more input chars, go to end. if this counter is less
					;than zero somehow, we know we have a problem

OUTPUT_CHAR
	OUT
	BRnzp	POST_OUT

OUTPUT_ERROR_NEWLINE
	LD	R0,NEWLINE_char
	OUT
	BRnzp	GREATER

NEGATIVE
	;perform two's complement and be done with it
	NOT	R5,R5		;flip bits of R5
	ADD	R5,R5,#1	;add 1 to R5 to get the negative value
	BRnzp	REALLY_THE_END

FIRST_CHAR
	;the first char inputted was a digit! react accordingly.
		;this is the first char, so R5 is zero. just need to add inputted char to R5
			;and decrement the counter by 2 instead of 1.We don't need to multi
			;R5 because this is the first char and R5 SHOULD be 0.
	LD	R7,MINUS_48	;load conv from ASCII to DEC
	ADD	R0,R0,R7	;convert inputted char to decimal from ascii
	ADD	R5,R0,R5	;perform R5 <-- inputted dec val + R5. (R5 is 0 initially)
	ADD	R6,R6,#-2	;decrease counter by TWO since we don't use a sign bit. 
	BRnzp	LOOP

IS_NEWLINE
	;if this is a newline, check if it is the first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRz	OUTPUT_ERROR_NEWLINE	;if 0, then 1st char = newline. ERROR.
	;if this is a newline, now check if it is the second char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-5	;subtract 5 from current counter
	BRnp	END		;if the result is nonzero, then isnt second char. go to end.
;if we are here, then the newline was the second char. check if symbol flag is 1
	ADD	R1,R3,#0	;copy symbol flag to R1
	ADD	R1,R1,#-1	;subtract 1
	BRz	OUTPUT_ERROR_NEWLINE ;if the result is 0, then the symbol flag was 1. This means
					;that 1st char = sign, 2nd char = newline. ERROR.
;if we are here, then newline was 2nd char and the first char was NOT a sign symbol.
	BRnp	END		;then we go to the end. R5 should be 1 digit dec number.

IS_PLUS
	;if this is a plus, check if it the first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRnp	GREATER_57	;if result!=0, then isnt first char. error. 
	;at this point, if we are here, then symbol is a + AND it IS the first char.
	ADD	R4,R4,#0	;we are supposed to set R4 to 0 - but it should ALREADY be 0.
	ADD	R3,R3,#1	;set flag for sign symbol use = 1. 
	ADD	R6,R6,#-1	;decrease counter by 1
	BRnzp	LOOP		;go to next iteration

IS_MINUS
	;if this is a minus, check if it is first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRnp	GREATER_57	;if result!=0, then isnt first char. Error.
	;at this point, if we are here, then the symbol is a - AND it is the first char.
	ADD	R4,R4,#1	;set R4 to 1 as value entered is to be negative.
	ADD	R3,R3,#1	;set R3 to 1 as the sign symbol has been used
	ADD	R6,R6,#-1	;decrease counter by 1
	BRnzp	LOOP		;go to next iteration

LESS_48
	;check if this is a plus symbol first.
	LD	R7,PLUS		;load plus ascii value 
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_PLUS		;has to be zero if is plus symbol. do stuff
	
	;check if this is a minus symbol next
	LD	R7,MINUS	;load minus ascii value
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_MINUS	;has to be zero if is minus symbol. do stuff

	;check if this a newline symbol next
	LD	R7,NEWLINE	;load newline ascii value
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_NEWLINE	;has to be zero if is newline symbol. do stuff.
;if char is < 48, is not +, is not -, is not \n, then this is an error. 
;NEWLINEFIRSTCHAR
;	ADD	R7,R0,#0
;	AND	R0,R0,#0
;	ADD	R0,R0,#10
;	OUT
;	ADD	R0,R7,#0

GREATER_57	;if inputted char > 57, this is ALWAYS going to be an error.
	ADD	R1,R0,#0
	ADD	R1,R1,#-10
	BRnp	OUTPUT_ERROR_NEWLINE
GREATER	
	LEA	R0,Error_message_2;print error message
	PUTS
	BRnzp	BEGINNING	;go to the beginning because f'd up

END
	;just need to check sign bit and perform two's complement (or not) now.
	ADD	R1,R4,#0	;copy current sign bit to R1
	ADD	R1,R1,#-1	;subtract -1 from sign bit
	BRz	NEGATIVE	;is negative if sign bit was 1. (aka if new value is 0).
REALLY_THE_END
;might have been the end in assignment 4, but not anymore!

	LD	R0,NEWLINE_char	;load newline
	OUT			;print newline
	
	ADD	R1,R5,#0		;copy our inputted val to R1 from R5
;now check if is in range 0 to 15!
	ADD	R1,R1,#0
	BRn	GREATER		;will output error and retake input if negative meaning if < 0
	ADD	R2,R1,#-15
	BRp	GREATER		;will output error and retake input if NUM - 15 =< 0, meaning if > 15.

	LD	R7,GET_INPUT_R7
	RET
	
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
GET_INPUT_R7	.FILL	x0
NEWLINE		.FILL	#-10
MINUS		.FILL	#-45
PLUS		.FILL	#-43
NEWLINE_char	.FILL	#10
MINUS_57	.FILL	#-57
MINUS_48	.FILL	#-48
input_counter	.FILL	#6



.orig x5700
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: a numerical value in R2
; Postcondition: 
; The subroutine prints the number that is in R2
; Return Value : none
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to print the number to the user WITHOUT leading 0's and DOES NOT output the '+' 
;	for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
	ST	R7,return_address
	ADD	R5,R2,#0	

	AND	R2,R2,#0
	ADD	R6,R5,#0
LOOP1
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
	BRnzp	LOOP2
INCREMENT1
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP1

LOOP2
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
	BRnzp	LOOP3
INCREMENT2
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP2

LOOP3	
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
	BRnzp	LOOP4
INCREMENT3
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP3

LOOP4
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
	BRnzp	LOOP5
INCREMENT4
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP4

LOOP5
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
	BRnzp	LOOP5

ENDING
	LD	R7,return_address
	RET

;--------------------------------
;Data for subroutine print number
;--------------------------------
	add_48		.FILL	#48
	return_address	.FILL	x0
	TEN_THOUSAND	.FILL	#-10000
	THOUSAND	.FILL	#-1000
	HUNDRED		.FILL	#-100
	TEN		.FILL	#-10
	ONE		.FILL	#-1
	


.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!









;---------------	
;END of PROGRAM
;---------------	
.END
