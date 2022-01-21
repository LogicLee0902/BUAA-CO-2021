`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 00:25:49
// Design Name: 
// Module Name: GRF
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


module GRF(
    input clk,
    input reset,
    input GRF_WE,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );
    
    reg [31:0] Reg[31:0];
    integer i;
    assign RD1 = (A1 === A3 && A1 != 0)? WD:Reg[A1];
	assign RD2 = (A2 === A3 && A2 != 0)? WD:Reg[A2];
    integer File;
    initial
    begin
        for(i = 0; i < 32; i=i+1)
        begin
            Reg[i] = 0;
        end
    end
    always @(posedge clk)
    begin
        if(reset == 1'b1)
        begin
            for(i = 0; i < 32; i=i+1)
             begin
                Reg[i] <= 0;
            end
        end
        else
        begin
            File = $fopen("src.txt", "a+");
            if(A3 != 0)  
            begin
                Reg[A3] <= WD;
                Reg[0] <= 0;
//                if(A3!=0)
                $display("%d@%h: $%d <= %h",$time, PC, A3, WD);
//                 $display("@%h: $%d <= %h", PC, A3, WD);
//              if(A3 != 0)
                $fdisplay(File, "@%h: $%d <= %h", PC, A3, WD);	
            end
            $fclose(File);
        end
    end
endmodule
