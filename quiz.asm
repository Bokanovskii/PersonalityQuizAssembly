.text

main:
li s10, 0 # s0 will be the point count

PromptName:
li a7, 4
la a0, name
call mecall 
li a7, 8
call mecall
mv s11, a0 # s11 holds address of input name
li a7, 4
call mecall

Question1:
lw a0, QuestionTable # address of first question stored here
li a7, 4
call mecall # prompts first question
jal getAnswer # num placed in a0
la a1, Q1Answ
jal getPoints

Question2:
la a1, QuestionTable
addi a1, a1, 4 # address of second question stored here
lw a0, (a1)
li a7, 4
call mecall # prompts second question
jal getAnswer # num placed in a0
la a1, Q2Answ
jal getPoints

Question3:
la a1, QuestionTable
addi a1, a1, 8 # address of second question stored here
lw a0, (a1)
li a7, 4
call mecall # prompts second question
jal getAnswer # num placed in a0
la a1, Q3Answ
jal getPoints

Result:
li t0, 10
li t1, 20
li t2, 100
la a1, ResultTable
li a7, 11
li a0, '\n'
call mecall
li a7, 4
mv a0, s11
call mecall # prints input name
li a0, ','
li a7, 11
call mecall #prints coomma

ble s10, t0, loadResult1
ble s10, t1, loadResult2
ble s10, t2, loadResult3

loadResult4: # if points > 100
addi a1, a1, 12 # address of fourth result stored here
lw a0, (a1)
b printResult

loadResult3: # if points  <= 100
addi a1, a1, 8 # address of third result stored here
lw a0, (a1)
b printResult

loadResult2: # if points <= 20
addi a1, a1, 4 # address of second result stored here
lw a0, (a1)
b printResult

loadResult1: # if points <= 10
lw a0, (a1)

printResult:
li a7, 4
call mecall # prints the correct string

loop:
b main

	
getAnswer:
la a0, answer
li a7, 4
mv s9, ra
call mecall
li a7, 5
call mecall # reads an int -> placed in a0 (integers start at 0x30 - 0x34)
li a7, 11
addi a0, a0, 48
call mecall # prints the answer typed
mv ra, s9
li s9, 0
ret

getPoints:

addi a0, a0, -49
li t1, 4
mul a0, a0, t1
add a1, a0, a1 # increment the address based on num 1 - 4 pressed, need to increment by 4 * a0 bytes
lw a2, (a1)
add s10, s10, a2
ret
