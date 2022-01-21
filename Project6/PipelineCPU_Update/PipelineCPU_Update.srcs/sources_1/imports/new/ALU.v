`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 19:25:32
// Design Name: 
// Module Name: ALU
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

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [31:0] InstrE,
    output reg [31:0] Res
    );
    wire [3:0] ALUOp;
    Decoder decode_ALU(
    	.Instr(InstrE),
    	.ALUOp(ALUOp)
    );
	always @(*) 
	begin
		case(ALUOp)
			`add: 
			     Res = A + B;
			`sub: 
			     Res = A - B;
			`ori: 
			     Res = A | B;
			`andi:
				 Res = A & B;
			`xori:
				Res = A ^ B;
			`nori:
				Res = ~(A|B);
			`left:
				Res = B << A[4:0];
			`sign_right:
				Res = $signed($signed(B) >> A[4:0]);
			`zero_right:
				Res = B >> A[4:0];
			`sign_less:
				Res = ($signed(A)) < ($signed(B));
			`zero_less:
				Res  = (A<B);
			default: 
			     Res = 0;
		endcase
	end

endmodule
