        addu $v1, $zero, $zero   #Set sum to 0
        addu $t0, $zero, $zero   #Set i to 0
        addu $t1, $zero, $zero   #Set diff to 0
        addiu $t4, $zero, 8      #Set byte overflow length
Loop:   addu $t2, $a0, $t0       #Set $t2 to the address of $a0[$t0]
        lb $t2, 0($t2)          #Load the value of array 1[i]
        addu $t3, $a1, $t0       #Set $t3 to the address of $a1[$t0]
        lb $t3, 0($t3)          #Load the value of array 2[i]
        subu $t1, $t2, $t3       #Set $t1 fo the difference between $t2 and $t3
        bgt $t1, $zero, Pos     #If diff is positive skip the sign switch step
        subu $t1, $zero, $t1     #Subtract the diff from zero to get the positive equivalent
Pos:    addu $v1, $v1, $t1       #Add the difference to the sum of differences
        addiu $t0, $t0, 1        #Increment $t0 by 1
        beq $t0, $t4, Exit      #If i = 8, more than a byte long exit
        bne $t0, $a2, Loop      #If i != array len Loop    
Exit:   jr $ra                  #Jump to $ra