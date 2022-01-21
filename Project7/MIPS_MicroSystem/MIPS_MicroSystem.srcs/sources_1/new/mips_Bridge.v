`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/20 11:46:13
// Design Name: 
// Module Name: mips_Bridge
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


module mips_Bridge(
    output [31:0] m_data_addr_new,
    output [31:0] m_data_wdata_new,
    output [3:0] m_data_byteen_new,
    input [31:0] m_data_rdata,

    input [31:0] m_data_addr,
    input [31:0] m_data_wdata,
    input [3:0] m_data_byteen,
    output [31:0] m_data_rdata_new,

    output [31:0] TC0_Addr,
    output TC0_WE,
    output [31:0] TC0_Din,
    input [31:0] TC0_Dout,

    output [31:0] TC1_Addr,
    output TC1_WE,
    output [31:0] TC1_Din,
    input [31:0] TC1_Dout
   );

    assign m_data_addr_new = m_data_addr;
    assign TC0_Addr = m_data_addr;
    assign TC1_Addr = m_data_addr;

    assign TC0_Din = m_data_wdata;
    assign TC1_Din = m_data_wdata;
    assign m_data_wdata_new = m_data_wdata;

    wire SelTC0 = (m_data_addr >= 32'h0000_7f00) && (m_data_addr <= 32'h0000_7f0b),
         SelTC1 = (m_data_addr >= 32'h0000_7f10) && (m_data_addr <= 32'h0000_7f1b);

    wire WE = (| m_data_byteen);

    assign TC0_WE = WE && SelTC0;
    assign TC1_WE = WE && SelTC1;
    assign m_data_byteen_new = (SelTC0 || SelTC1) ? 4'd0 :
                                            m_data_byteen;
    
    assign m_data_rdata_new = (SelTC0) ? TC0_Dout :
                              (SelTC1) ? TC1_Dout :
                              m_data_rdata;

endmodule
