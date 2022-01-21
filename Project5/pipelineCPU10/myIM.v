`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 01:32:34
// Design Name: 
// Module Name: IM
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


module IM(
    input [31:0] PC,
    output [31:0] Instr
    );
    reg[31:0] ImMem[0: 4095];
	integer i;
	initial 
	begin
	   for(i = 0; i < 4096; i = i + 1)
	   begin
	       ImMem[i] = 32'h0;
	   end
	   $readmemh("code.txt", ImMem);
	end
	
	assign Instr = ImMem[PC[13:2]-32'hc00];
endmodule
