`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 21:02:13
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input clk,
    input reset,
    input [31:0] PCE,
    input [31:0] InstrE,
    input [1:0] MemtoRegE,
    input MemWriteE,
    input [4:0] A3E,
    input [31:0] ResE,
    input [31:0] imm32E,
    input [31:0] WDMemoryE,
    input RegWriteE,
    output reg [31:0] InstrM,
    output reg [1:0] MemtoRegM,
    output reg MemWriteM,
    output reg [4:0] A3M,
    output reg [31:0] WDMemoryM,
    output reg [31:0] ResM,
    output reg [31:0] PCM,
    output reg [31:0] imm32M,
    output reg RegWriteM
    );
    
     initial begin
		InstrM = 0;
		PCM = 0;
	end
	
    always @(posedge clk)
    begin
        if(reset == 1)
        begin
            InstrM <= 0;
            MemtoRegM <= 0;
            MemWriteM <= 0;
            A3M <= 0;
            WDMemoryM <= 0;
            PCM <= 0;
            imm32M <= 0;
            ResM <= 0;
            RegWriteM <= 0;
        end
        else
        begin
            InstrM <= InstrE;
            MemtoRegM <= MemtoRegE;
            MemWriteM <= MemWriteE;
            A3M <= A3E;
            WDMemoryM <= WDMemoryE;
            PCM <= PCE;
            imm32M <= imm32E;
            ResM <= ResE;
            RegWriteM <= RegWriteE;
        end
    end
endmodule
