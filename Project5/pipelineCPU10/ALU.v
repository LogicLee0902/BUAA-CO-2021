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
    input [2:0] ALUOp,
    output reg [31:0] Res
    );
	always @(*) 
	begin
		case(ALUOp)
			`add: 
			     Res <= A + B;
			`sub: 
			     Res <= A - B;
			`ori: 
			     Res <= A | B;
			default: 
			     Res <= 0;
		endcase
	end

endmodule
