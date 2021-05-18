.data

.globl QuestionTable
QuestionTable:
	.word	Q1 Q2 Q3

Q1:      .string  "\nHow much do you love your mother?\n   1: Not much \n   2: Somewhat\n   3: Averagely \n   4: She's the best thing to happen to this world\n"
Q2:    	 .string  "\nHow long ago was your last good deed?\n   1: Now - 2 days ago \n   2: 2 days - 1 week\n   3: 1 week - 2 weeks\n   4: 2+ weeks\n"
Q3:    	 .string  "\nAre you a bad person?\n   1: Yes\n   2: No\n   3: Maybe so\n   4: My name is John Planck\n"

#or just have a bunch of .globl directives.
.globl Q1Answ Q2Answ Q3Answ 
Q1Answ:  .word    1
         .word    2
         .word    5
         .word    10

Q2Answ:  .word    10 8 4 2  #is this different from Q1Answ? (no)
Q3Answ:  .word    10 10 0 100

.globl ResultTable
ResultTable:
         .word Result1	
         .word Result2
         .word Result3	
         .word Result4	

Result1:	.string  " who hurt you?"
Result2:	.string  " my girlfriend wouldn't let me hang out with you."
Result3:	.string  " I'd let you meet my parents."
Result4:	.string  " you are the best!"

.globl answer
answer: 	.string "Answer: "
.globl name
name:		.string "\nWhat is your name: "
.globl exitMsg
exitMsg:	.string "\n-- program is finished running (0) --\n"
