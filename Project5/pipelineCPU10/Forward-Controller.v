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
module Forward_Unit
(
	input [4:0]A1D,
	input [4:0]A2D,
	input [4:0]A1E,
	input [4:0]A2E,
	input [4:0]A3E,
	input [4:0]A2M,
	input [4:0]A3M,
	input [1:0]resOpE,
	input [1:0]resOpM,
	input [4:0]A3W,
	input [1:0]resOpW,
	
	output reg [2:0]MCMP1D,
	output reg [2:0]MCMP2D,
	output reg [2:0]MALUAE,
	output reg [2:0]MALUBE,
	output reg [1:0]MWDM
		 );
		 
	always@(*)
	begin
		if(A2E==0) 	//MALUBE
			MALUBE<=0;
		else 
		begin
			if(A2E==A3M)
			begin
				case(resOpM)
				`ALU: MALUBE<=`ME_ALU;
				`PC: MALUBE<=`ME_PC;
				//default: MALUBE<=0;
				endcase
			end
			else if(A2E==A3W)
			begin
				case(resOpW)
				`ALU: MALUBE<=`WE_ALU;
				`PC: MALUBE<=`WE_PC;
				`DM: MALUBE<=`WE_DM;
				endcase
			end
			else 
				MALUBE<=0;
		end 
		                                                     
		if(A1E==0)		 //MALUAE
			MALUAE<=0;
		else 
		begin
			if(A1E==A3M)
			begin
				case(resOpM)
				`ALU:MALUAE<=`ME_ALU;
				`PC:MALUAE<=`ME_PC;
				endcase
			end
			else if(A1E==A3W)
			begin
				case(resOpW)
				`ALU: MALUAE<=`WE_ALU;
				`PC: MALUAE<=`WE_PC;
				`DM: MALUAE<=`WE_DM;
				endcase
			end
			else 
				MALUAE<=0;
			end                                                       

		if(A1D==0) 		//MCMP1D
			MCMP1D<=0;
		else 
		begin
		    if(A1D == A3E)
		    begin
		    	case(resOpE)
		    	`PC: MCMP1D<=`ED_PC;
		    	endcase
		    end
			else if(A1D==A3M)
			begin
				case(resOpM)
				`ALU: MCMP1D<=`MD_ALU;
				`PC: MCMP1D<=`MD_PC;
				endcase
			end
			else if(A1D==A3W)
			begin
				case (resOpW)
				`ALU: MCMP1D<=`WD_ALU;
				`PC: MCMP1D<=`WD_PC;
				`DM: MCMP1D<=`WD_DM;
				endcase
			end
			else
				MCMP1D<=0;
		end                                                      
		if(A2D==0) 		//MCMP2D
			MCMP2D<=0;
		else 
		begin
			if(A2D == A3E)
		    begin
		    	case(resOpE)
		    	`PC: MCMP2D=`ED_PC;
		    	endcase
		    end
			else if(A2D==A3M)
			begin
				case(resOpM)
				`ALU: MCMP2D<=`MD_ALU;
				`PC: MCMP2D<=`MD_PC;
				endcase
			end
			else if(A2D==A3W)
			begin
				case(resOpW)
				`ALU: MCMP2D<=`WD_ALU;
				`PC: MCMP2D<=`WD_PC;
				`DM: MCMP2D<=`WD_DM;
				endcase
			end
			else 
				MCMP2D<=0;
		end                                                      
		if(A2M==0)			//MWDM
			MWDM<=0;
		else 
		begin
			if(A2M==A3W)
			begin
				case(resOpW)
				`ALU: MWDM<=`WM_ALU;
				`PC: MWDM<=`WM_PC;
				`DM: MWDM<=`WM_DM;
				endcase
			end
			else MWDM<=0;
		end  		
	end
endmodule
