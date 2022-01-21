`timescale 1ns / 1ps
`include "mips.v"
`include "StageF.v"
`include "StageD.v"
`include "StageE.v"
`include "StageM.v"
`include "Stall.v"
`include "IFID.v"
`include "IDEX.v"
`include "EXME.v"
`include "MEWB.v"
`include "MUX.v"
`include "Controller.v"
`include "A-T Controller.v"
`include "Forward-Controller.v"
`include "PC.v"
`include "ADD4.v"
`include "IM.v"
`include "ALU.v"
`include "NPC.v"
`include "GRF.v"
`include "EXT.v"
`include "CMP.v"
`include "DM.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:25:35 11/12/2021
// Design Name:   mips
// Module Name:   G:/MyWorkspace/Computer_Organization/P4/P4_L0_CPU/mips_tb.v
// Project Name:  P4_L0_CPU
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
		File = $fopen("D:\\Archive\\Auto-Test\\pipelineCPU10\\new.txt", "w");
		$fclose(File);
		//$fclose(FileM);
		clk = 0;
		reset = 1;
		// Wait 100 ns for global reset to finish
		#3;
      reset=0;
		// Add stimulus here
		#20000 $finish;
	end
   always #1 clk=~clk;
endmodule
 