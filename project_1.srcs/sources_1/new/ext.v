`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 21:12:46
// Design Name: 
// Module Name: ext
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


module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output reg [310:0] ext
    );
    wire [31:0]Tmp;
    assign Tmp = {{16{imm[15]}}, im`m};
    always@(*)
    begin
        case(EOp)
        2'b00:
        begin
           ext = Tmp;   
        end
        2'b01:
        begin
            ext = imm;
        end
       2'b10:
       begin
            ext = imm << 16;
       end
       2'b11:
       begin
            ext  = Tmp << 2;
       end
       endcase 
    end
endmodule
