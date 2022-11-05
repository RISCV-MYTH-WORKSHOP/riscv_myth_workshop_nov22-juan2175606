# <p align="center">**RISC V - Workshop**</p>

In this repository, you will find the experience lived in the Workshop in RISC-V.

### Day 1 - Introduction to RISC-V basic keywords
----

RISC-V is a processor made within what are known as open source tools, which allows multiple basic tasks that can be exploited by the user, allowing it to be customizable according to the applications of interest.

This processor, before reaching its final layout stage, goes through a series of stages in which the processor is described with languages such as C, which, when taken to the compiler, converts it into a computer language that would result in the final design.

<p align="center">
  <img src="https://i.imgur.com/mPDiQle.jpg" />
</p>

#### Pseudo instructions
It is the way instructions are given to the processor.

#### Base integer Instructions RV64I
The way the processor understands the instructions is by means of registers that are manipulated according to what is to be achieved with the processor, which in this case are the integer base operations.

#### Multiply extension RV64M
The RV64I format would include integer multiplication and division instructions.

#### Single and double precision floating point RV64F & RV64D
In this case they are standard extensions for single and double precision floating point.

#### Application binary interface (ABI)
It is a way to take the binary language (machine language) to an interface where the structures, functions and everything that the processor will carry is defined in the the processor, that is to say that it could be a set of rules that would carry the RISC-V architecture.

#### Memory allocation and stack pointer
It could be said that it is the address of the first word of the instruction that belongs to the application binary interface (ABI) that commonly takes the acronym SP, which is a register.

To dive on what would be the C language, an example is made in which the operation of adding the numbers from 1 to 5 is made, which gives 15. to copy the code the following line is executed:

`$ gcc sum1ton.c`

And to execute, the following line

`$ ./a.out`

<p align="center">
  <img src="https://i.imgur.com/tHorL7R.jpg" />
</p>

Now we are going to take the code made in C to the RISC-v processor by executing the following line 

`$ riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c`
`$ riscv64-unknown-elf-objdump -d sum1ton.o`

You'll can see more details here https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/RISC-V-Options.html

The spike is the RISC-V functional simulator, where using "-d" allows debugging.

<p align="center">
  <img src="https://i.imgur.com/3oj1fKH.jpg" />
</p>

Due to how the information is presented to the processor, it is important to know how a binary is converted to decimal. For this there are two cases, where it must be identified initially if it is negative or positive, for this the MSB is checked, if it is '0' then it is positive and if it is '1' then it is negative.

#### Conversion from unsigned binary to decimal
For the conversion of a binary number to decimal is taken from right to left, where the binary digit multiplied by 2, raised to n, where n increments from 0 to the last digit on the left and the total sum equals the decimal number.

#### Signed binary to decimal conversion
For the conversion of a binary number to decimal is taken from right to left, where the binary digit multiplied by 2, raised to n, where n increments from 0 to the last digit on the left but for this case the last digit MSB is multiplied by -1 and thus the decimal value is obtained.

To end day 1, two .c programs are made, in order to demonstrate what would be the maximum and minimum values for unsigned long long int and long long long int data, which must be taken into account to avoid that the results of any operation give outside these ranges, as shown below.

For the case where you have a format of type unsigned long long int

<p align="center">
  <img src="https://i.imgur.com/hkifh0l.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/0L6eANo.jpg" />
</p>

For the case where you have a format of type long long int

<p align="center">
  <img src="https://i.imgur.com/wenYODa.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/xC7q3cm.jpg" />
</p>

----
### Day 2 - Introduction to ABI and basic verification flow
----

The construction of the ABI interface, manages to maintain the communication between everything that composes the system with respect to what the user needs. Within the ISA section there is the way in which the instructions are programmed using the JCL, C, C++ language, which allows to use the RISC-V, ARM, x86 architecture to then generate the serial HADWARE by means of the RTL.

To communicate with the ABI interface, it is done through registers that are divided into XLEN-32 bit for RV32 and XLEN-64 bit for RV64.

Particularly they are 64-bit registers, which are divided into 8 packets of 8 bits or 1 byte which generates a double word.

<p align="center">
  <img src="https://i.imgur.com/wtKaQek.jpg" />
</p>

The 3 word records are normally made up of the load double word, destination rgister 'rd' and the offset 'imm'.

<p align="center">
  <img src="https://i.imgur.com/fsolIBq.jpg" />
</p>

The way in which the registers are stored is by means of the 64 bits mentioned above, which are positioned as follows

<p align="center">
  <img src="https://i.imgur.com/o5PUUvr.jpg" />
</p>

The following table shows the registers, with their respective names and their use, which is important to bear in mind when manipulating them.

<p align="center">
  <img src="https://i.imgur.com/40o5GJN.jpg" />
</p>

For the practical example, a small program is made in C with certain counters using certain conditionals that at the end would communicate with the ASM (register).

In this example the following two files are used:

<p align="center">
  <img src="https://i.imgur.com/yPlPH6t.jpg" />
</p>

And then the following lines are executed:

<p align="center">
  <img src="https://i.imgur.com/DEUgZjM.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/yPlPH6t.jpg" />
</p>

And with the following line you can observe the records

`$ riscv64-unknown-elf-objdump -d 1to9_custom.o | less`

<p align="center">
  <img src="https://i.imgur.com/qTqhHD6.jpg" />
</p>

Now the activity to develop is to run the C program in the RISC-V CPU, for this the following line must be executed.

`$git clone https://github.com/kunalg123/riscv_workshop_collaterals.git`

This will download the folder of interest and then we will have to enter, in this folder we will be able to see all the necessary files to be able to make the simulation.

Here you can see the file corresponding to picorv.32

