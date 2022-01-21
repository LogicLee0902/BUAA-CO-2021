`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 16:59:06
// Design Name: 
// Module Name: MulDiv
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

module MULDIV(
    input [31:0] Instr,
    input [31:0] D1,
    input [31:0] D2,
    input clk,
    input reset,
    output [31:0] HIOut,
    output [31:0] LOOut,
    output reg Busy,
    output Start
    );
    integer Cnt_M, Cnt_D;
    reg[31:0] HI, LO;
    wire [1:0]MDWrite;
    wire [2:0]MDCal;
    
    assign HIOut = HI;
    assign LOOut = LO;
    Decoder decoder_muldiv(
    		.Instr(Instr), 
    		.MDWrite(MDWrite), 
    		.MDcal(MDCal),
    		.Start(Start)
    		);
    		
    initial 
    begin
    	HI = 0;
    	LO = 0;
    	Busy = 0;
    	Cnt_M = 5;
    	Cnt_D = 10;
    end
    always@(posedge clk)
    begin
    	if(reset)
    	begin
    		HI <= 0;
    		LO <= 0;
    		Busy <= 0;
    		Cnt_M <= 5;
    		Cnt_D <= 10;
    	end
    	else
    	begin
    		if(MDWrite == `whi) HI <= D1;
    		else if(MDWrite == `wlo) LO <= D1;	
    		//MUL
    		if(Cnt_M == 0) //Finished MUL Calculation
    		begin
    			Busy <= 0; //clean the mul&div slot
    			Cnt_M <= 5; // wait for the next Calculation
    		end
    		else if(Cnt_M !=5) //during the MUL processs
    		begin
    			Busy <= 1;
    			Cnt_M <= Cnt_M - 1;
    		end
    		else //Begin the MUL
    		begin
    			if(MDCal == `sign_mults)
    			begin
    				Busy <= 1;
    				{HI, LO} <= $signed(D1)*$signed(D2);
    				Cnt_M <= Cnt_M - 1;
    			end
    			else if(MDCal == `mults)
    			begin
    				Busy <= 1;
    				{HI,LO} <= D1*D2;
    				Cnt_M <= Cnt_M - 1;
    			end
    		end
    		//Div
    		if(Cnt_D == 0) //over
    		begin
    			Busy <= 0;
    			Cnt_D <= 10;
    		end
    		else if(Cnt_D != 10) //doing process
    		begin
    			Busy <= 1;
    			Cnt_D <= Cnt_D - 1;
    		end	
    		else //start
    		begin
    			if(MDCal == `sign_divs)
    			begin
    				Busy <= 1;
    				HI <= $signed(D1) % $signed(D2);
    				LO <= $signed(D1) / $signed(D2);
    				Cnt_D <= Cnt_D - 1;
    			end
    			else if(MDCal == `divs)
    			begin
    				Busy <= 1;
    				HI <= D1 % D2;
    				LO <= D1 / D2;
    				Cnt_D <= Cnt_D - 1;
    			end
    		end
    	end
    end
endmodule
