`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 15:29:37
// Design Name: 
// Module Name: Forward Controller
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
module Forward_Unit(
	input [4:0]A1D,
	input [4:0]A2D,
	input [4:0]A1E,
	input [4:0]A2E,
	input [4:0]A3E,
	input [4:0]A2M,
	input [4:0]A3M,
	input [2:0]resOpE,
	input [2:0]resOpM,
	input [4:0]A3W,
	input [2:0]resOpW,
	
	output [3:0]MCMP1D,
	output [3:0]MCMP2D,
	output [3:0]MALUAE,
	output [3:0]MALUBE,
	output [2:0]MDMM
);
		 
	assign MALUAE = (A1E == 0)							?0:
					((A1E == A3M) && ( resOpM == `ALU))	?`ME_ALU:
					((A1E == A3M) && (resOpM == `PC))	?`ME_PC:
					((A1E == A3M) && (resOpM == `HIout))?`ME_HI:
					((A1E == A3M) && (resOpM == `LOout))?`ME_LO:
					((A1E == A3W) && (resOpW == `ALU))	?`WE_ALU:
					((A1E == A3W) && (resOpW == `PC))	?`WE_PC:
					((A1E == A3W) && (resOpW == `DM))	?`WE_DM:
					((A1E == A3W )&& (resOpW == `HIout))?`WE_HI:
					((A1E == A3W) && (resOpW == `LOout))?`WE_LO:
					((A1E == A3W) && (resOpW == `CP0Out))?`WE_CP0:
														0;
	//MFALUBE
	assign MALUBE = (A2E == 0)							?0:
					((A2E == A3M) && (resOpM == `ALU))	?`ME_ALU:
					((A2E == A3M) && (resOpM ==`PC))	?`ME_PC:
					((A2E == A3M) && (resOpM == `HIout))?`ME_HI:
					((A2E == A3M) && (resOpM == `LOout))?`ME_LO:
					((A2E == A3W) && (resOpW == `ALU))	?`WE_ALU:
					((A2E == A3W) && (resOpW == `PC))	?`WE_PC:
					((A2E == A3W) && (resOpW == `DM))	?`WE_DM:
					((A2E == A3W) && (resOpW == `HIout))?`WE_HI:
					((A2E == A3W) && (resOpW == `LOout))?`WE_LO:
					((A2E == A3W) && (resOpW == `CP0Out))?`WE_CP0:
														0;  
		
	//MCMP1D	
	assign MCMP1D = (A1D == 0)							?0:
					((A1D == A3M) && (resOpM == `ALU))	?`MD_ALU:
					((A1D == A3M) && (resOpM == `PC))	?`MD_PC:
					((A1D == A3M) && (resOpM == `HIout))?`MD_HI:
					((A1D == A3M) && (resOpM == `LOout))?`MD_LO:
					((A1D == A3W) && (resOpW == `ALU))	?`WD_ALU:
					((A1D == A3W) && (resOpW == `PC))	?`WD_PC:
					((A1D == A3W) && (resOpW == `DM))	?`WD_DM:
					((A1D == A3W) && (resOpW == `HIout))?`WD_HI:
					((A1D == A3W) && (resOpW==`LOout))	?`WD_LO:
					((A1D == A3W) && (resOpW == `CP0Out))?`WD_CP0:
														0;  
	//MFCMP2D
	assign MCMP2D = (A2D == 0)							?0:
					((A2D == A3M) && (resOpM == `ALU))	?`MD_ALU:
					((A2D == A3M) && (resOpM == `PC))	?`MD_PC:
					((A2D == A3M) && (resOpM == `HIout))?`MD_HI:
					((A2D == A3M) && (resOpM == `LOout))?`MD_LO:
					((A2D == A3W) && (resOpW == `ALU))	?`WD_ALU:
					((A2D == A3W) && (resOpW == `PC))	?`WD_PC:
					((A2D == A3W) && (resOpW == `DM))	?`WD_DM:
					((A2D == A3W) && (resOpW == `HIout))?`WD_HI:
					((A2D == A3W) && (resOpW == `LOout))?`WD_LO:
					((A2D == A3W) && (resOpW == `CP0Out))?`WD_CP0:
														0;
														 
	assign MDMM = 	(A2M == 0)							?0:
				  	((A2M == A3W) && (resOpW == `ALU))	?`WM_ALU:
					((A2M == A3W) && (resOpW == `PC))	?`WM_PC:
					((A2M == A3W) && (resOpW == `DM))	?`WM_DM:
					((A2M == A3W) && (resOpW == `HIout))?`WM_HI:
					((A2M == A3W) && (resOpW == `LOout))?`WM_LO:
					((A2M == A3W) && (resOpW == `CP0Out))?`WM_CP0:
														0;  
endmodule
