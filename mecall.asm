.text
.globl mecall
mecall:
li t0, 4
li t1, 5
li t2, 8
li t3, 10
li t4, 11
li t5, 12
beq a7, t0, PrintString
beq a7, t1, ReadInt
beq a7, t2, ReadString
beq a7, t3, Exit
beq a7, t4, PrintChar
beq a7, t5, ReadChar

la a0, invalid # if not a correct ecall num
jal PrintString
li a7, 10
b Exit


PrintString:
mv s0, ra # s0 has return address as to not get clobbered
li s1, '\0'
mv s2, a0 # s2 has string starting address
	while:
	lbu a0, (s2)
	beq a0, s1, done # if bite at a0 is null char ret 
	call PrintChar
	addi s2, s2, 1
	b while
	done:
	mv ra, s0 # replace ra
	li s0, 0
	li s1, 0
	li s2, 0
	ret 


ReadInt: # Works for extra credit: keeps reading until enter pressed
mv s0, ra
li s2, 0x0A # load ASCII value for <enter> here for comparison
	repoll:
call ReadChar
li s3, 57 		# 57 is Ascii value of 9 
li s4, 47		# 47 is Ascii value of 0
	beq a0, s2, doneReadInt
	bgt a0, s3, repoll # if ReadChar is greater than 9 then re-polls looking for new input
	ble a0, s4, repoll # if ReadChar is Ascii less than 0
addi a0, a0, -48
add s1, s1, a0 # s1 is counter
b repoll
doneReadInt:
mv a0, s1
li s1, 0
li s2, 0
li s3, 0
li s4, 0
mv ra, s0
ret


ReadString: # reads a string into space allocated in storedWord array, address placed in a0, keeps reading until enter pressed
mv s0, ra # s0 has return address as to not get clobbered
la s1, storedWord # address of place to store
la s3, storedWord # mv this into a0 at end as the address of the stored string
li s2, 0x0A # load ASCII value for <enter> here for comparison
	whileNotEnter: # loops through the characters entered until enter is pressed
	jal ReadChar
		beq a0, s2, enterPressed
		sb a0, (s1)
		addi s1, s1, 1 # increase to the next byte I want to place the next val in
		b whileNotEnter
	enterPressed: # handles adding a null char at the end of the entered string to make sure it is stored correctly
	li s2, 0x00
	sb s2, (s1) # adds the null character to the end of the stored word
mv ra, s0
mv a0, s3
li s0, 0
li s1, 0
li s3, 0
ret

Exit:
la a0, exitMsg
jal PrintString
ecall

PrintChar: #char to print in a0
lw t0, TDR
lw t1, TCR 

lw t2, (t1)
andi t2, t2, 1
beqz t2, PrintChar # re-polls if not ready
sw a0, (t0)

ret

ReadChar: #places char typed in a0
lw t0, RDR
lw t1, RCR

lw t2, (t1)
andi t2, t2, 1 
beqz t2, ReadChar
#beqz t2, notReady # re-polls if no char
lw a0, (t0) 
ret
#notReady: # load null if no char typed
#lw a0, null
#ret

.data
storedWord: .space 20 # reserves space for 20 characters w/ each charecter = 1 byte
RCR: .word 0xffff0000
RDR: .word 0xffff0004
TDR: .word 0xffff000c
TCR: .word 0xffff0008
invalid: .string "invalid or unimplemented syscall service"
