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
	input [31:0]RD1D,
	input [31:0]RD2D,
	input [31:0]imm32D,
	input [31:0]PC4D,
	input [2:0]resOpD,
	input [4:0]A3D,
	input [4:0]A2D,
	input [4:0]A1D,
	input [31:0]InstrD,
	input stall_md,
	input checkD,
	output reg checkE,
	output reg [31:0]RD1E,
	output reg [31:0]RD2E,
	output reg [31:0]imm32E,
	output reg [31:0]PC4E,
	output reg [4:0]A1E,
	output reg [4:0]A2E,
	output reg [4:0]A3E,
	output reg [2:0]resOpE,
	output reg [31:0]InstrE
    );
	always@(posedge clk) 
	begin
		if(reset||flush||stall_md)
		begin
			RD1E=0;
			RD2E=0;
			imm32E=0;
			PC4E=0;
			A1E=0;
			A2E=0;
			A3E=0;
			resOpE=0;
			InstrE=0;
			checkE = 0;
		end
		else 
		begin
			RD1E=RD1D;
			RD2E=RD2D;
			imm32E=imm32D;
			PC4E=PC4D;
			A1E=A1D;
			A2E=A2D;
			A3E=A3D;
			resOpE=resOpD;
			InstrE=InstrD;
			checkE=checkD;
		end
	end
endmodule


