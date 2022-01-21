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


//PC:
`define ADD4 2'b00
`define NPC  2'b01
`define MFPCF 2'b10

//EXT:
`define zero_ext 2'b00
`define sign_ext 2'b01
`define high_ext 2'b10

//ALU:
`define add 3'b000
`define sub 3'b001
`define ori 3'b010

//WriteData
`define Res 2'b00
`define RegRD 2'b01
`define PC4 2'b10
`define PC8 2'b11


//MFCMPRS and MFCMPRT
`define MD_PC  3'b101
`define WD_PC  3'b100
`define MD_ALU 3'b011
`define WD_ALU 3'b010
`define WD_DM 3'b001
`define ED_PC 3'b110

//MFALUAE and MFALUBE
`define ME_PC  3'b101
`define WE_PC  3'b100
`define ME_ALU 3'b011
`define WE_ALU 3'b010
`define WE_DM 3'b001

//MFWDM
`define WM_ALU 2'b01
`define WM_DM 2'b10
`define WM_PC 2'b11
`define NW 2'b00

//AT_controller
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00

//for Instr
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
`define R 6'b000000
`define ADDU 6'b100001


`define SUBU 6'b100011

// I-Type	only the op
`define LUI	 6'b001111
`define ORI	 6'b001101
`define ADDI 6'b001000


// MEM	only op
`define LW	6'b100011
`define SW	6'b101011

// Branch only op
`define BEQ	 6'b000100
//branch & rt
`define BGEZ 6'b000001

// JUMP
//only j
`define J 6'b000010	// only op
`define JAL	 6'b000011	// only op

//Shift & R
`define SRA 6'b000011

// op `R
`define JR	6'b001000	// the func
`define JALR 6'b001001