`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 14:22:51
// Design Name: 
// Module Name: EXT
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

module EXT(
	input [31:0] InstrD,
	output reg [31:0] imm32
	);
	wire [1:0]EXTOp;
	wire [15:0] imm16;
	assign imm16 = InstrD[15:0];
	Decoder decode_ext(
		.Instr(InstrD),
		.EXTOp(EXTOp)
	);
	always@(*)
	begin
		case(EXTOp)
			`zero_ext:
			     imm32 = {16'b0,imm16[15:0]};
			`sign_ext:
			     imm32 = {{16{imm16[15]}},imm16[15:0]};
			`high_ext:
			     imm32 = {imm16[15:0],16'b0};
			default:
			     imm32 = 0;
		endcase
	end
endmodule 
