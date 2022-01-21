`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 13:19:31
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
`include "define.v"

module Stall_Judge(
    input [31:0] InstrD,
    input [31:0] InstrE,
    input [31:0] InstrM,
    input Tuse_rs0,
	input Tuse_rs1,
	input Tuse_rt0,
	input Tuse_rt1,
	input Tuse_rt2,
	input [31:0]Instr,
	input [4:0]A3E,
	input [4:0]A3M,
	input [2:0]resOpE,
	input [2:0]resOpM,
	output reg stall
	);
	reg stall_rs0_e1,stall_rs0_e2,stall_rs1_e2,stall_rs0_m1,stall_rs;
	reg stall_rt0_e1,stall_rt0_e2,stall_rt1_e2,stall_rt0_m1,stall_rt;
	reg stall_eret;    
	wire eretD, mtc0E, mtc0M; 
	wire [4:0]rdE, rdM;
	
	Decoder decode_StallD(
	   .Instr(InstrD),
	   .eret(eretD)
	);
	
	Decoder decode_StallE(
	   .Instr(InstrE),
	   .mtc0(mtc0E)
	);
	assign rdE = InstrE[`rd];
	
	Decoder decode_StallM(
	   .Instr(InstrM),
	   .mtc0(mtc0M)
	);
	assign rdM = InstrM[`rd];
	
	always@(*)
	begin
		stall_rs0_e1 = Tuse_rs0 && (resOpE==`ALU || resOpE==`HIout || resOpE==`LOout) && (Instr[`rs]==A3E) && (A3E != 0);
		stall_rs0_e2 = Tuse_rs0 && (resOpE==`DM || resOpE == `CP0Out) && (Instr[`rs]==A3E) && (A3E != 0);
		stall_rs1_e2 = Tuse_rs1 && (resOpE==`DM || resOpE == `CP0Out) && (Instr[`rs]==A3E) && (A3E != 0);
		stall_rs0_m1 = Tuse_rs0 && (resOpM==`DM || resOpM == `CP0Out) && (Instr[`rs]==A3M) && (A3M != 0);
		stall_rs = stall_rs0_e1 || stall_rs0_e2 || stall_rs1_e2 || stall_rs0_m1;
		
		stall_rt0_e1 = Tuse_rt0 && (resOpE==`ALU || resOpE==`HIout || resOpE==`LOout) && (Instr[`rt]==A3E) && (A3E != 0);
		stall_rt0_e2 = Tuse_rt0 && (resOpE==`DM || resOpE == `CP0Out) && (Instr[`rt]==A3E) && (A3E != 0);
		stall_rt1_e2 = Tuse_rt1 && (resOpE==`DM || resOpE == `CP0Out) && (Instr[`rt]==A3E) && (A3E != 0);
		stall_rt0_m1 = Tuse_rt0 && (resOpM==`DM || resOpM == `CP0Out) && (Instr[`rt]==A3M) && (A3M != 0);
		stall_rt = stall_rt0_e1 || stall_rt0_e2 || stall_rt1_e2 || stall_rt0_m1;	
		
		stall_eret = eretD && ((mtc0E && rdE == 5'd14) || (mtc0M && rdM == 5'd14));
		
		stall = stall_rs||stall_rt || stall_eret;
	end
endmodule

module Stall_Sign(
    input stall,
	output reg enPC,
	output reg enIFID,
	output reg FlushIDEX
		 );

	initial 
	begin
		enPC = 1;
		enIFID = 1;
		FlushIDEX =0;
	end
	always @(*)
	 begin
		enPC = (stall)? 0:1;
		enIFID = (stall)? 0:1;
		FlushIDEX =stall;
	end 
endmodule
