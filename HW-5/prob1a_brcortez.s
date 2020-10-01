        sll $a2, $a2, 2         #Stores the value of $a2 shifted left 2 bits ($a2*4) filled by zeros back into $a2
        sll $a3, $a3, 2         #Stores the value of $a3 shifted left 2 bits ($a3*4) filled by zeros back into $a3
        add $v0, $zero, $zero   #Set $v0 to 0
        add $t0, $zero, $zero   #Set $t0 to 0
Outer:  add $t4, $a0, $t0       #Set $t4 to the address of $a0[$t0]
        lw $t4, 0($t4)          #Load the value of $a0[$t0] (array 1[i])
        add $t1, $zero, $zero   #Set $t1 to 0
Inner:  add $t3, $a1, $t1       #Set $t3 to the address of $a1[$t1]
        lw $t3, 0($t3)          #Load the value of $a1[$t1] (array 2[j])
        bne $t3, $t4, skip      #if 1[i] != 2[j] (values are not equivalent) skip
        addi $v0, $v0, 1        #Increment $v0 by 1
Skip:   addi $t1, $t1, 4        #Set $t1 to $t1+4 (next value)
        bne $t1, $a3, inner     #if $t1 != 2500*4 go to inner
        addi $t0, $t0, 4        #Set $t0 to $t0+4 (next value)
        bne $t0, $a2, outer     #if $t0 != 2500*4 go to outer

        #The code returns the number of identical elements between the arrays in $v0
