`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    9:59:18 11/26/2021
// Design Name: 
// Module Name:    define 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


//EXTOp[1:0]
`define zero_ext 2'b00
`define sign_ext 2'b01
`define high_ext 2'b10 

//ALUOp[3:0]
`define add 4'b0000
`define sub 4'b0001
`define ori 4'b0010
`define andi 4'b0011
`define xori 4'b0100
`define sign_right 4'b0101
`define zero_right 4'b0110
`define left 4'b0111
`define nori 4'b1000
`define sign_less 4'b1001
`define zero_less 4'b1010

//MulDivWrite[1:0]
`define whi 2'b01
`define wlo 2'b10

//MulDivcal[2:0]
`define sign_mults 3'b001
`define mults 3'b010
`define sign_divs 3'b011
`define divs 3'b100

//npcsel[1:0]
`define ADD4 2'b00
`define NPC 2'b01
`define MFPCF 2'b10

//MemtoReg[2:0]
`define Res 3'b000
`define MemRD 3'b001
`define PC8 3'b010
`define HI 3'b011
`define LO 3'b100

//MFCMP1D MFCMP2D[3:0]
`define MD_ALU 4'b0001
`define MD_PC 4'b0010
`define WD_ALU 4'b0011
`define WD_PC 4'b0100
`define WD_DM 4'b0101
`define MD_HI 4'b0110
`define MD_LO 4'b0111
`define WD_HI 4'b1000
`define WD_LO 4'b1001

//MFALUAE MFALUBE[3:0]
`define ME_ALU 4'b0001
`define ME_PC 4'b0010
`define WE_ALU 4'b0011
`define WE_PC 4'b0100
`define WE_DM 4'b0101
`define ME_HI 4'b0110
`define ME_LO 4'b0111
`define WE_HI 4'b1000
`define WE_LO 4'b1001

//MFWDMM[2:0]
`define WM_ALU 3'b001
`define WM_PC 3'b010
`define WM_DM 3'b011
`define WM_HI 3'b100
`define WM_LO 3'b101

//Save&Load Sel[2:0]
`define Word 3'b001
`define Byte 3'b010
`define Half 3'b011

//res[2:0] for writeback
`define ALU 3'b001
`define DM 3'b010
`define PC 3'b011
`define NW 3'b000
`define HIout 3'b100
`define LOout 3'b101

//////for Instruction/////////

`define instr 31:0
`define rs 25:21
`define base 25:21
`define rt 20:16
`define rd 15:11
`define imm16 15:0
`define imm26 25:0
`define op 31:26
`define func 5:0
`define shamt 10:6

// R-Type only the funct
`define R 		6'h0
`define ADDU 	6'b100001
`define ADD		6'b100000

`define SUBU	6'b100011
`define SUB		6'b100010

`define AND		6'b100100
`define OR		6'b100101
`define XOR		6'b100110
`define NOR		6'b100111

	// mult and div
`define MULT	6'b011000
`define MULTU	6'b011001

`define	DIV		6'b011010
`define DIVU	6'b011011

`define SLL		6'b000000
`define SRL		6'b000010
`define SRA		6'b000011
`define SLLV	6'b000100
`define SRLV	6'b000110
`define SRAV	6'b000111

	// set less than
`define SLT		6'b101010
`define SLTU	6'b101011

	//  read/write HI/LO
`define MFHI	6'b010000
`define MFLO	6'b010010
`define MTHI	6'b010001
`define MTLO	6'b010011

// I-Type	only the op
`define LUI		6'b001111

`define ADDI	6'b001000
`define ADDIU	6'b001001

`define ANDI	6'b001100

`define ORI		6'b001101
`define XORI	6'b001110

	// set less then
`define SLTI	6'b001010
`define SLTIU	6'b001011

// MEM	only op
`define LW		6'b100011
`define SW		6'b101011
`define LB		6'b100000
`define LBU		6'b100100
`define LH		6'b100001
`define LHU		6'b100101
`define SB		6'b101000
`define SH		6'b101001

// Branch only op
`define BEQ		6'b000100	
`define BNE		6'b000101
`define BLEZ	6'b000110
`define BGTZ	6'b000111
`define BLTZ	6'b000001
`define BGEZ	6'b000001

// JUMP
	// the JType
`define J		6'b000010	// only op
`define JAL		6'b000011	// only op

// op `R
`define JR		6'b001000	// the func
`define JALR	6'b001001	// the func
