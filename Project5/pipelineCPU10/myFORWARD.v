`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/22 00:11:12
// Design Name: 
// Module Name: FORWARD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//about instrction 31:0
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

//instruction infomation:

// R-Type only the funct
`define R 6'h0
`define ADDU 6'b100001

`define SUBU 6'b100011

// I-Type	only the op
`define LUI	 6'b001111
`define ORI	 6'b001101


// MEM	only op
`define LW	6'b100011
`define SW	6'b101011

// Branch only op
`define BEQ	 6'b000100

// JUMP
//only j
`define J 6'b000010	// only op
`define JAL	 6'b000011	// only op

// op `R
`define JR	6'b001000	// the func

//about PC


module FORWARD(
    input [31:0] InstrD,
    input [31:0] InstrE,
    input [31:0] InstrM,
    input [31:0] InstrW,
    output FlagW,
    output FlagM,
    output [4:0] addrM,
    output [1:0] DataM, //0:from ALUOutM	1:from PCM+8
    output FlagE,
    output [4:0] addrE,
    output [1:0] DataE	
    );
    assign FlagE = (InstrE[`op]==`JAL);
						
	assign FlagM = (InstrM[`op]==`JAL)||(InstrM[`op]==`LUI)||(InstrM[`op]==`R&&InstrM[`func]==`ADDU)||(InstrM[`op]==`R&&InstrM[`func]==`SUBU)||(InstrM[`op]==`ORI);
						
	assign FlagW = (InstrW[`op]==`JAL)||(InstrW[`op]==`LUI)||(InstrW[`op]==`R&&InstrW[`func]==`ADDU)||(InstrW[`op]==`R&&InstrW[`func]==`SUBU)||(InstrW[`op]==`ORI)||(InstrW[`op]==`LW);
	 
	 //calculated, ready to be forwarded
	 assign addrE =	(InstrE[`op]==`JAL) ? 5'd31 : 5'd0;
	 
	 assign addrM =	(InstrM[`op]==`JAL) ? 5'd31:
					(InstrM[`op]==`LUI || InstrM[`op] == `ORI)?InstrM[`rt]:
					(InstrM[`op]==`R && (InstrM[`func]==`ADDU || InstrM[`func]==`SUBU ))?InstrM[`rd]:5'd0;

//	 assign DataE= (InstrE[`op]==`JAL)?	2'd0:
//				   (InstrE[`op]==`LUI)? 2'd1:2'd0;
	/*													
	 assign DataM= (InstrM[`op]==`JAL)?	2'd1:
				   (InstrM[`op]==`LUI)? 2'd2:
				   (InstrM[`op]==`R&&InstrM[`func]==`ADDU)? 2'd0:
				   (InstrM[`op]==`R&&InstrM[`func]==`SUBU)? 2'd0:
				   (InstrM[`op]==`ORI)? 2'd0:2'd0;*/
	 assign DataM= (InstrM[`op]==`JAL)?	2'd1:2'd0;			   
    //M/W no need due to the interval forwarding
endmodule
