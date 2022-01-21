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
`include "define.v"

module mips_CPU(
    input clk,
    input reset,
    input [5:0] HWInt,
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
    output [31:0] w_inst_addr,
    output [31:0] macroscopic_pc,
    output Response
);
	//改成分布式编码好了，在每一级传递Instr
	wire [31:0] InstrF, PCJump, PCF, ADD4;
	wire [31:0] MFCMP1D;
	//wire [1:0] NPCOp;
	wire [31:0] InstrD;
	wire enPC, Busy, stall_md, Mul_DivD, Start;
	assign stall_md = (Busy || Start) && Mul_DivD; 
	
	//for Error
    wire [31:0]PCF_New, EPC;
    wire EretD, Exc_AdELF, DelayF, DelayD;
    wire [4:0]EXCCodeF, EXCCodeD;
    wire Request;
    wire Exc_RID;
    wire [2:0]NPCOpD;
    
    wire [4:0]A1D, A2D, A1E, A2E, A3E, A2M, A3M;
	
	StageF Fetch(
	    .InstrD(InstrD),
		.enPC(enPC),
		.EPC(EPC),
		.eret(EretD),
		.clk(clk),
		.reset(reset),
		.stall_md(stall_md),
		.PCJump(PCJump),
		.RD1(MFCMP1D),
		.ADD4(ADD4),
		.PCF_New(PCF_New),
		.NPCOp(NPCOpD),
		.Request(Request)
	);
	
	
//	assign PCF_New = (EretD === 1'b1)? EPC : PCF;
	assign Exc_AdELF= ((PCF_New < 32'h0000_3000) || (PCF_New > 32'h0000_6ffc) || (|PCF_New[1:0])) && !EretD;   
	assign i_inst_addr = PCF_New;
	assign InstrF = (Exc_AdELF === 1'b1)? 32'h0000_0000 : i_inst_rdata;
	assign EXCCodeF = (Exc_AdELF === 1'b1) ? `EXC_AdEL : `EXC_NULL;
	assign DelayF = (NPCOpD === `NPC || NPCOpD === `MFPCF) ? 1'b1 : 1'b0;
   
    wire [31:0] PC4W, PC4E, PC4M, PC4D;
    
    wire enIFID, FlushIDEX, stall;
	wire[3:0] MCMP1D,MCMP2D,MALUBE,MALUAE;
    IFID ifid(
        .clk(clk),
        .Request(Request),
        .reset(reset),
        .en(enIFID),
        .InstrF(InstrF),
        .ADD4(ADD4),
        .EXCCodeF(EXCCodeF),
        .DelayF(DelayF),
        .InstrD(InstrD),
        .PC4D(PC4D),
        .stall_md(stall_md),
        .EXCCodeD(EXCCodeD),
        .DelayD(DelayD)
    );
    
    wire [4:0] A3W;
    wire [31:0] WDW, CP0RDW;
    wire RegWriteW;
    
    
    assign w_grf_addr = A3W;
    assign w_grf_wdata = WDW;
    assign w_grf_we = RegWriteW;
    assign w_inst_addr = PC4W-4 ;
    
    //StageD Decode
    wire [31:0]ResM, ResW, HIW, HIM, LOW, LOM, MemRDW;
    wire [31:0]MFCMP2D, imm32D;
    wire [4:0] EXCCodeD_New, EXCCodeE;
    
    
	StageD Decode(
//	   .Request(Request),
	   .EPC(EPC),
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
	   .CP0RDW(CP0RDW),
	   .PCJump(PCJump),
	   .MFCMP1D(MFCMP1D),
	   .MFCMP2D(MFCMP2D),
	   .imm32D(imm32D),
	   .Mul_Div(Mul_DivD),
	   .EretD(EretD),
	   .Exc_RID(Exc_RID)
	 );
	 
	 assign EXCCodeD_New = (|EXCCodeD) ? EXCCodeD:
	                       Exc_RID ? `EXC_RI:`EXC_NULL;
	 
	 // DE_REG
	wire [31:0]InstrE;
    wire [31:0]RD1E, RD2E, imm32E;
    wire DelayE;
	IDEX idex(
	   //D-Level
	    .stall(stall),
	    .Request(Request),
		.clk(clk),
		.reset(reset),
		.flush(FlushIDEX),
		.RD1D(MFCMP1D),
		.RD2D(MFCMP2D),
		.imm32D(imm32D),
		.PC4D(PC4D),
		.InstrD(Exc_RID ? 32'h0 : InstrD),
		.stall_md(stall_md),
		.EXCCodeD(EXCCodeD_New),
		.DelayD(DelayD),
		//E-Level
		.RD1E(RD1E),
		.RD2E(RD2E),
		.imm32E(imm32E),
		.PC4E(PC4E),
		.InstrE(InstrE),
		.EXCCodeE(EXCCodeE),
		.DelayE(DelayE)
	);
	
	//E Stage
	wire [31:0]HIE, LOE;
	wire [31:0]ResE, MemWDE;
	wire Exc_OvE, Exc_AddrE;
	
	StageE Execute(
	    .clk(clk),
	    .CP0RDW(CP0RDW),
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
		.imm32(imm32E),
		.is_OvE(Exc_OvE),
		.is_AddressE(Exc_AddrE)
	);
	
	wire [4:0] EXCCodeE_New;
	//EM-REG
	wire [31:0]MemWDM;
	wire [31:0]InstrM;
	wire [4:0]EXCCodeM;
	wire DelayM, Exc_AddrM;
	
	assign EXCCodeE_New = (|EXCCodeE) ? EXCCodeE :
	                       Exc_OvE ? `EXC_Ov: `EXC_NULL;
	EXME exme(
		.clk(clk),
		.reset(reset),
		.Request(Request),
		//E-Level
		.InstrE(InstrE),
		.MemWDE(MemWDE),
		.ResE(ResE),
		.PC4E(PC4E),
		.HIE(HIE),
		.LOE(LOE),
		.EXCCodeE(EXCCodeE_New),
		.Exc_AddrE(Exc_AddrE),
		.DelayE(DelayE),
		// M-Level
		.MemWDM(MemWDM),
		.ResM(ResM),
		.PC4M(PC4M),
		.InstrM(InstrM),
		.HIM(HIM),
		.LOM(LOM),
		.EXCCodeM(EXCCodeM),
		.DelayM(DelayM),
		.Exc_AddrM(Exc_AddrM)
	);
	
	wire [2:0]MDMM;
	wire [31:0]MemRDM;
	wire Exc_AdELM, Exc_AdESM, eretM;
	wire [4:0]EXCCodeM_New;
	//M  Stage
	assign  m_data_addr = ResM; 
	assign   m_inst_addr = PC4M-4;
	wire [31:0]MFDMM;
	
	StageM Memory(
       .Exc_AddrM(Exc_AddrM),
	   .clk(clk),
	   .reset(reset),
	   .InstrM(InstrM),
	   .MemWD(MemWDM),
	   .ResM(ResM),
	   .ResW(ResW),
	   .HIW(HIW),
	   .LOW(LOW),
	   .CP0RDW(CP0RDW),
	   .MDMM(MDMM),
	   .PC4W(PC4W),
	   .PC4M(PC4M),
	   .MemRDW(MemRDW),
	   .m_data_rdata(m_data_rdata),
	   .m_data_wdata(m_data_wdata),
	   .m_data_byteen(m_data_byteen),
	   .MemRD(MemRDM),
	   .Exc_AdESM(Exc_AdESM),
	   .Exc_AdELM(Exc_AdELM),
	   .MFDMM(MFDMM),
	   .eretM(eretM),
	   .Request(Request)
	);
	
	assign EXCCodeM_New = (|EXCCodeM) ? EXCCodeM:
	                       Exc_AdELM ? `EXC_AdEL:
	                       Exc_AdESM ? `EXC_AdES:`EXC_NULL;
	                       
	 //CP0
	 assign macroscopic_pc = PC4M - 4;
	 
	 wire [31:0] CP0RDM;
	mips_CP0 cp0(
	   .Instr(InstrM),
	   .clk(clk),
	   .reset(reset),
	   .WDin(MFDMM),
	   .PC(PC4M-4),
	   .Delay(DelayM),
	   .EXCCodeIn(EXCCodeM_New),
	   .HWInt(HWInt),
	   .EXLClr(eretM),
	   .Request(Request),
	   .EPCOut(EPC),
	   .WDOut(CP0RDM),
	   .Response(Response)
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
		.CP0RDM(CP0RDM),
		//W-Level
		.ResW(ResW),
		.MemRDW(MemRDW),
		.A3W(A3W),
		.PC4W(PC4W),
		.InstrW(InstrW),
		.HIW(HIW),
		.LOW(LOW),
		.CP0RDW(CP0RDW),
		.Request(Request)
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
	   .RegWriteW(RegWriteW),
	   .CP0RDW(CP0RDW)
	);
	wire Tuse_rs0,Tuse_rs1,Tuse_rt0,Tuse_rt1,Tuse_rt2; 
	wire [4:0]A3D, A1M;
	
	wire [2:0]resOpM, resOpE, resOpW; 
	/*
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
	);*/
	Decoder decode_Tuse(
	    .Instr(InstrD),
	    .Tuse_rs0(Tuse_rs0),
   		.Tuse_rs1(Tuse_rs1),
   		.Tuse_rt0(Tuse_rt0),
   		.Tuse_rt1(Tuse_rt1),
   		.Tuse_rt2(Tuse_rt2)
	);
	
	Decoder ControlD(
	   .Instr(InstrD),
	   .A3(A3D),
	   .rs(A1D),
	   .rt(A2D)
	);
	Decoder ControlE(
	   .Instr(InstrE),
	   .A3(A3E),
	   .rs(A1E),
	   .rt(A2E),
	   .resOp(resOpE)
	);
	Decoder ControlM(
	   .Instr(InstrM),
	   .A3(A3M),
	   .rs(A1M),
	   .rt(A2M),
	   .resOp(resOpM)
	);
	Decoder ControlW(
	   .Instr(InstrW),
	   .A3(A3W),
	   .resOp(resOpW)
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
	    .InstrD(InstrD),
	    .InstrE(InstrE),
	    .InstrM(InstrM),
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
