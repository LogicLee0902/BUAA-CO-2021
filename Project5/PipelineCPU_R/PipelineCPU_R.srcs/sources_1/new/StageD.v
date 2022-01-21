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
    input beq,
    input j,
    input jal,
    input RegWrite,
    input [1:0]EXTOp,
    input [31:0]WD,
    input [4:0]A3,
    input [31:0]InstrD,
    input [31:0]PC4D,
    input [31:0]PC4M,
    input [31:0]PC4E,
    input [31:0]PC4W,
    input [2:0] MCMP1D,
    input [2:0] MCMP2D,
    input [31:0]ResM,
    input [31:0]ResW,
    input [31:0]MemRDW,
    output [31:0]PCJump,
    output [31:0]MFCMP1D,
    output [31:0]MFCMP2D,
    output [31:0]imm32D,
    output reset_IFID
    );
    wire [31:0]RD1, RD2;
    wire Zero;
    
    NPC npc(
    	.beq(beq),
    	.PC4(PC4D),
    	.j(j),
    	.jal(jal),
    	.Zero(Zero),
    	.imm(InstrD[25:0]),
    	.NPC(PCJump),
    	.clear(reset_IFID)
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
    	.imm16(InstrD[15:0]),
    	.EXTOp(EXTOp),
    	.imm32(imm32D)
    );
    MUX_8_32 mfcm1d(
    	.in0(RD1),
    	.in1(MemRDW),
    	.in2(ResW),
    	.in3(ResM),
    	.in4(PC4W+4),
    	.in5(PC4M+4),
    	.in6(PC4E+4),
    	.in7(32'b0),
    	.sel(MCMP1D),
    	.out(MFCMP1D)
    );
     MUX_8_32 mfcm2d(
    	.in0(RD2),
    	.in1(MemRDW),
    	.in2(ResW),
    	.in3(ResM),
    	.in4(PC4W+4),
    	.in5(PC4M+4),
    	.in6(PC4E),
    	.in7(32'b0),
    	.sel(MCMP2D),
    	.out(MFCMP2D)
    );
    CMP cmp(
    	.A(MFCMP1D),
    	.B(MFCMP2D),
    	.zero(Zero)
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


