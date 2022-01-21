`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 14:44:16
// Design Name: 
// Module Name: CMP
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

module CMP(
	input [31:0]Instr,
	input [31:0] A,
	input [31:0] B,
	output Condition
	);
	wire beq, bne, blez, blgz, bltz, bgez, bgtz;
	Decoder decode_cmp(
		.Instr(Instr),
		.beq(beq),
		.bgez(bgez),
		.bne(bne),
		.blez(blez),
		.bltz(bltz),
		.bgtz(bgtz)
	);
	assign Condition =  (A==B && beq) ?1:
						(A!=B && bne) ?1:
						($signed(A)>0 && bgtz) ?1:
						($signed(A)<0 && bltz) ?1:
						($signed(A)>=0 && bgez)?1:
						($signed(A)<=0 && bgtz)?1:0;
endmodule 

