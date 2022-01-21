`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 01:23:03
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
    input Memwrite,
    input reset,
    input clk,
    input [31:0] Address,
    input [31:0] WD,
    output [31:0] RD,
    input [31:0] PC
    );
    reg [31:0] DM[1023:0];
	integer i, File;
	initial begin
		for (i = 0; i < 1024; i = i + 1)
			DM[i] = 0;
	end
	
	assign RD = DM[Address[11:2]];
	
	always@(posedge clk) 
	begin
		if(reset == 1) 
		begin
			for (i = 0; i < 1024; i = i + 1)
				DM[i] = 0;
		end
		else begin
		    File = $fopen("src.txt", "a+");
			if(Memwrite == 1) begin
				DM[Address[11:2]] = WD;
				$display("@%h: *%h <= %h", PC,Address, WD);		// the pre-test requires
				$fdisplay(File, "@%h: *%h <= %h", PC,Address, WD);
			end
		end
		$fclose(File);
	end
endmodule
