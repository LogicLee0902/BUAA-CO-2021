`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 21:12:20
// Design Name: 
// Module Name: StageF
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

`include "MUX.v"
`include "PC.v"
`include "ADD4.v"
`include "IM.v"

module StageF(
    input [1:0] NPCOp,
    input [31:0] PCJump,
    input [31:0] RD1,
    input clk,
    input reset,
    input enPC,
    output [31:0] InstrF,
    output [31:0] ADD4
    );
    wire [31:0]NPCF, PCF;
    MUX_4_32 MUXPC(
	   .sel(NPCOp),
	   .in0(ADD4),
	   .in1(PCJump),
	   .in2(RD1),
	   .in3(32'h0000_3000),
	   .out(NPCF)
	);
    PC pc(
        .NPC(NPCF),
        .clk(clk),
        .reset(reset),
        .PC_en(enPC),
        .PC(PCF)
    );
    ADD4 add4(
        .PC(PCF),
        .PC4(ADD4)
    );
    IM im(
        .PC(PCF),
        .Instr(InstrF)
    );
endmodule
