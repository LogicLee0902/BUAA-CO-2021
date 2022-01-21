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
    input Tuse_rs0,
	input Tuse_rs1,
	input Tuse_rt0,
	input Tuse_rt1,
	input Tuse_rt2,
	input [31:0]Instr,
	input [4:0]A3E,
	input [4:0]A3M,
	input [1:0]resOpE,
	input [1:0]resOpM,
	output reg stall
	);
	reg stall_rs0_e1,stall_rs0_e2,stall_rs1_e2,stall_rs0_m1,stall_rs;
	reg stall_rt0_e1,stall_rt0_e2,stall_rt1_e2,stall_rt0_m1,stall_rt;
	always@(*)
	begin
		stall_rs0_e1 = Tuse_rs0 && (resOpE==`ALU) && (Instr[`rs]==A3E);
		stall_rs0_e2 = Tuse_rs0 && (resOpE==`DM) && (Instr[`rs]==A3E);
		stall_rs1_e2 = Tuse_rs1 && (resOpE==`DM) && (Instr[`rs]==A3E);
		stall_rs0_m1 = Tuse_rs0 && (resOpM==`DM) && (Instr[`rs]==A3M);
		stall_rs = stall_rs0_e1 || stall_rs0_e2 || stall_rs1_e2 || stall_rs0_m1;
		
		stall_rt0_e1 = Tuse_rt0 && (resOpE==`ALU) && (Instr[`rt]==A3E);
		stall_rt0_e2 = Tuse_rt0 && (resOpE==`DM) && (Instr[`rt]==A3E);
		stall_rt1_e2 = Tuse_rt1 && (resOpE==`DM) && (Instr[`rt]==A3E);
		stall_rt0_m1 = Tuse_rt0 && (resOpM==`DM) && (Instr[`rt]==A3M);
		stall_rt = stall_rt0_e1 || stall_rt0_e2 || stall_rt1_e2 || stall_rt0_m1;	
		
		stall = stall_rs||stall_rt;
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
