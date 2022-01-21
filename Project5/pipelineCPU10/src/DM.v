`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 19:43:55
// Design Name: 
// Module Name: DM
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

module DM(
    input [31:0] Addr,
    input [31:0] MemWD,
    input MemWrite,
    input clk,
    input reset,
    input [31:0] PC4,
    output [31:0] MemRD
    );
	
	reg[31:0] dm[3072:0];
	wire [31:0]PC;
	integer i, File;
	assign PC=PC4-4; //show the PC for print
	assign MemRD=dm[Addr[13:2]];
	initial 
	begin
		for(i=0;i<3072;i=i+1)
			dm[i]=0;
	end
	
	always@(posedge clk)
	begin
//		File = $fopen("D:\\Archive\\Auto-Test\\pipelineCPU10\\new.txt", "a+");
		if(reset)
		begin
			for(i=0;i<3072;i=i+1)
				dm[i] <= 0;
		end
		else 
		begin
			if(MemWrite)
			begin
				dm[Addr[13:2]] <= MemWD;
				$display("%d@%h: *%h <= %h", $time, PC, Addr,MemWD);
//				$fdisplay(File, "@%h: *%h <= %h", PC, Addr,MemWD);
			end
		end
//		$fclose(File);
	end

endmodule
