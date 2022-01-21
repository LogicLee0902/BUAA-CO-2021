`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 18:54:48
// Design Name: 
// Module Name: StageM
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
`include "DM.v"

module StageM(
	input [31:0]MemWD,
	input MemWrite,
	input [31:0]ResM,
	input [31:0]ResW,
	input clk,
	input reset,
	input [1:0] MDMM,
	input [31:0]PC4W,
	input [31:0]PC4M,
	input [31:0]MemRDW,
	input [31:0]InstrM,
	output [31:0]MemRD
    );
    
    wire [31:0]MFDMM;
    MUX_4_32 mfdmm(
    	.in0(MemWD),
    	.in1(ResW),
    	.in3(PC4W+4),
    	.in2(MemRDW),
    	.sel(MDMM),
    	.out(MFDMM)
    );
    DM dm(
    	.Addr(ResM),
    	.MemWD(MFDMM),
    	.MemWrite(MemWrite),
    	.clk(clk),
    	.reset(reset),
    	.PC4(PC4M),
    	.MemRD(MemRD)
    );
    /*
    DASM Dasm(
    .pc(PC4M-4),
    .instr(InstrM),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);*/
endmodule
