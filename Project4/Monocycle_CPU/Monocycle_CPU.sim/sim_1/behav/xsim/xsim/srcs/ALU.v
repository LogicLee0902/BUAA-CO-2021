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


module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] ALUOp,
    output Zero,
    output reg [31:0] Result
    );
    parameter ADDU = 3'b000;
    parameter SUBU = 3'b001;
    parameter ORI = 3'b010;
    parameter LUI = 3'b011;
    
    assign Zero = (SrcA == SrcB) ? 1:0;
    always @(*)
    begin
        case (ALUOp)
        ADDU:
            Result = SrcA + SrcB;
        SUBU:
            Result = SrcA - SrcB;
        ORI:
            Result = SrcA | SrcB;
        LUI:
            Result = {SrcB[15:0], 16'h0};
        default:
            Result = 0;
        endcase
    end
endmodule
