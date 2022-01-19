`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 22:52:38
// Design Name: 
// Module Name: gray
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


module gray(
    input Clk,
    input Reset,
    input En,
    output[2:0] Output,
    output Overflow
    );
    reg[63:0] Cnt = 0;
    assign Output = (Cnt%8 == 0)? 3'b000: 
                    (Cnt%8 == 1)? 3'b001:
                    (Cnt%8 == 2)? 3'b011:
                    (Cnt%8 == 3)? 3'b010:
                    (Cnt%8 == 4)? 3'b110:
                    (Cnt%8 == 5)? 3'b111:
                    (Cnt%8 == 6)? 3'b101: 3'b100;
    assign Overflow = (Cnt >= 8) ? 1: 0;
    
    always@(posedge Clk)
    begin
        if(Reset == 1)
        begin
            Cnt <= 0;
        end
        else if(En == 1)
        begin
            Cnt <= Cnt + 1;
        end
        else Cnt <= Cnt;
    end
    
endmodule
