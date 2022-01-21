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
    input beq,
    input bgez,
    input jr,
    input j_jal,
    input Zero,
    input GreaterZero,
    input [31:0] PC_jr,
    input [31:0] imm32,
    input [31:0] Instr,
    output [31:0] PC4,
    output reg[31:0] NPC,
    input [31:0] PC
    );
    assign PC4 = PC+4;
    
    always@(*)
    begin
        if(beq == 1 && Zero==1)
        begin
            NPC = PC + 4 + (imm32 << 2);
        end
        else if(bgez == 1 && GreaterZero == 1)
        begin
             NPC = PC + 4 + (imm32 << 2);
        end
        else if(j_jal == 1)
        begin
            NPC = {PC[31:28], Instr[25:0], 2'b00};  
        end
        else if(jr == 1)
        begin
            NPC = PC_jr;
        end
        else if(Instr !== 32'hXXXXXXXX) NPC = PC4;
    end
endmodule
