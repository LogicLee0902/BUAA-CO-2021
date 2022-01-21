`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 23:02:07
// Design Name: 
// Module Name: Stall
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


module Stall(
    input [31:0] InstrD,
    input [31:0] InstrE,
    input [31:0] InstrM,
    input [31:0] InstrW,
    output Stall
    );
    wire Cal_r_D,Cal_i_D,Load_D,Store_D,jal_D,jr_D,beq_D;
	assign Cal_r_D =(InstrD[`op]==`R&&InstrD[`func]==`ADDU)||(InstrD[`op]==`R&&InstrD[`func]==`SUBU);
	assign Cal_i_D =(InstrD[`op]==`ORI)||(InstrD[`op]==`LUI);
	assign Load_D =(InstrD[`op]==`LW);
	assign Store_D = (InstrD[`op]==`SW);
	assign jal_D = (InstrD[`op]==`JAL);
	assign jr_D = (InstrD[`op]==`R&&InstrD[`func]==`JR);
	assign beq_D = (InstrD[`op]==`BEQ);
	 
	 wire Cal_r_E,Cal_i_E,Load_E,Store_E,jal_E,jr_E,beq_E;
	 assign Cal_r_E =(InstrE[`op]==`R&&InstrE[`func]==`ADDU)||(InstrE[`op]==`R&&InstrE[`op]==`SUBU);
	 assign Cal_i_E =(InstrE[`op]==`ORI)||(InstrE[`op]==`LUI);
	 assign Load_E =(InstrE[`op]==`LW);
	 assign Store_E = (InstrE[`op]==`SW);
	 assign jal_E = (InstrE[`op]==`JAL);
	 assign jr_E = (InstrE[`op]==`R&&InstrE[`func]==`JR);
	 assign beq_E = (InstrE[`op]==`BEQ);

	 wire Cal_r_M,Cal_i_M,Load_M,Store_M,jal_M,jr_M,beq_M;
	 assign Cal_r_M =(InstrM[`op]==`R&&InstrM[`func]==`ADDU)||(InstrM[`op]==`R&&InstrM[`func]==`SUBU);
	 assign Cal_i_M =(InstrM[`op]==`ORI)||(InstrM[`op]==`LUI);
	 assign Load_M =(InstrM[`op]==`LW);
	 assign Store_M = (InstrM[`op]==`SW);
	 assign jal_M = (InstrM[`op]==`JAL);
	 assign jr_M = (InstrM[`op]==`R&&InstrM[`func]==`JR);
	 assign beq_M = (InstrM[`op]==`BEQ);

	 wire Cal_r_W,Cal_i_W,Load_W,Store_W,jal_W,jr_W,beq_W;
	 assign Cal_r_W =(InstrW[`op]==`R&&InstrW[`func]==`ADDU)||(InstrW[`op]==`R&&InstrW[`func]==`SUBU);
	 assign Cal_i_W =(InstrW[`op]==`ORI)||(InstrW[`op]==`LUI);
	 assign Load_W =(InstrW[`op]==`LW);
	 assign Store_W = (InstrW[`op]==`SW);
	 assign jal_W = (InstrW[`op]==`JAL);
	 assign jr_W = (InstrW[`op]==`R&&InstrW[`func]==`JR);
	 assign beq_W = (InstrW[`op]==`BEQ);
	 
	 wire Stall_b,Stall_r,Stall_i,Stall_l,Stall_s,Stall_jr;
	 
	 //beq
	 assign Stall_b = beq_D &&((Cal_r_E && (InstrE[`rd]==InstrD[`rs]||InstrE[`rd]==InstrD[`rt]))||(Cal_i_E && (InstrE[`rt]==InstrD[`rs]||InstrE[`rt]==InstrD[`rt]))||(Load_E && (InstrE[`rt]==InstrD[`rs]||InstrE[`rt]==InstrD[`rt]))||(Load_M && (InstrM[`rt]==InstrD[`rs]||InstrM[`rt]==InstrD[`rt])));
	//calculate_r						
	 assign Stall_r = Cal_r_D &&((Load_E && (InstrE[`rt]==InstrD[`rs]||InstrE[`rt]==InstrD[`rt])));
	//calculate_i						
	 assign Stall_i = Cal_i_D &&((Load_E && InstrE[`rt]==InstrD[`rs]));
	//load						
	 assign Stall_l = Load_D &&((Load_E && InstrE[`rt]==InstrD[`rs]));
	//store				
	 assign Stall_s = Store_D &&((Load_E && InstrE[`rt]==InstrD[`rs]));
	//jr						
	 assign Stall_jr = jr_D &&((Cal_r_E && InstrE[`rd]==InstrD[`rs])||(Cal_i_E && InstrE[`rt]==InstrD[`rs])||(Load_E && InstrE[`rt]==InstrD[`rs])||(Load_M && InstrM[`rt]==InstrD[`rs]));
						
	 assign Stall=Stall_b|Stall_r|Stall_i|Stall_l|Stall_s|Stall_jr;
endmodule
