`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 22:24:30
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


module EXT(
    input [15:0] imm16,
    input EXTOp,
    output reg [31:0] imm32
    );
    
parameter ZeroExtend = 1'b0;
parameter SignExtend = 1'b1;    
    always @(*)
    begin
        case(EXTOp)
            ZeroExtend:
                imm32 = {16'b0, imm16};
            SignExtend:
                imm32 = {{16{imm16[15]}}, imm16};
            default:
                imm32 = 0;
        endcase
    end
endmodule
