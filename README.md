# CompArch_proj1
EEL4713_301: Computer Architecture Project 1 

Project 1: FP Multiplication and Division Program 
Purpose 
Learn to implement a multiplication algorithm in assembly. Learn to 
carry out arithmetic operations using a floating-point representation of 
real numbers.  
Method 
Write assembly code to implement a function for floating-point 
multiplication.Similarly, also write assembly code to implement a 
function for floating-point division. 
Preparation 
Read Chapter 3 in the textbook. Review Chapter 3: Fig. 3.5 and Fig. 3.11 
for the multiplication and division algorithms, respectively. Also use 
Raspberry Pi to test your program. 
Description of the project: 
Files to be named and worked on 
main.s, float.s 
What to hand in 
The tested float.s, float2.s, main.s, makefile and your report. 
Report 
Completed report with the program and testing results in hard copies to 
be collected before the class meeting. 
The file float.s will contains your LEGv8 assembly code for a function 
fmult that multiplies two numbers in IEEE 754 single precision floating point 
format. The file main.s contains a program for testing the multiplication 
function. 
1. Write the assembly code for the fmult function. You can convert the 
multiplicand and multiplier to the singal precision format in hand so 
that the multiplication part only works on integers. If you need an 
immediate value that is larger than 16 bits, such as for a mask, use the 
wide immediates format. After restoring the implicit most-significant 
bit of the significand, it is a 24-bit number with 23 bits to the right 
of the binary point and 1 bit to the left. When multiplying two such 
numbers, the result is a 48-bit number with 46 bits to the right of the 
1 
binary point and 2 bits to the left. Check the left-most bit of the 
result to determine whether or not it is necessary to normalize. 
2. Test your function using the Raspberry Pi by loading main.s and 
float.s. Test your multiplication function by calculating the product 
of  –8.0546875 ×10^0 and −1.79931640625 ×10^{-1} in the single 
precision format, or use the 16-bit half precision format described in 
page 251, Exercise 3.27. Assume 1 guard, 1 round bit, and 1 sticky bit, 
and round to the nearest even. 
3. Based on the above work on the multiplication, design and implement a 
similar function (fdiv) for the floating-point division, to be named as 
float2.s in the single precision format.  
4. Test your function of division using RPi by calculating 8.625 × 10^1 
divided by −4.875 × 10^0. Assume there is a guard, a round bit, and a 
sticky bit, and use them if necessary. You can use either the 16-bit 
floating point format described in Exercise 3.27 or the IEEE single 
precision format. 
5. Put all your programs and testing results into one file and submit it 
via canvas. 
Note: About immediate values: 
You can’t fit an arbitrary 32-bit value into a 32-bit instruction word. 
You can form constants wider than those available in a single instruction by 
using a sequence of instructions to build up the constant. For example: 
MOV r2, #0x55           
; R2 = 0x00000055 
ORR r2, r2, r2, LSL #8  ; R2 = 0x00005555 
ORR r2, r2, r2, LSL #16 ; R2 = 0x55555555 
You can use other tricks or load the value from memory: 
LDR r2, =0x55555555 
The pseudo-instruction LDR Rx,=const tries to form the constant in a single 
instruction, if possible, otherwise it will generate an LDR.
