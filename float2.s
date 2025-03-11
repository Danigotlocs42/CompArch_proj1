
.section .text
.global fdiv

fdiv:
    // Arguments:
    // num1, Dividend/numerator, reg X0  
    // num2, Divisor/denominator, reg X1
    // result, Return value, reg X0 
    //W#, word is 32bits register
    //X#, doubleword is 64bits register


    // Extract sign bits
    LSR W10, W0, #31
    LSR W11, W1, #31
    EOR W12, W10, W11    // Compute result sign

    // Extract exponents (bits 30-23)
    LSR W10, W0, #23
    LSR W11, W1, #23
    AND W10, W10, #0xFF
    AND W11, W11, #0xFF

    // Compute new exponent: exp1 - exp2 + bias (127), FOR 32bits
    SUB W10, W10, W11
    ADD W10, W10, #127    // Adjust bias

    // Extract mantissas
    ORR W0, W0, #0x00800000
    ORR W1, W1, #0x00800000
    AND W0, W0, #0x00FFFFFF
    AND W1, W1, #0x00FFFFFF

    // Perform division (integer division of mantissas)
    UDIV X0, X0, X1

    // Normalize if needed
    CMP X0, #0x00800000   // Check if mantissa is normalized, then branch back
    B.GE skip_norm

    // Shift mantissa left, decrease exponent
    LSL X0, X0, #1
    SUB W10, W10, #1

skip_norm:
    // Rounding, GRS -> guard, round, sticky bits, round to nearest even num 
    AND X4, X0, #0x7F
    LSR X5, X0, #7
    CMP X4, #0x40
    B.LT no_round
    ADD X5, X5, #1

no_round:
    // Reconstruct result: sign(1) + exponent(8) + mantissa(23)
    LSL X12, X12, #31
    LSL X10, X10, #23
    ORR X0, X12, X10
    ORR X0, X0, X5

    RET
