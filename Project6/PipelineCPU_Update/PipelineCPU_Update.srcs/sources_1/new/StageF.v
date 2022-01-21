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


module StageF(
    input [31:0] InstrD,
    input [31:0] PCJump,
    input [31:0] RD1,
    input clk,
    input reset,
    input enPC,
    input stall_md,
    output [31:0] ADD4,
    output [31:0]PCF
    );
    wire [31:0]NPCF;
    wire [1:0]NPCOp;
    Decoder decode_MUXPC(
    	.Instr(InstrD),
    	.NPCOp(NPCOp)
    );
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
        .stall_md(stall_md),
        .PC_en(enPC),
        .PC(PCF)
    );
    ADD4 add4(
        .PC(PCF),
        .PC4(ADD4)
    );
endmodule
