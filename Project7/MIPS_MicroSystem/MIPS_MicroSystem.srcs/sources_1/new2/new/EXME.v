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
    input Request,
	input clk,
	input reset,
	input [31:0]MemWDE,
	input [31:0]ResE,
	input [31:0]PC4E,
	input [2:0]resOpE,
	input [4:0]A1E,
	input [4:0]A3E,
	input [4:0]A2E,
	input [31:0]HIE,
	input [31:0]LOE,
	input [31:0]InstrE,
	input checkE,
	input DelayE,
	input [4:0]EXCCodeE,
	input Exc_AddrE,
	output reg checkM,
	output reg[31:0]InstrM,
	output reg[31:0]HIM,
	output reg[31:0]LOM,
	output reg[31:0]MemWDM,
	output reg[31:0]ResM,
	output reg[31:0]PC4M,
	output reg [4:0]A2M,
	output reg [4:0]A3M,
	output reg [2:0]resOpM,
	output reg [4:0]EXCCodeM,
	output reg DelayM,
	output reg Exc_AddrM,
	output reg [4:0]A1M
    );
	always@(posedge clk)
	begin
		if(reset || Request)
		begin
			ResM <= 0;
			MemWDM <= 0;
			PC4M <= (Request? 32'h0000_4184 :32'd0);
			A1M <= 0;
			A2M <= 0;
			A3M <= 0;
			resOpM <= 0;
			HIM <= 0;
			LOM <= 0;
			InstrM <= 0;
			checkM <= 0;
			DelayM <= 0;
			EXCCodeM <= 0;
			Exc_AddrM <= 0;
		end
		else
		begin
			MemWDM <= MemWDE;
			ResM <= ResE;
			PC4M <= PC4E;
			A1M <= A1E;
			A2M <= A2E;
			A3M <= A3E;
			resOpM <= resOpE;
			HIM <= HIE;
			LOM <= LOE;
			InstrM <= InstrE;
			checkM <= checkE;
			DelayM <= DelayE;
			EXCCodeM <= EXCCodeE;
			Exc_AddrM <= Exc_AddrE;
		end
	end
endmodule 