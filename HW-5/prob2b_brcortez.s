        .text

        .globl main
main:
        #TODO parts of main and data


        # Register assignments
        # $s0 = x
        # $s1 = y

        # Initialize registers
        lw	$s0, x		# Reg $s0 = x
        lw	$s1, y		# Reg $s1 = y

        # Call function
        move	$a0, $s0	# Argument 1: x ($s0)
        jal	func		# Save current PC in $ra, and jump to func
        move	$s1,$v0		# Return value saved in $v0. This is y ($s1)


func:   #Compute sum of absolute differences
        sll $a2, $a2, 2         #Stores the value $a2*4
        add $v0, $zero, $zero   #Set sum to 0
        add $t0, $zero, $zero   #Set i to 0
        add $t1, $zero, $zero   #Set diff to 0
        addi $t4, $zero, 8      #Set byte overflow length
Loop:   add $t2, $a0, $t0       #Set $t2 to the address of $a0[$t0]
        lw $t2, 0($t2)          #Load the value of array 1[i]
        add $t3, $a1, $t0       #Set $t3 to the address of $a1[$t0]
        lw $t3, 0($t3)          #Load the value of array 2[i]
        sub $t1, $t2, $t3       #Set $t1 fo the difference between $t2 and $t3
        blt $t1, $zero, Pos     #If diff is positive skip the sign switch step
        sub $t1, $zero, $t1     #Subtract the diff from zero to get the positive equivalent
Pos:    add $v0, $v0, $t1       #Add the difference to the sum of differences
        addi $t0, $t0, 1        #Increment $t0 by 1
        beq $t0, $t4, Exit      #If i = 8, more than a byte long exit
        bne $t0, $a2, Loop      #If i != array len Loop    
Exit:   jr $ra                  #Jump to $ra


	.data
x:	.word 5
y:	.word 0