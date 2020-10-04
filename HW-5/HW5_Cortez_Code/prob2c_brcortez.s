.data
prompt: .asciiz "\n\nThe Absolute Sum of Differences is "
test1arr1: .byte 1, 1, 1, 1, 1, 1, 1, 1, 1
test1arr2: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
size1: .word 9

test2arr1: .byte 1, 2, 1, 1, 1, 1
test2arr2: .byte 0, 2, 0, 1, 1, 0
size2: .word 6

test3arr1: .byte 1, 2, 0, 1
test3arr2: .byte 3, 1, 1, 0
size3: .word 4


.text
.globl main
main:

	 addi $s0, $zero, 1
Trial1:  la	$a0, test1arr1
         la	$a1, test1arr2
         lw	$a2, size1
         j Test
        
Trial2:  la	$a0, test2arr1
         la	$a1, test2arr2
         lw	$a2, size2
         j Test
         
Trial3:  la	$a0, test3arr1
         la	$a1, test3arr2
         lw	$a2, size3
         j Test

Test:   addi $s0, $s0, 1	#increment the test counter 
	jal	func		# Save current PC in $ra, and jump to func
        
        la $a0, prompt
        li $v0, 4
        syscall
        
        addi $a0, $v1, 0
        li  $v0, 1
	syscall		#Output sum of absolute differences of the test
	
	beq $s0, 2, Trial2
	beq $s0, 3, Trial3
	li  $v0, 10
	syscall		#Exit


func:   #Compute sum of absolute differences
        addu $v1, $zero, $zero   #Set sum to 0
        addu $t0, $zero, $zero   #Set i to 0
        addu $t1, $zero, $zero   #Set diff to 0
        addiu $t4, $zero, 8      #Set byte overflow length
Loop:   addu $t2, $a0, $t0       #Set $t2 to the address of $a0[$t0]
        lb $t2, 0($t2)          #Load the value of array 1[i]
        addu.qb $t3, $a1, $t0       #Set $t3 to the address of $a1[$t0]
        lb $t3, 0($t3)          #Load the value of array 2[i]
        subu.qb $t1, $t2, $t3       #Set $t1 fo the difference between $t2 and $t3
        absq_s.qb $t1, $t1
Pos:    addu $v1, $v1, $t1       #Add the difference to the sum of differences
        addiu $t0, $t0, 1        #Increment $t0 by 1
        beq $t0, $t4, Exit      #If i = 8, more than a byte long exit
        bne $t0, $a2, Loop      #If i != array len Loop    
Exit:   jr $ra                  #Jump to $ra
