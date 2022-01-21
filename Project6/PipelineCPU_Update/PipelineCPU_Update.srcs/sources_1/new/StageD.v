`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 13:14:06
// Design Name: 
// Module Name: StageD
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

`include "define.v"

module StageD(
    input clk,
    input reset,
    input RegWrite,
    input [31:0]WD,
    input [4:0]A3,
    input [31:0]InstrD,
    input [31:0]PC4D,
    input [31:0]PC4M,
    input [31:0]PC4E,
    input [31:0]PC4W,
    input [3:0] MCMP1D,
    input [3:0] MCMP2D,
    input [31:0]ResM,
    input [31:0]ResW,
    input [31:0]MemRDW,
    input [31:0]HIW,
    input [31:0]LOW,
    input [31:0]HIM,
    input [31:0]LOM,
    output [31:0]PCJump,
    output [31:0]MFCMP1D,
    output [31:0]MFCMP2D,
    output [31:0]imm32D,
    output Mul_Div
    );
    wire [31:0]RD1, RD2;
    wire Condition;
    Decoder decode_D(
    	.Instr(InstrD),
    	.mul_div(Mul_Div)
    );
    NPC npc(
    	.Instr(InstrD),
    	.PC4(PC4D),
    	.Condition(Condition),
    	.NPC(PCJump)
    );
    
    GRF grf(
    	.A1(InstrD[`rs]),
    	.A2(InstrD[`rt]),
    	.A3(A3),
    	.WD(WD),
    	.RegWrite(RegWrite),
    	.clk(clk),
    	.reset(reset),
    	.PC4(PC4W),
    	.RD1(RD1),
    	.RD2(RD2)
    );
    
    EXT ext(
    	.InstrD(InstrD),
    	.imm32(imm32D)
    );
    MUX_10_32 mfcm1d(
    	.in0(RD1),
    	.in1(ResM),
    	.in2(PC4M+4),
    	.in3(ResW),
    	.in4(PC4W+4),
    	.in5(MemRDW),
    	.in6(HIM),
    	.in7(LOM),
    	.in8(HIW),
    	.in9(LOW),
    	.sel(MCMP1D),
    	.out(MFCMP1D)
    );
     MUX_10_32 mfcm2d(
    	.in0(RD2),
    	.in1(ResM),
    	.in2(PC4M+4),
    	.in3(ResW),
    	.in4(PC4W+4),
    	.in5(MemRDW),
    	.in6(HIM),
    	.in7(LOM),
    	.in8(HIW),
    	.in9(LOW),
    	.sel(MCMP2D),
    	.out(MFCMP2D)
    );
    CMP cmp(
    	.Instr(InstrD),
    	.A(MFCMP1D),
    	.B(MFCMP2D),
    	.Condition(Condition)
    );
    /*
    DASM Dasm(
    .pc(PC4D-4),
    .instr(InstrD),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);*/
endmodule


