`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 10:21:49
// Design Name: 
// Module Name: NPC
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


module NPC(
    input btype,
    input jr,
    input j_jal,
    input [31:0] JrJump,
    input [31:0] imm32,
    input [31:0] Instr,
    output reg[31:0] NPC,
    input [31:0] PCF,
    input [31:0] PCD
    );
    
    always@(*)
    begin
        if(btype == 1)
        begin
            NPC = PCD + 4 + (imm32 << 2);
        end
        else if(j_jal == 1)
        begin
            NPC = {PCD[31:28], Instr[25:0], 2'b00};  
        end
        else if(jr == 1)
        begin
            NPC = JrJump;
        end
        else if(Instr !== 32'hXXXXXXXX) NPC = PCF+4;
    end
endmodule
