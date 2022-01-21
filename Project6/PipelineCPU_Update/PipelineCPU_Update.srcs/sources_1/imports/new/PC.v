`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 18:34:42
// Design Name: 
// Module Name: PC
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

module PC(
    input [31:0] NPC,
    input clk,
    input reset,
    input PC_en,
    input stall_md,
    output reg [31:0] PC
    );

	initial begin
		PC <= 32'h00003000;
	end

	always @(posedge clk) 
	begin
		if (reset)
			PC <= 32'h00003000;
		else if (PC_en && !stall_md)
			PC<= NPC;
	end
endmodule
