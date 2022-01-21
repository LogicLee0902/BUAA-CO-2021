`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 10:54:22
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

`include "define.v"

module GRF(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input RegWrite,
    input clk,
    input reset,
	input [31:0] PC4,
    output[31:0] RD1,
    output [31:0] RD2
    );
	reg [31:0] Reg[0:31];
	wire [31:0] PC;
	integer i, File;
	
	assign PC=PC4-4;
	assign RD1=(A1==A3&&RegWrite&&A3!=0)?WD:Reg[A1];
	assign RD2=(A2==A3&&RegWrite&&A3!=0)?WD:Reg[A2];
	
	initial begin
		for(i=0;i<32;i=i+1)
			Reg[i]=0;
	end
	
	always @(posedge clk) 
	begin
		File = $fopen("D:\\Archive\\Auto-Test\\pipelineCPU10\\new.txt", "a+");
		if (reset) begin
			for (i=0;i<32;i=i+1)
				Reg[i]<=0;
		end
		else begin
			if (RegWrite && (A3!=0)) 
			begin
				Reg[A3] <= WD;
				$display("%d@%h: $%d <= %h",$time,PC,A3,WD);
				$fdisplay(File, "@%h: $%d <= %h",PC,A3,WD);
			end
		end
		$fclose(File);
	end
endmodule
