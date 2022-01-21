`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 00:48:30
// Design Name: 
// Module Name: MEWB
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


module MEWB(
	input clk,
	input reset,
	input [31:0]PC4M,
	input [31:0]ResM,
	input [31:0]MemRDM,
	input [1:0]MemtoRegM,
	input [1:0]resOpM,
	input [4:0]A3M,
	input RegWriteM,
	output reg [1:0]MemtoRegW,
	output reg RegWriteW,
	output reg [31:0]PC4W,
	output reg [31:0]ResW,
	output reg [31:0]MemRDW,
	output reg [4:0]A3W,
	output reg [1:0]resOpW
    );
	always@(posedge clk)
	begin
		if(reset)
		begin
			PC4W=0;
			ResW=0;
			MemRDW=0;
			MemtoRegW=0;
			RegWriteW=0;
			A3W=0;
			resOpW=0;
		end
		else 
		begin
			PC4W=PC4M;
			ResW=ResM;
			MemRDW=MemRDM;
			MemtoRegW=MemtoRegM;
			RegWriteW=RegWriteM;
			A3W=A3M;
			resOpW=resOpM;
		end
	end

endmodule