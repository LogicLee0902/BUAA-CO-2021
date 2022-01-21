`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 15:49:28
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
    input reset,
    input flush,
    input clk,
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [31:0] InstrD,
    input [1:0] MemtoRegD,
    input MemWriteD,
    input RegWriteD,
    input [4:0] A3D,
//    input [31:0] WDD,
    input [2:0] ALUOpD,
    input ALUSrcD,
    input [31:0]PCD, 
    input [31:0]imm32D,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] InstrE,
    output reg [1:0] MemtoRegE,
    output reg MemWriteE,
    output reg [4:0] A3E,
//    output reg [31:0] WDE,
    output reg [2:0] ALUOpE,
    output reg ALUSrcE,
    output reg [31:0]PCE,
    output reg [31:0]imm32E,  
    output reg RegWriteE 
    );
  initial begin
		InstrE = 0;
		PCE = 0;
	end
	
    always@(posedge clk)
    begin
        if(flush==1)
        begin
            RD1E <= 0;
            RD2E <= 0;
            InstrE <= 0;
            MemtoRegE <= 0;
            A3E <= 0;
//            WDE <= 0;
            ALUOpE <= 0;
            ALUSrcE <= 0;
            MemWriteE <= 0;
            PCE <= 0;
            imm32E <= 0;
            RegWriteE <= 0;
        end
        else
        begin
            RD1E <= RD1D;
            RD2E <= RD2D;
            InstrE <= InstrD;
            MemtoRegE <= MemtoRegD;
            A3E <= A3D;
//            WDE <= WDD;
            ALUOpE <= ALUOpD;
            ALUSrcE <= ALUSrcD;
            MemWriteE <= MemWriteD;
            PCE <= PCD;
            imm32E <= imm32D;
            RegWriteE <= RegWriteD;
        end 
    end
endmodule
