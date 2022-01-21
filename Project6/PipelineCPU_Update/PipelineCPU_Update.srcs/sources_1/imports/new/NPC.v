`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 14:57:43
// Design Name: 
// Module Name: NPC
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

module NPC(
	input [31:0]Instr,
	input [31:0] PC4,	
	input Condition,
	output reg [31:0] NPC
	);
	wire is_b, is_j; 
	Decoder decode_grf(
		.Instr(Instr),
		.b_type(is_b),
		.j_type(is_j)
	);
	wire [25:0] imm26 = Instr[`imm26];
	always@(*)
	begin
	   if(is_j)
	   begin
	       NPC = {PC4[31:28],imm26[25:0],2'b0};
	   end
	else if(is_b)
	begin
		if(Condition)
		  begin	
		  	NPC= PC4 +{{14{imm26[15]}},imm26[15:0],2'b0};
		  end
		else
		  NPC = PC4+4;
	end
	else 
		NPC=32'h00003000;
	
end
	

endmodule 
