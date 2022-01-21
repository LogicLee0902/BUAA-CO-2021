`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/20 20:57:44
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
    input clk,
    input reset,
    input IFID_en,
    input [31:0] InstrF,
    output reg [31:0] InstrD,
    input [31:0] PCF,
    output reg [31:0] PCD
    );
    
    initial begin
		InstrD = 0;
		PCD = 0;
	end
	
    always@(posedge clk)
    begin
        if(reset)
        begin
            PCD <= 32'h0;
            InstrD <= 32'h0;
        end
        else
        begin
            if(IFID_en) 
            begin
                PCD <= PCF;
                InstrD <= InstrF;
            end
        end
    end
endmodule
