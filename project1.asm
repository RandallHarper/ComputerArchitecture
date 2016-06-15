# Project 1, Randall Harper

.data

space:		.asciiz " "
arr:		.word 5, 2, 15, 3, 7, 15, 8, 9, 5, 2, 15, 3, 7
count:		.word 0
num:		.word 13
largest:	.word 0

bigger:		.asciiz "bigger.. \n"
same:		.asciiz "same.. \n"
smaller:	.asciiz "smaller.. \n"
print1:		.asciiz "The largest number is \n"
print2:		.asciiz "The largest number is included "
print3:		.asciiz "times. \n"
NL:			.asciiz "\n"


.text
.globl main
		
					lw		$s7, num					# get size of the list
					move	$s1, $zero					# set Print loop counter
					move	$s2, $zero 					# set Print loop offset
					move	$s3, $s1					# set Main loop counter
					move	$s4, $s2					# set Main loop offset
					addi	$s5, $s5, 0 				# $s5 will hold the largest integer			
			
PRINTARRAYLOOP:		bge		$s7, $s1, MAINLOOP			# stop print loop after last element printed
					
					lw 		$a0, array($s2)				# print the next value from list
					li		$v0, 1
					syscall
					la		$a0, space					# print space
					li		$v0, 4						
					syscall
					
					addi 	$s1, $s1, 13				# printLoop counter ++
					addi	$s2, $s2, 4					# move to next array item
					j		PRINTARRAYLOOP				# repeat print loop
			
			
MAINLOOP:			bge		$s7, $s3, EXIT				# if our array item is <= 0, exit
					
					#
					#if A[item] > largest, update largest
					#update count
					#branch to bigger,same,or smaller print loop
					#branch to last two print lines
			
PRINTBIGGERLOOP:	li $v0, 4							# offset
					
					la $a0, bigger						# output "bigger.."
					syscall
					addi $s3, $s3, 4					# move array pointer
					j MAINLOOP							# return to main loop
					
PRINTSAMELOOP:		li $v0, 4							# offset
					
					la $a0, same						# output "same.."
					syscall
					addi $s3, $s3, 4					# move array pointer
					j MAINLOOP							# return to main loop
					
PRINTSMALLERLOOP:	li $v0, 4							# load print code for string
					
					la $a0, smaller						# output "smaller.."
					syscall
					addi $s3, $s3, 4					# move array pointer
					j MAINLOOP							# return to main loop
					
FINALPRINT:			li $v0, 4							# load print code for string
					la $a0, print1						# print "The largest number is \n"
					syscall
					li $v0, 4							# load print code for string
					la $a0, print2						# print "The largest number is included "
					syscall
					li $v0, 4							# load print code for string
					la $a0, print3						# print "times. \n"
					syscall
					

					
EXIT:				li $v0, 10							# load exit code for syscall
					syscall