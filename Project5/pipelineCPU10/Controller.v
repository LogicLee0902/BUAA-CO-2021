`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 19:52:19
// Design Name: 
// Module Name: Controller
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

module Controller(
	input [31:0]Instr,
	output reg ALUSrc,
	output reg [1:0]MemtoReg,
	output reg RegWrite,
	output reg MemWrite,
	output reg [1:0]npcsel,
	output reg [1:0]EXTOp,
	output reg [2:0]ALUOp,
	output reg beq,
	output reg j,
	output reg jal
    );
	reg addu,subu,ori,lui,sw,lw,jr;
	always@(*)begin
		 addu <= (Instr[`op]==`R&&Instr[`func]==`ADDU)?1:0;
		 subu <= (Instr[`op]==`R&&Instr[`func]==`SUBU)?1:0;
		 ori <= (Instr[`op]==`ORI)?1:0;
		 lui <= (Instr[`op]==`LUI)?1:0;
		 beq <= (Instr[`op]==`BEQ)?1:0;
		 sw <= (Instr[`op]==`SW)?1:0;
		 lw <= (Instr[`op]==`LW)?1:0;
		 j <= (Instr[`op]==`J)?1:0;
		 jal <= (Instr[`op]==`JAL)?1:0;
		 jr <= (Instr[`op]==`R&&Instr[`func]==`JR) ?1:0;
	 
		npcsel<= (addu|subu|ori|lui|sw|lw)?`ADD4:
				(beq|j|jal)              ?`NPC:
				(jr)                     ?`MFPCF:0;
		ALUSrc <= (ori|lui|sw|lw)?1:0;
		
		MemtoReg<= (addu|subu|ori|lui)?`Res:
				  (lw)               ?`RegRD:
				  (jal)              ?`PC8:0;
		EXTOp <= (lw|sw)?`sign_ext:
				 (ori) ?`zero_ext:
				 (lui) ?`high_ext:0;
		ALUOp <= (addu|lui|sw|lw)?`add:
				(subu)          ?`sub:
				(ori)           ?`ori:0;
		MemWrite<= (sw)?1:0;
		RegWrite<= (addu|subu|ori|lui|lw|jal)?1:0;
	end

endmodule
