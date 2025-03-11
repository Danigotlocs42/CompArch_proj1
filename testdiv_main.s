
.section .data
num1: .word 0x42AC0000   // 86.25 in IEEE 754
num2: .word 0xC09C0000   // -4.875 in IEEE 754

.section .text
.global _start

_start:
    LDR W0, =num1   
    LDR W1, =num2   
    BL fdiv    // Call division
    // Result in w0

    // Exit program
    MOV X8, #93  // Exit syscall
    SVC 0

