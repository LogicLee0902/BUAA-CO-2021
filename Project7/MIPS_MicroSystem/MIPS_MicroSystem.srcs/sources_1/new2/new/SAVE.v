`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 09:49:51
// Design Name: 
// Module Name: SAVE
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

module SAVE(
	input [31:0]InstrM,
	input [31:0]Addr,
	input [31:0]MemWD,
	input Exc_Addr,
	input Request,
	output Exc_AdES,
	output reg [31:0] m_data_wdata,
    output reg [3 :0] m_data_byteen
    );
    wire [2:0]SelOp;
    wire Store;
    wire Exc_Align, Exc_Range, Exc_Time;
    Decoder decode_save(
    	.Instr(InstrM),
    	.SelOp(SelOp),
    	.store(Store)
    );
    assign Exc_Align = (SelOp == `Word && (|Addr[1:0])) || (SelOp == `Half && (Addr[0]));
    assign Exc_Time = (SelOp != `Word) && (Addr >=  32'h0000_7f00) || ((Addr >= 32'h0000_7f08) && (Addr <= 32'h0000_7f0b)) || ((Addr >= 32'h0000_7f18) && (Addr <= 32'h0000_7f1b));
    assign Exc_Range = !(((Addr >= 32'h0000_0000) && (Addr <= 32'h0000_2fff)) || ((Addr >= 32'h0000_7f00) && (Addr <= 32'h0000_7f0b)) || ((Addr >= 32'h0000_7f10) && (Addr <= 32'h0000_7f1b)));
    
    assign Exc_AdES = ( Exc_Time || Exc_Align || Exc_Range || Exc_Addr) && Store; 
    always@(*)
    begin
        if(Store && !Request)
        begin
    	   case(SelOp)
    	   `Word:  m_data_wdata = MemWD;
    	   `Byte:
    			m_data_wdata =  (Addr[1:0] == 2'b00) ?{24'b0, MemWD[7:0]}:
    							(Addr[1:0] == 2'b01) ?{16'b0, MemWD[7:0], 8'b0}:
    							(Addr[1:0] == 2'b10) ?{8'b0, MemWD[7:0], 16'b0}:
    							(Addr[1:0] == 2'b11) ?{MemWD[7:0], 24'b0}:0;
    	   `Half:
    			m_data_wdata =  (Addr[1] == 1'b0) ? {16'b0, MemWD[15:0]}:
    							(Addr[1] == 1'b1) ? {MemWD[15:0], 16'b0}:0;
    	   default:m_data_wdata = 32'b0;
    	endcase
        end
        else m_data_wdata = 32'b0;
    end
    
    always@(*)
    begin
        if(Store && !Request)
    	begin
    	   case(SelOp)
    	   `Word:  m_data_byteen = 4'b1111;
    	   `Byte:  m_data_byteen = (Addr[1:0] == 2'b00) ? 4'b0001:
    							(Addr[1:0] == 2'b01) ? 4'b0010:
    							(Addr[1:0] == 2'b10) ? 4'b0100:
    							(Addr[1:0] == 2'b11) ? 4'b1000:4'h0;
    	   `Half:  m_data_byteen = (Addr[1] == 1'b0) ? 4'b0011:
    							(Addr[1] == 1'b1) ? 4'b1100: 4'h0;
    	   default: m_data_byteen = 4'h0;
    	endcase
    	end
    	else m_data_byteen = 4'h0;
    end
endmodule
