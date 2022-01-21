`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 16:01:25
// Design Name: 
// Module Name: StageE
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
`include "ALU.v"


module StageE(
	input [31:0]PC4M,
	input [31:0]PC4W,
	input [2:0]MALUAE,
	input [2:0]MALUBE,
	input [31:0]ResM,
	input [31:0]ResW,
	input [31:0]MemRDW,
	input [31:0]RD1,
	input [31:0]RD2,
	input [31:0]imm32,
	input [2:0]ALUOp,
	input ALUSrc,
	input [31:0]PC4E,
	input [31:0]InstrE,
	output [31:0]Res,
	output [31:0]MFALUBE
    );
    wire [31:0]MFALUAE;
    
    MUX_6_32 mfaluae(
    .in0(RD1),
    .in1(MemRDW),
    .in2(ResW),
    .in3(ResM),
    .in4(PC4W+4),
    .in5(PC4M+4),
    .sel(MALUAE),
    .out(MFALUAE)
    );
    
    MUX_6_32 mfalube(
    .in0(RD2),
    .in1(MemRDW),
    .in2(ResW),
    .in3(ResM),
    .in4(PC4W+4),
    .in5(PC4M+4),
    .sel(MALUBE),
    .out(MFALUBE)
    );
    wire [31:0]ALUB;
    MUX_2_32 mux_alub(
    	.in0(MFALUBE),
    	.in1(imm32),
    	.sel(ALUSrc),
    	.out(ALUB)
    );
    ALU alu(
    	.A(MFALUAE),
    	.B(ALUB),
    	.ALUOp(ALUOp),
    	.Res(Res)
    );
    
  /*  DASM Dasm(
    .pc(PC4E-4),
    .instr(InstrE),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);*/
endmodule
