`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 11:04:22
// Design Name: 
// Module Name: tb_string
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


module tb_string;
    reg clk;
    reg clr;
    reg [7:0]in;
    wire out;
    
    string uut(
        .clk(clk),
        .clr(clr),
        .in(in),
        .out(out)
    );
    initial
    begin
        clk = 1;
        clr = 0;
        in = "1";
        #10 in = "+";
        #10 in = "2";
        #10 in = "*";
        #10 in = "3";
        #20 clr = 1;
        #10 clr = 0;
        #10 in = "1";
        #10 in = "+";
        #10 in = "2";
        #10 in = "*";
        #10 in = "3";
    end
    always #5 clk = ~clk;
    
endmodule