<p align="center">
  <img src="https://i.imgur.com/UZol1zG.jpg" />
</p>

Here you can see the file corresponding to the rv32im.sh, it contains information of the test bench, the processor configuration among others.

<p align="center">
  <img src="https://i.imgur.com/Qd5jKkt.jpg" />
</p>

You can also find firmware that would be loaded into the processor.

<p align="center">
  <img src="https://i.imgur.com/PGwR5AR.jpg" />
</p>

----
### Day 3 - Digital Logic with TL-Verilog and Makerchip
----

In this section of the workshop we worked on the construction of what would be the RISC-V, for this purpose we went through different sections of the digital environment to cover this construction.

Taking into account that internally the standard cells that make up the circuits that the tool uses to assemble the designs, it is important to know the type of gates that exist which make up these standard cells, within these are the NOT, AND, OR XOR, NAND, NOR, XNOR.

The following image shows the syntax to be taken into account when describing digital circuits in verilog.

<p align="center">
  <img src="https://i.imgur.com/8ZPCiNk.jpg" />
</p>

This section reinforces the construction of code in verilog using the makerchip platform, in which different examples are made to become familiar with the tool.

In the following images you can see the digital circuits in verilog on the left and in the blocks on the right you can see the diagram and simulation.

A) Inverter

<p align="center">
  <img src="https://i.imgur.com/449XM4I.jpg" />
</p>

B)NAND

<p align="center">
  <img src="https://i.imgur.com/p8t1Fyn.jpg" />
</p>

C) vectors

<p align="center">
  <img src="https://i.imgur.com/EPZ9rEr.jpg" />
</p>

D) MUX SIMPLE

<p align="center">
  <img src="https://i.imgur.com/vUkrUAD.jpg" />
</p>

E) MUX WITH VECTORS

<p align="center">
  <img src="https://i.imgur.com/GKym3rD.jpg" />
</p>

F) Combinational Calculator

https://www.makerchip.com/sandbox/0BBfVhrvn/0Mjh25p#

<p align="center">
  <img src="https://i.imgur.com/QtP67A3.jpg" />
</p>

G) Sequential Logic - Counter

https://www.makerchip.com/sandbox/0BBfVhrvn/0O7hNAn

<p align="center">
  <img src="https://i.imgur.com/osvhzt7.jpg" />
</p>

G) Sequential Logic - Fibonacci Series

https://www.makerchip.com/sandbox/0BBfVhrvn/0NxhZND#

<p align="center">
  <img src="https://i.imgur.com/eSjTs0O.jpg" />
</p>

H) Sequential Calculator
https://www.makerchip.com/sandbox/0BBfVhrvn/0Q1hX6j
<p align="center">
  <img src="" />
</p>

I) Pipeline

https://www.makerchip.com/sandbox/0BBfVhrvn/0Vmh2lK

<p align="center">
  <img src="https://i.imgur.com/XqDRDHx.jpg" />
</p>

F) Cycle Calculator

https://www.makerchip.com/sandbox/0BBfVhrvn/0Wnh6jQ

<p align="center">
  <img src="https://i.imgur.com/VzKQuph.jpg" />
</p>

G) Validity

https://www.makerchip.com/sandbox/0BBfVhrvn/0X6h4nR#

<p align="center">
  <img src="https://i.imgur.com/YHdwKqD.jpg" />
</p>

H) Calculator with single-value memory

https://www.makerchip.com/sandbox/0BBfVhrvn/0Z4h7Mv

<p align="center">
  <img src="https://i.imgur.com/GR4SBSE.jpg" />
</p>

----
### Day 4 - Basic RISC-V CPU micro - architecture
----

For day 4, the following circuit will be built, which will be constructed in parts.

<p align="center">
  <img src="https://i.imgur.com/pgpLoEJ.jpg" />
</p>

1) Fetch Stage

<p align="center">
  <img src="https://i.imgur.com/MAOKySZ.jpg" />
</p>

The following table shows the instruction types: I,R,S,B,J,U.

<p align="center">
  <img src="https://i.imgur.com/IoNYCRe.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/3m06jqp.jpg" />
</p>

The $imm instructions must then be obtained based on the following table.

<p align="center">
  <img src="https://i.imgur.com/5W3EELB.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/TNexke1.jpg" />
</p>

The instruction extraction corresponding to $funct7, $funct3, $rs1, $rs2, $rd, $opcode is obtained.

<p align="center">
  <img src="https://i.imgur.com/EYECfME.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/3SzHijy.jpg" />
</p>


The RV32I instruction base should now be obtained based on the following table:

<p align="center">
  <img src="https://i.imgur.com/zDZ1qfU.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/i6Rqv9G.jpg" />
</p>

The following register file read is now configured

<p align="center">
  <img src="https://i.imgur.com/dGHOrxE.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/UPjZitp.jpg" />
</p>

The ALU block is configured with respect to the operators ADD, ADDI

<p align="center">
  <img src="https://i.imgur.com/3I43cnS.jpg" />
</p>

Finally, the branches are configured.

<p align="center">
  <img src="https://i.imgur.com/XQtAWC2.jpg" />
</p>

<p align="center">
  <img src="https://i.imgur.com/VHtNsHW.jpg" />
</p>

In the following link you can follow the work done on day 4.

https://makerchip.com/sandbox/0NkfNhVVM/0RghGnv#

----
### Day 5 - Digital Logic with TL-Verilog and Makerchip
----

The pipeline generates delays in the CPU cycle but conversely increases system performance.

<p align="center">
  <img src="https://i.imgur.com/CQ48IMx.jpg" />
</p>

https://makerchip.com/sandbox/0NkfNhVVM/076hzW9#
