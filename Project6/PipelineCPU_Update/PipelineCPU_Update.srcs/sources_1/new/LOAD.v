`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 00:28:24
// Design Name: 
// Module Name: LOAD
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

module LOAD(
	input [31:0] InstrM,
	input [31:0] Addr,
	input [31:0] m_data_rdata,
	output reg [31:0] MemRD
    );
    wire [2:0]SelOp;
    wire lbu, lb, lhu, lh;
    Decoder decode_load(
    	.Instr(InstrM),
    	.SelOp(SelOp),
    	.lbu(lbu),
    	.lhu(lhu),
    	.lb(lb),
    	.lh(lh)
    );
    always@(*)
    begin
    	case(SelOp)
    	`Word:
    		MemRD = m_data_rdata;
    	`Byte:
    		MemRD = (Addr[1:0] == 2'b00) ? (lb ? {{24{m_data_rdata[7]}},m_data_rdata[7:0]} :{24'b0, m_data_rdata[7:0]}):
    				(Addr[1:0] == 2'b01) ? (lb ? {{24{m_data_rdata[15]}},m_data_rdata[15:8]} :{24'b0, m_data_rdata[15:8]}):
    				(Addr[1:0] == 2'b10) ? (lb ? {{24{m_data_rdata[23]}},m_data_rdata[23:16]} :{24'b0, m_data_rdata[23:16]}):
    				(Addr[1:0] == 2'b11) ? (lb ? {{24{m_data_rdata[31]}},m_data_rdata[31:24]} :{24'b0, m_data_rdata[31:24]}):0;
    	`Half:
    		MemRD = (Addr[1] == 2'b0) ? (lh ? {{16{m_data_rdata[15]}},m_data_rdata[15:0]} :{16'b0, m_data_rdata[15:0]}):
    				(Addr[1] == 2'b1) ? (lh ? {{16{m_data_rdata[31]}},m_data_rdata[31:16]} :{16'b0, m_data_rdata[31:16]}):0;
    	default:
    		MemRD = 32'b0;
    	endcase
    end
endmodule