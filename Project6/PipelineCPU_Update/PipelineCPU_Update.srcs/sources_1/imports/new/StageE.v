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


module StageE(
	input clk,
	input reset,
	input [31:0]InstrE,
	input [31:0]PC4M,
	input [31:0]PC4W,
	input [3:0]MALUAE,
	input [3:0]MALUBE,
	input [31:0]ResM,
	input [31:0]ResW,
	input [31:0]MemRDW,
	input [31:0]RD1,
	input [31:0]RD2,
	input [31:0]imm32,
	input [31:0]PC4E,
	input [31:0]HIW,
    input [31:0]LOW,
    input [31:0]HIM,
    input [31:0]LOM,
	output [31:0]Res,
	output [31:0]MFALUBE,
	output Busy,
	output Start,
	output [31:0]HIE,
	output [31:0]LOE
    );
    wire [31:0]MFALUAE;
    wire ALUSrcB, ALUSrcA;
    Decoder decode_ALUSrc(
    	.Instr(InstrE),
    	.ALUSrcA(ALUSrcA),
    	.ALUSrcB(ALUSrcB)
    );
    MUX_10_32 mfaluae(
    .in0(RD1),
    .in1(ResM),
    .in2(PC4M+4),
    .in3(ResW),
    .in4(PC4W+4) ,
    .in5(MemRDW),
    .in6(HIM),
    .in7(LOM),
    .in8(HIW),
    .in9(LOW),
    .sel(MALUAE),
    .out(MFALUAE)
    );
    
   MUX_10_32 mfalube(
    .in0(RD2),
    .in1(ResM),
    .in2(PC4M+4),
    .in3(ResW),
    .in4(PC4W+4) ,
    .in5(MemRDW),
    .in6(HIM),
    .in7(LOM),
    .in8(HIW),
    .in9(LOW),
    .sel(MALUBE),
    .out(MFALUBE)
    );
    wire [31:0]ALUB, ALUA;
    MUX_2_32 mux_alub(
    	.in0(MFALUBE),
    	.in1(imm32),
    	.sel(ALUSrcB),
    	.out(ALUB)
    );
    wire [31:0]shamt32;
    assign shamt32 = {27'b0, InstrE[10:6]};
    MUX_2_32 mux_aluA(
    	.in0(MFALUAE),
    	.in1(shamt32),
    	.sel(ALUSrcA),
    	.out(ALUA)
    );
    ALU alu(
    	.A(ALUA),
    	.B(ALUB),
    	.InstrE(InstrE),
    	.Res(Res)
    );
    
    MULDIV muldiv(
    	.Instr(InstrE),
    	.D1(MFALUAE),
    	.D2(MFALUBE),
    	.clk(clk),
    	.reset(reset),
    	.HIOut(HIE),
    	.LOOut(LOE),
    	.Start(Start),
    	.Busy(Busy)
    );
    
  /*  DASM Dasm(
    .pc(PC4E-4),
    .instr(InstrE),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);*/
endmodule
