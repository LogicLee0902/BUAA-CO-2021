`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 18:54:48
// Design Name: 
// Module Name: StageM
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


module StageM(
	input [31:0]InstrM,
	input [31:0]MemWD,
	input [31:0]ResM,
	input [31:0]ResW,
	input [31:0]HIW,
	input [31:0]LOW,
	input [31:0]CP0RDW,
	input clk,
	input reset,
	input Request,
	input [2:0] MDMM,
	input [31:0]PC4W,
	input [31:0]PC4M,
	input [31:0]MemRDW,
    input [31:0] m_data_rdata,
    input Exc_AddrM,
    //output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
	output [31:0]MemRD,
	output Exc_AdESM,
	output Exc_AdELM,
	output [31:0] MFDMM,
	output eretM
    );
    wire MemWriteM;
   Decoder decode_M(
        .Instr(InstrM),
        .eret(eretM),
        .MemWrite(MemWriteM)
   );
    
    MUX_7_32 mfdmm(
    	.in0(MemWD),
    	.in1(ResW),
    	.in2(PC4W+4),
    	.in3(MemRDW),
    	.in4(HIW),
    	.in5(LOW),
    	.in6(CP0RDW),
    	.sel(MDMM),
    	.out(MFDMM)
    );
 	
 	LOAD load(
 		.InstrM(InstrM),
 		.Addr(ResM),
 		.m_data_rdata(m_data_rdata),
 		.MemRD(MemRD),
 		.Exc_Addr(Exc_AddrM),
 		.Exc_AdEL(Exc_AdELM)
 	);
 	
 	SAVE save(
 		.InstrM(InstrM),
 		.Addr(ResM),
 		.MemWD(MFDMM),
 		.m_data_wdata(m_data_wdata),
 		.m_data_byteen(m_data_byteen),
 		.Exc_Addr(Exc_AddrM),
 		.Exc_AdES(Exc_AdESM),
 		.Request(Request)
 	);
    /*
    DASM Dasm(
    .pc(PC4M-4),
    .instr(InstrM),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);*/
endmodule
