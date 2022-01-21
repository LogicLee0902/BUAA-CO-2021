`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 20:07:28
// Design Name: 
// Module Name: IDEX
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


module IDEX(
	input clk,
	input reset,
	input flush,
	input stall,
	input [31:0]RD1D,
	input [31:0]RD2D,
	input [31:0]imm32D,
	input [31:0]PC4D,
	input [31:0]InstrD,
	input stall_md,
	input checkD,
	input DelayD,
	input Request,
	input [4:0] EXCCodeD,
	output reg checkE,
	output reg [31:0]RD1E,
	output reg [31:0]RD2E,
	output reg [31:0]imm32E,
	output reg [31:0]PC4E,
	output reg [31:0]InstrE,
	output reg [4:0]EXCCodeE,
	output reg DelayE
    );
	always@(posedge clk) 
	begin
		if(reset||flush||stall_md||Request || stall)
		begin
			RD1E <= 0;
			RD2E <= 0;
			imm32E <= 0;
			PC4E <= (stall_md||stall)? PC4D : (Request ? 32'h0000_4184 :0);
			InstrE <= 0;
			checkE <= 0;
			DelayE <= (stall_md || stall) ? DelayD : 0;
			EXCCodeE <= 0;
		end
		else 
		begin
			RD1E <= RD1D;
			RD2E <= RD2D;
			imm32E <= imm32D;
			PC4E <= PC4D;
			InstrE <= InstrD;
			checkE <= checkD;
			DelayE <= DelayD;
			EXCCodeE <= EXCCodeD;
		end
	end
endmodule


