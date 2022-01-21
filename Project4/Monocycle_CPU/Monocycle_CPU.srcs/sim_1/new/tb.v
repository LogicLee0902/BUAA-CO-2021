`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 22:33:19
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
   // Inputs
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
		File = $fopen("src.txt", "w");
		$fclose(File);
		clk = 0;
		reset = 1;
        #3 reset = 0;
		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
	end
always #1 clk = ~clk;
endmodule
