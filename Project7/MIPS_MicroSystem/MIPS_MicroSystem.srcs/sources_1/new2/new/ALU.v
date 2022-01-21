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
    input ALU_Res,
    input ALU_Addr,
    input [31:0] A,
    input [31:0] B,
    input [31:0] InstrE,
    output is_Ov,
    output is_Addr,
    output reg [31:0] Res
    );
    wire [3:0] ALUOp;
    Decoder decode_ALU(
    	.Instr(InstrE),
    	.ALUOp(ALUOp)
    );
    wire [32:0]ext_A, ext_B, ext_Res, ext_Res_Sub;
    assign ext_A = {A[31], A[31:0]};
    assign ext_B = {B[31], B[31:0]};
    assign ext_Res = (ALUOp == `add) ? ext_A + ext_B:
                     (ALUOp == `sub) ? ext_A - ext_B : 33'd0;
    assign is_Ov = (ALU_Res === 1'b1) && (ext_Res[32] != ext_Res[31]);
    assign is_Addr = (ALU_Addr === 1'b1) && (ext_Res[32] != ext_Res[31]);
    
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
				Res = $signed($signed(B) >>> A[4:0]);
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
