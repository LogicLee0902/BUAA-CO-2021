`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 17:01:01
// Design Name: 
// Module Name: mips
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


module mips(
    input clk, //clock
    input reset //reset
    );
    wire RegWrite, MemWrite, ALUSrc, SignExt, beq, j_jal, jr, bgez;
	wire [1:0] RegDst, WhichtoReg, Sel;
	wire [2:0] ALUOp;
	wire [31:0] Instr;
	
	datapath Datapath(
	   .clk(clk),
	   .reset(reset),
	   .RegWrite(RegWrite),
	   .MemWrite(MemWrite),
	   .RegDst(RegDst),
	   .SignExt(SignExt),
	   .ALUSrc(ALUSrc),
	   .beq(beq),
	   .j_jal(j_jal),
	   .jr(jr),
	   .WhichtoReg(WhichtoReg),
	   .ALUOp(ALUOp),
	   .Sel(Sel),
	   .Instr(Instr),
	   .bgez(bgez)
	);
	Controller controller(
	   .Instr(Instr),
	   .RegWrite(RegWrite),
	   .MemWrite(MemWrite),
	   .RegDst(RegDst),
	   .SignExt(SignExt),
	   .ALUSrc(ALUSrc),
	   .beq(beq),
	   .j_jal(j_jal),
	   .jr(jr),
	   .WhichtoReg(WhichtoReg),
	   .ALUOp(ALUOp),
	   .Sel(Sel),
	   .bgez(bgez)
	);
	
endmodule
