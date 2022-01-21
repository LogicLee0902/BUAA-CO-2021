`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 00:38:28
// Design Name: 
// Module Name: EXME
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


module EXME(
	input clk,
	input reset,
	input [31:0]MemWDE,
	input [31:0]ResE,
	input [31:0]PC4E,
	input [1:0]MemtoRegE,
	input RegWriteE,
	input MemWriteE,
	input [1:0]resOpE,
	input [4:0]A3E,
	input [4:0]A2E,
	output reg [1:0]MemtoRegM,
	output reg RegWriteM,
	output reg MemWriteM,
	output reg[31:0]MemWDM,
	output reg[31:0]ResM,
	output reg[31:0]PC4M,
	output reg [4:0]A2M,
	output reg [4:0]A3M,
	output reg [1:0]resOpM
    );
	always@(posedge clk)
	begin
		if(reset)
		begin
			ResM<=0;
			MemWDM<=0;
			PC4M<=0;
			MemtoRegM<=0;
			RegWriteM<=0;
			MemWriteM<=0;
			A2M<=0;
			A3M<=0;
			resOpM<=0;
		end
		else
		begin
			MemWDM<=MemWDE;
			ResM<=ResE;
			PC4M<=PC4E;
			MemtoRegM<=MemtoRegE;
			RegWriteM<=RegWriteE;
			MemWriteM<=MemWriteE;
			A2M<=A2E;
			A3M<=A3E;
			resOpM<=resOpE;
		end
	end
endmodule 