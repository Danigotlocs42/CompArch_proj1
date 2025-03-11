
.section .data
num1: .word 0xC1002F7D   // -8.0546875 in IEEE 754
num2: .word 0xBE333333   // -0.179931640625 in IEEE 754

.section .text
.global _start

_start:
    LDR W0, =num1
    LDR W1, =num2
    BL fmult   // Call multiplication
    // Result in W0

    // Exit program
    MOV X8, #93  // Exit syscall
    SVC 0


