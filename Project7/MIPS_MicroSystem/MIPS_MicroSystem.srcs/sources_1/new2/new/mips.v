`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/20 12:07:01
// Design Name: 
// Module Name: mips
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


module mips(    
    input clk,                        
    input reset,                     
    input interrupt,           //external interrupt signal
    output [31:0] macroscopic_pc,    // macro_PC
    output [31:0] i_inst_addr,       // Instructiom PC
    input  [31:0] i_inst_rdata,      // Instruction data
    output [31:0] m_data_addr,       // Write Data Address
    input  [31:0] m_data_wdata,      // The Data needed to be written 
    output [31:0] m_data_rdata,      // the data provided by the DM
    output [3:0] m_data_byteen,         // the enable signal
    output [31:0] m_inst_addr,       // M level PC
    output w_grf_we,                 // write enable
    output [4 :0] w_grf_addr,        // the specific reg
    output [31:0] w_grf_wdata,       // data needed to be written 
    output [31:0] w_inst_addr        // W level PC
);

    wire [31:0] tmp_m_data_wdata, tmp_m_data_addr;
    wire [3:0] tmp_m_data_byteen;
    wire [31:0] tmp_m_data_rdata;
    wire TC1_IRQ, TC0_IRQ; 

    wire [31:0] bridge_m_data_addr;
    wire [3:0] bridge_m_data_byteen;

    wire [5:0] HWInt;
    //TC0
    wire [31:0] TC0_Addr, TC0_Din, TC0_Dout;
    wire TC0_WD, TC0_WE;
    //TC1
    wire [31:0] TC1_Addr, TC1_Din, TC1_Dout;
    wire TC1_WD, TC1_WE;
    
    
    wire Response;
    
    assign HWInt = {3'b0, interrupt, TC1_IRQ, TC0_IRQ}; 
    
    mips_CPU cpu(
        .clk(clk),
        .reset(reset),
        .HWInt(HWInt),
        .macroscopic_pc(macroscopic_pc),

        .i_inst_addr(i_inst_addr),
        .i_inst_rdata(i_inst_rdata),

        .m_data_addr(tmp_m_data_addr),
        .m_data_wdata(tmp_m_data_wdata),
        .m_data_byteen(tmp_m_data_byteen),

        .m_data_rdata(tmp_m_data_rdata),
        .m_inst_addr(m_inst_addr),

        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),

        .w_inst_addr(w_inst_addr),
        .Response(Response)
    );

    assign m_data_addr = (Response && interrupt) ? 32'h0000_7f20 : bridge_m_data_addr;
    assign m_data_byteen = !(Response && interrupt) ? bridge_m_data_byteen : 1;

    mips_Bridge bridge(
        .m_data_addr_new(bridge_m_data_addr),
        .m_data_wdata_new(m_data_wdata),
        .m_data_byteen_new(bridge_m_data_byteen),
        .m_data_rdata(m_data_rdata),
        
        .m_data_addr(tmp_m_data_addr),
        .m_data_wdata(tmp_m_data_wdata),
        .m_data_byteen(tmp_m_data_byteen),
        .m_data_rdata_new(tmp_m_data_rdata),
        //TC0
        .TC0_Addr(TC0_Addr),
        .TC0_WE(TC0_WE),
        .TC0_Din(TC0_Din),
        .TC0_Dout(TC0_Dout),
        //TC1
        .TC1_Addr(TC1_Addr),
        .TC1_WE(TC1_WE),
        .TC1_Din(TC1_Din),
        .TC1_Dout(TC1_Dout)
    );

    TC tc0(
        .clk(clk),
        .reset(reset),
        .WE(TC0_WE),
        .Addr(TC0_Addr[31:2]),
        .Din(TC0_Din),
        .Dout(TC0_Dout),
        .IRQ(TC0_IRQ)
    );

    TC tc1(
        .clk(clk),
        .reset(reset),
        .WE(TC1_WE),
        .Addr(TC1_Addr[31:2]),
        .Din(TC1_Din),
        .Dout(TC1_Dout),
        .IRQ(TC1_IRQ)
    );
    
  endmodule
