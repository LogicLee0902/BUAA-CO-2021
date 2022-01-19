`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 21:35:02
// Design Name: 
// Module Name: BlockChecker_tb
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


module BlockChecker_tb;
    reg clk;
    reg reset;
    reg [7:0]in;
    wire result;
    
    BlockChecker uut(
        .clk(clk),
        .reset(reset),
        .in(in),
        .result(result)
    );
    reg [0:1023] S = "abcd";
    initial begin
        clk = 1;
        reset = 1;
        #5 reset = 0; 
        /*
        #5 in = " ";
        #10 in = "E";
        #10 in = "n";
        #10 in = "d";
        #10 in = "c";
        #10 in = " ";
        #10 in = "b";
        #10 in = "E";
        #10 in = "g";
        #10 in = "I";
        #10 in = "n";
        #10 in = " ";
        #10 in = "B";
        #10 in = "E";
        #10 in = "g";
        #10 in = "I";
        #10 in = "N";
        #10 in = "b";
        #10 in = "E";
        #10 in = "n";
        #10 in = "d";
        #10 in = " ";
        #10 in = "E";
        #10 in = "n";
        #10 in = "d";
        #10 in = "c";
        #10 in = " ";
        #10 in = "e";
        #10 in = "N";
        #10 in = "D";
        #10 in = " ";
        #10 in = "e";
        #10 in = "n";
        #10 in = "d";
        #10 in = " ";
        #10 in = "b";
        #10 in = "E";
        #10 in = "g";
        #10 in = "I";
        #10 in = "n";
        #10 in = " ";
        #10 in = "e";
        #10 in = "n";
        #10 in = "d";
        #5 reset = 1;
        #10 reset = 0;
        #10 in = "B";
        #10 in = "E";
        #10 in = "g";
        #10 in = "I";
        #10 in = "N";
        #10 in = " ";
        #10 in = "E";
        #10 in = "n";
        #10 in = "d";
        #10 in = "c";
        #10 in = " ";
        #10 in = "e";
        #10 in = "N";
        #10 in = "D";
        #10 in = " ";*/
       for(; S[0:7]; S = S << 8) begin
      in = S[0:7];
      #5;
      end
    end
    
    always #5 clk = ~clk;
endmodule
