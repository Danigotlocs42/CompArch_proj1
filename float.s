
.section .text
.global fmult

fmult:
    // Arguments:
    // num1, First floating point number, regX0
    // num2, Second floating point number, regX1
    // result, Return value, regX0
    //W#, word is 32bits register
    //X#, doubleword is 64bits register

    
    // Extract sign bits
    LSR W10, W0, #31      // Extract sign of num1
    LSR W11, W1, #31      // Extract sign of num2
    EOR W12, W10, W11     // Compute sign of result

    // Extract exponents (bits 30-23)
    LSR W10, W0, #23      // Shift right to get exponent
    LSR W11, W1, #23
    AND W10, W10, #0xFF   // Mask to get 8-bit exponent
    AND W11, W11, #0xFF

    // Compute new exponent: exp1 + exp2 - bias (127), for 32-bits 
    ADD W10, W10, W11
    SUB W10, W10, #127    // Adjust bias

    // Extract mantissas and add implicit leading 1
    ORR W0, W0, #0x00800000  // Add hidden bit (1.XXX)
    ORR W1, W1, #0x00800000
    AND W0, W0, #0x00FFFFFF  // Mask to 24 bits
    AND W1, W1, #0x00FFFFFF

    // Multiply mantissas (low 24-bits of each)
    UMULH X2, X0, X1       // Multiply high part, upper
    MUL X0, X0, X1         // Multiply low part

    // Normalize if needed
    LSR X3, X2, #23        // Get most significant bit
    CBZ X3, skip_norm      // If zero, skip normalization and branch back 

    // Shift mantissa to the right, increase exponent
    LSR X0, X0, #1
    ADD W10, W10, #1

skip_norm:
    // Rounding: check GRS -> guard, round, sticky bits (assume round to nearest even num)
    AND X4, X0, #0x7F      // Extract GRS bits 
    LSR X5, X0, #7         // Drop these bits
    CMP X4, #0x40          // Check if rounding is needed
    B.LT no_round
    ADD X5, X5, #1         // If needed, round up

no_round:
    // Reconstruct result: sign(1) + exponent(8) + mantissa(23)
    LSL X12, X12, #31      // Move sign bit
    LSL X10, X10, #23      // Move exponent
    ORR X0, X12, X10       // Combine sign and exponent
    ORR X0, X0, X5         // Combine with mantissa

    RET
