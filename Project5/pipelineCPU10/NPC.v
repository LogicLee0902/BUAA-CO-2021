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
	input [31:0] PC4,	
	input beq,
	input j,
	input jal,
	input Zero,
	input [25:0] imm,
	output reg [31:0] NPC,
	output reg clear
	);
	initial 
	begin
		clear <= 0;
	end
	always@(*)
	begin
		if(clear == 1) clear <=0;
	   if(j||jal)
	   begin
	       NPC <= {PC4[31:28],imm[25:0],2'b0};
	       clear <= 0;
	   end
	else if(beq)
	begin
		if(Zero)
		  begin
		  	NPC<= PC4 +{{14{imm[15]}},imm[15:0],2'b0};
		  	clear <= 0;
		  end
		else
		  clear <= 1;
	end
	else 
		NPC<=32'h00003000;
	
end
	

endmodule 
