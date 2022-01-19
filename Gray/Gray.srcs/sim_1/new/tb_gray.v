`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 23:12:28
// Design Name: 
// Module Name: tb_gray
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


module tb_gray();
    reg Clk;
    reg En;
    reg Reset;
    wire [2:0]Output;
    wire Overflow;
    
    gray uut(
        .Clk(Clk),
        .En(En),
        .Reset(Reset),
        .Output(Output),
        .Overflow(Overflow)
    );
    initial 
    begin
        En = 0;
        Clk = 0;
        Reset = 0;
           #10 En = 1;
        #40 Reset = 1;
        #10 Reset = 0;
        #90 Reset = 1;
        #15 Reset = 0;
       end
        always #5 Clk = ~Clk;
endmodule
