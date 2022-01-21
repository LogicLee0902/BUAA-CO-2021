`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 10:14:13
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input [31:0] NPC,
    output reg [31:0] PC
    );
    parameter Initial_PC = 32'h0000_3000;
    initial 
    begin
    PC = Initial_PC;
    end
    always@(posedge clk)
    begin
        if(reset == 1'b1)
        begin
            PC <= Initial_PC;
        end
        else
        begin
            PC <= NPC;
        end
    end
endmodule
