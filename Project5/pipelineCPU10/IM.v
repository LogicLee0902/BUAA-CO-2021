`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 18:54:35
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

`include "define.v"

module IM(
    input [31:0] PC,
    output [31:0] Instr
    );
	reg [31:0] ImMem[0:4095];
	integer i;
	
	initial begin
		for (i=0;i<4096;i=i+1)
			ImMem[i]=0;
		$readmemh("code.txt",ImMem,0);
	end
	
	assign Instr = ImMem[PC[13:2] - 32'hc00];
	
endmodule 
