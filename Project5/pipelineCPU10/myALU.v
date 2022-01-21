`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 23:22:39
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

`define ALU_addu 3'b000
`define ALU_subu 3'b001
`define ALU_ori 3'b010
`define ALU_lui 3'b011
`define ALU_sll 3'b100

module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [4:0] shamt,
    input [2:0] ALUOp,
    output reg [31:0] Result
    );
    
    always @(*)
    begin
        case (ALUOp)
        `ALU_addu:
            Result = SrcA + SrcB;
        `ALU_subu:
            Result = SrcA - SrcB;
        `ALU_ori:
            Result = SrcA | SrcB;
        `ALU_lui:
            Result = {SrcB[15:0], 16'h0};
//        `ALU_sll:
//           Result = SrcB << shamt;
        default:
            Result = 0;
        endcase
    end
endmodule
