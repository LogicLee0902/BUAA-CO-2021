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
    input clk,
    input reset,
    input en,
	output reg [31:0] PC4D,
    output reg [31:0] InstrD
    );
	 
	always@(posedge clk)begin
		if(reset)
		begin
			InstrD=0;
			PC4D=0;
		end
		else if(en  && stall_md == 0) 
		begin
			InstrD=InstrF;
			PC4D=ADD4;
		end	
		
    end
endmodule