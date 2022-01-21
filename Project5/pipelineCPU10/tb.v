`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 21:41:51
// Design Name: 
// Module Name: tb
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


module tb;
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);
	integer File;
	initial begin
		// Initialize Inputs
		File = $fopen("std.txt", "w");
		$fclose(File);
		clk = 0;
		reset = 1;
		// Wait 100 ns for global reset to finish
		#3;
      reset=0;
		// Add stimulus here
		#8000 $finish;
	end
   always #1 clk=~clk;
	
endmodule
