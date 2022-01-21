`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:35:20 11/20/2019
// Design Name:   mips
// Module Name:   C:/Users/mumuy/Desktop/ISE/pipelineCPU10/tb.v
// Project Name:  pipelineCPU10
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;
	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	integer File, FileM;
	initial begin
		// Initialize Inputs
		File = $fopen("src.txt", "w");
		FileM = $fopen("srcm.txt", "w");
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#1;
        reset = 0;
		// Add stimulus here
		#5000 $finish;
		
		$fclose(File);
		$fclose(FileM);
	end
	
	always #1 clk=~clk;
endmodule

