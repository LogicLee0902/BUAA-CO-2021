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
    input eret,
    input [31:0] EPC,
    input Request,
    input enPC,
    input stall_md,
    input reset,
    output [31:0] ADD4,
    output [31:0]PCF_New,
    output [2:0]NPCOp
    //output [4:0] ExcF
    );
    wire [31:0]NPCF;
    wire [31:0]PCF;
    Decoder decode_MUXPC(
    	.Instr(InstrD),
    	.Request(Request),
    	.NPCOp(NPCOp)
    );
    MUX_6_32 MUXPC(
	   .sel(NPCOp),
	   .in0(ADD4),
	   .in1(PCJump),
	   .in2(RD1),
	   .in3(EPC+4),
	   .in4(32'h0000_4180),
	   .in5(32'h0000_3000),
	   .out(NPCF)
	);
    PC pc(
        .NPC(NPCF),
        .clk(clk),
        .reset(reset),
        .stall_md(stall_md),
        .PC_en(enPC),
        .Request(Request),
        .PC(PCF)
    );
    assign PCF_New = (eret === 1'b1)? EPC : PCF;
    ADD4 add4(
        .PC(PCF_New),
        .PC4(ADD4)
    );
endmodule
