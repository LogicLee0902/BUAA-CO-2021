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
	input [2:0]resOpE,
	input [4:0]A3E,
	input [4:0]A2E,
	input [31:0]HIE,
	input [31:0]LOE,
	input [31:0]InstrE,
	input checkE,
	output reg checkM,
	output reg[31:0]InstrM,
	output reg[31:0]HIM,
	output reg[31:0]LOM,
	output reg[31:0]MemWDM,
	output reg[31:0]ResM,
	output reg[31:0]PC4M,
	output reg [4:0]A2M,
	output reg [4:0]A3M,
	output reg [2:0]resOpM
    );
	always@(posedge clk)
	begin
		if(reset)
		begin
			ResM=0;
			MemWDM=0;
			PC4M=0;
			A2M=0;
			A3M=0;
			resOpM=0;
			HIM=0;
			LOM=0;
			InstrM=0;
			checkM=0;
		end
		else
		begin
			MemWDM=MemWDE;
			ResM=ResE;
			PC4M=PC4E;
			A2M=A2E;
			A3M=A3E;
			resOpM=resOpE;
			HIM=HIE;
			LOM=LOE;
			InstrM=InstrE;
			checkM=checkE;
		end
	end
endmodule 