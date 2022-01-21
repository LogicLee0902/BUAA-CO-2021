`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 22:14:19
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
    input  [31:0]PCM,
    input [31:0]InstrM,
    input [31:0]ResM,
    input [4:0]A3M,
    input [31:0]RDM,
    input [1:0]MemtoRegM,
    input RegWriteM,
    output reg [31:0] PCW,
    output reg [31:0]InstrW,
    output reg [31:0]ResW,
    output reg [4:0] A3W,
    output reg [31:0] RDW,
    output reg [1:0]MemtoRegW,
    output reg RegWriteW
    );
     initial begin
		InstrW = 0;
		PCW = 0;
	end
	
    always@(posedge clk)
    begin
        if(reset == 1)
        begin
            PCW <= 0;
            InstrW <= 0;
            ResW <= 0;
            A3W <= 0;
            RDW <= 0;
            MemtoRegW <= 0;
            RegWriteW <= 0;
        end
        else
        begin
            PCW <= PCM;
            InstrW <= InstrM;
            ResW <= ResM;
            A3W <= A3M;
            RDW <= RDM;
            MemtoRegW <= MemtoRegM;
            RegWriteW <= RegWriteM;
        end
    end
endmodule
