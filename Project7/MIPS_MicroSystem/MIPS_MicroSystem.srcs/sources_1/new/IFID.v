`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 19:53:33
// Design Name: 
// Module Name: IFID
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
module IFID(
    input [31:0] InstrF,
    input [31:0] ADD4,
    input stall_md,
    input [4:0] EXCCodeF,
    input DelayF,
    input clk,
    input reset,
    input en,
    input Request,
	output reg [31:0] PC4D,
    output reg [31:0] InstrD,
    output reg [4:0] EXCCodeD,
    output reg DelayD
    );
	 
	always@(posedge clk)begin
		if(reset || Request)
		begin
			InstrD<=0;
			PC4D<=Request ? 32'h0000_4184 : 32'd0;
			EXCCodeD<=0;
			DelayD<=0;
		end
		else if(en  && (stall_md == 1'b0) ) 
		begin
			InstrD<=InstrF;
			PC4D<=ADD4;
			EXCCodeD<=EXCCodeF;
			DelayD<=DelayF;
		end	
		
    end
endmodule