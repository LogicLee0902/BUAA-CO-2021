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
    parameter MaxSize = 1024;
    reg[31:0] ImMem[MaxSize-1:0];
	integer i;
	initial begin
		for (i = 0; i < MaxSize; i = i + 1) begin
			ImMem[i] = 32'h0;
		end
	$readmemh("code.txt", ImMem);
	end
	
	assign Instr = ImMem[PC[11:2]];
endmodule
