`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 19:57:05
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
    input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
);
	//改成分布式编码好了，在每一级传递Instr
	wire [31:0] InstrF, PCJump, PCF, ADD4;
	wire [31:0] MFCMP1D;
	//wire [1:0] NPCOp;
	wire [31:0] InstrD;
	wire enPC, Busy, stall_md, Mul_DivD, Start;
	assign stall_md = (Busy || Start) && Mul_DivD; 
	
	StageF Fetch(
	    .InstrD(InstrD),
		.enPC(enPC),
		.clk(clk),
		.reset(reset),
		.stall_md(stall_md),
		.PCJump(PCJump),
		.RD1(MFCMP1D),
		.ADD4(ADD4),
		.PCF(PCF)
	);
	assign i_inst_addr = PCF;
	assign InstrF = i_inst_rdata;
	/*
	 assign w_grf_addr = W_GRFA3;
    assign w_grf_wdata = W_GRFWD;
    assign w_grf_we = W_GRFWrEn;
    assign w_inst_addr = W_PC;
    */
   
    wire [31:0] PC4W, PC4E, PC4M, PC4D;
    
    wire enIFID, FlushIDEX;
	wire[3:0] MCMP1D,MCMP2D,MALUBE,MALUAE;
    IFID ifid(
        .clk(clk),
        .reset(reset),
        .en(enIFID),
        .InstrF(InstrF),
        .ADD4(ADD4),
        .InstrD(InstrD),
        .PC4D(PC4D),
        .stall_md(stall_md)
    );
    
    wire [4:0] A3W;
    wire [31:0] WDW;
    wire RegWriteW;
    
    
    assign w_grf_addr = A3W;
    assign w_grf_wdata = WDW;
    assign w_grf_we = RegWriteW;
    assign w_inst_addr = PC4W-4 ;
    
    //StageD Decode
    wire [31:0]ResM, ResW, HIW, HIM, LOW, LOM, MemRDW;
    wire [31:0]MFCMP2D, imm32D;
    
	StageD Decode(
	   .clk(clk),
	   .reset(reset),
	   .RegWrite(RegWriteW),
	   .WD(WDW),
	   .A3(A3W),
	   .InstrD(InstrD),
	   .PC4D(PC4D),
	   .PC4E(PC4E),
	   .PC4M(PC4M),
	   .PC4W(PC4W),
	   .MCMP1D(MCMP1D),
	   .MCMP2D(MCMP2D),
	   .ResM(ResM),
	   .ResW(ResW),
	   .MemRDW(MemRDW),
	   .HIM(HIM),
	   .LOM(LOM),
	   .HIW(HIW),
	   .LOW(LOW),
	   .PCJump(PCJump),
	   .MFCMP1D(MFCMP1D),
	   .MFCMP2D(MFCMP2D),
	   .imm32D(imm32D),
	   .Mul_Div(Mul_DivD)
	 );
	 // DE_REG
	wire [31:0]InstrE;
    wire [31:0]RD1E, RD2E, imm32E;
	IDEX idex(
	   //D-Level
		.clk(clk),
		.reset(reset),
		.flush(FlushIDEX),
		.RD1D(MFCMP1D),
		.RD2D(MFCMP2D),
		.imm32D(imm32D),
		.PC4D(PC4D),
		.InstrD(InstrD),
		.stall_md(stall_md),
		//E-Level
		.RD1E(RD1E),
		.RD2E(RD2E),
		.imm32E(imm32E),
		.PC4E(PC4E),
		.InstrE(InstrE)
	);
	
	//E Stage
	wire [31:0]HIE, LOE;
	wire [31:0]ResE, MemWDE;
	StageE Execute(
	    .clk(clk),
	    .reset(reset),
	    .HIM(HIM),
	    .HIW(HIW),
	    .LOW(LOW),
	    .LOM(LOM),
		.PC4E(PC4E),
		.InstrE(InstrE),
		.PC4M(PC4M),
		.PC4W(PC4W),
		.MALUAE(MALUAE),
		.MALUBE(MALUBE),
		.ResM(ResM),
		.ResW(ResW),
		.MemRDW(MemRDW),
		.RD1(RD1E),
		.RD2(RD2E),
		.Res(ResE),
		.MFALUBE(MemWDE),
		.Busy(Busy),
		.Start(Start),
		.HIE(HIE),
		.LOE(LOE),
		.imm32(imm32E)
	);
	
	//EM-REG
	wire [31:0]MemWDM;
	wire [31:0]InstrM;
	EXME exme(
		.clk(clk),
		.reset(reset),
		//E-Level
		.InstrE(InstrE),
		.MemWDE(MemWDE),
		.ResE(ResE),
		.PC4E(PC4E),
		.HIE(HIE),
		.LOE(LOE),
		// M-Level
		.MemWDM(MemWDM),
		.ResM(ResM),
		.PC4M(PC4M),
		.InstrM(InstrM),
		.HIM(HIM),
		.LOM(LOM)
	);
	
	wire [2:0]MDMM;
	wire [31:0]MemRDM;
	//M  Stage
	assign  m_data_addr = ResM; 
	assign   m_inst_addr = PC4M-4;
	StageM Memory(
	   .clk(clk),
	   .reset(reset),
	   .InstrM(InstrM),
	   .MemWD(MemWDM),
	   .ResM(ResM),
	   .ResW(ResW),
	   .HIW(HIW),
	   .LOW(LOW),
	   .MDMM(MDMM),
	   .PC4W(PC4W),
	   .PC4M(PC4M),
	   .MemRDW(MemRDW),
	   .m_data_rdata(m_data_rdata),
	   .m_data_wdata(m_data_wdata),
	   .m_data_byteen(m_data_byteen),
	   .MemRD(MemRDM)
	);
	
	//M_W REG
	wire [31:0]InstrW;
	MEWB mewb(
		.clk(clk),
		.reset(reset),
		//M-Level
		.InstrM(InstrM),
		.PC4M(PC4M),
		.ResM(ResM),
		.MemRDM(MemRDM),
		.HIM(HIM),
		.LOM(LOM),
		//W-Level
		.ResW(ResW),
		.MemRDW(MemRDW),
		.A3W(A3W),
		.PC4W(PC4W),
		.InstrW(InstrW),
		.HIW(HIW),
		.LOW(LOW)
	);
	
	//W Stage
	StageW Writeback(
	   .InstrW(InstrW),
	   .PC4W(PC4W),
	   .ResW(ResW),
	   .MemRDW(MemRDW),
	   .HIW(HIW),
	   .LOW(LOW),
	   .WDW(WDW),
	   .RegWriteW(RegWriteW)
	);
	wire Tuse_rs0,Tuse_rs1,Tuse_rt0,Tuse_rt1,Tuse_rt2,stall; 
	wire [4:0]A1D, A2D, A1E, A2E, A3E, A2M, A3M;
	wire [2:0]resOpM, resOpE, resOpW; 
	AT_Unit AT(
	   .clk(clk),
	   .reset(reset),
	   .Instr(InstrD),
	   .A1D(A1D),
	   .A2D(A2D),
	   .stall_md(stall_md),
	   .FlushIDEX(FlushIDEX),
	   .A1E(A1E),
	   .A2E(A2E),
	   .A3E(A3E),
	   .A2M(A2M),
	   .A3M(A3M),
	   .A3W(A3W),
	   .resOpE(resOpE),
	   .resOpW(resOpW),
	   .resOpM(resOpM),
	   .Tuse_rs0(Tuse_rs0),
	   .Tuse_rs1(Tuse_rs1),
	   .Tuse_rt0(Tuse_rt0),
	   .Tuse_rt1(Tuse_rt1),
	   .Tuse_rt2(Tuse_rt2)
	);
	Forward_Unit forward(
		.A1D(A1D),
		.A2D(A2D),
		.A1E(A1E),
		.A2E(A2E),
		.A3E(A3E),
		.A2M(A2M),
		.A3M(A3M),
		.A3W(A3W),
		.resOpE(resOpE),
		.resOpM(resOpM),
		.resOpW(resOpW),
		.MCMP1D(MCMP1D),
		.MCMP2D(MCMP2D),
		.MALUAE(MALUAE),
		.MALUBE(MALUBE),
		.MDMM(MDMM)
	);
	Stall_Judge Stall_Controller(
		.Tuse_rs0(Tuse_rs0),
		.Tuse_rs1(Tuse_rs1),
		.Tuse_rt0(Tuse_rt0),
		.Tuse_rt1(Tuse_rt1),
		.Tuse_rt2(Tuse_rt2),
		.Instr(InstrD),
		.A3E(A3E),
		.A3M(A3M),
		.resOpE(resOpE),
		.resOpM(resOpM),
		.stall(stall)
	);
	Stall_Sign Stall(
		.stall(stall),
		.enPC(enPC),
		.enIFID(enIFID),
		.FlushIDEX(FlushIDEX)
	);

endmodule
