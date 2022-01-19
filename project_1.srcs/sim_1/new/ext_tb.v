`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 21:25:01
// Design Name: 
// Module Name: ext_tb
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


module ext_tb;
       //input
       reg [15:0] inm;
       reg [1:0] E;
       wire [31:0] a;
    ext uut(
        .inm(inm),
        .EOp(E),
        .ext(a)
    );
    initial begin
    inm = 16'b0011_0101_1001_1011;
    E = 2'b00;
    #10
    E = 1;
    #10
    E = 2;
    #10
    E = 3;
    #10
    E = 4;
    end
endmodule
