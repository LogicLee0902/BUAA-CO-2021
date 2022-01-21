`timescale 1ns / 1ps

`include "StageF.v"
`include "StageD.v"
`include "StageE.v"
`include "StageM.v"
`include "Stall.v"
`include "IFID.v"
`include "IDEX.v"
`include "EXME.v"
`include "MEWB.v"
`include "MUX.v"
`include "Controller.v"
`include "A-T Controller.v"
`include "Forward-Controller.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 10:35:47
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
    input reset
    );
    wire beq,j,jal,ALUSrc,RegWriteW,MemWriteD,enIFID,enPC,FlushIDEX;
	wire[1:0] NPCOp,EXTOp,MemtoReg,MWDM;
	wire[2:0]ALUOp,MCMP1D,MCMP2D,MALUBE,MALUAE;
	wire[4:0] A3W;
	//for PC
	wire [31:0] ADD4, NPCF, MFCMP1D, PCF, PCJump;
	//Instr
	wire [31:0] InstrD, InstrF;
	// stage F
	StageF fetch(
	   .NPCOp(NPCOp),
	   .clk(clk),
	   .reset(reset),
	   .enPC(enPC),
	   .PCJump(PCJump),
	   .RD1(MFCMP1D),
	   .InstrF(InstrF),
	   .ADD4(ADD4)
	);
	//IFID
	wire [31:0]PC4D;
	IFID ifid(
	   .clk(clk),
	   .reset(reset),
	   .ADD4(ADD4),
	   .en(enIFID),
	   .Instr(InstrF),
	   .PC4D(PC4D),
	   .InstrD(InstrD)
	);
	
	//StageD
	wire [31:0]MFCMP2D, imm32D;
	wire [31:0] PC4M, PC4E, PC4W;
	wire [31:0] ResM, ResW, MemRDW, WDW;
	StageD decode(
		.clk(clk),
		.reset(reset),
		.beq(beq),
		.j(j),
		.jal(jal),
		.RegWrite(RegWriteW),	
		.EXTOp(EXTOp),
		.WD(WDW),
		.A3(A3W),
		.InstrD(InstrD),
		.PC4D(PC4D),
		.PC4M(PC4M),
		.PC4E(PC4E),
		.PC4W(PC4W),
		.MCMP1D(MCMP1D),
		.MCMP2D(MCMP2D),
		.ResM(ResM),
		.ResW(ResW),
		.MemRDW(MemRDW),
		.PCJump(PCJump),
		.MFCMP1D(MFCMP1D),
		.MFCMP2D(MFCMP2D),
		.imm32D(imm32D)
	);
	
	//idex
	wire [1:0]resOpD, resOpE, MemtoRegE;
	wire [2:0] ALUOpE;
	wire [4:0]A3D, A3E, A2E, A1E, A1D, A2D;
	wire [31:0]RD1E, RD2E, imm32E, InstrE;
	wire ALUSrcE,MemWriteE, RegWriteE;
	wire RegWriteD;
	IDEX idex(
		.clk(clk),
		.reset(reset),
		.flush(FlushIDEX),
		.RD1D(MFCMP1D),
		.RD2D(MFCMP2D),
		.imm32D(imm32D),
		.PC4D(PC4D),
		.resOpD(resOpD),
		.A3D(A3D),
		.A2D(A2D),
		.A1D(A1D),
		.ALUSrcD(ALUSrc),
		.RegWriteD(RegWriteD),
		.MemWriteD(MemWriteD),
		.ALUOpD(ALUOp),
		.MemtoRegD(MemtoReg),
		//Out
		.RD1E(RD1E),
		.RD2E(RD2E),
		.imm32E(imm32E),
		.PC4E(PC4E),
		.resOpE(resOpE),
		.A3E(A3E),
		.A2E(A2E),
		.A1E(A1E),
		.ALUSrcE(ALUSrcE),
		.RegWriteE(RegWriteE),
		.MemWriteE(MemWriteE),
		.ALUOpE(ALUOpE),
		.MemtoRegE(MemtoRegE),
		.InstrD(InstrD),
		.InstrE(InstrE)
	);
	
	//StageE
	wire [31:0]ResE, MemWDE, MemWDM;
	wire [4:0]A2M, A3M;
	wire [1:0]resOpM, MemtoRegM;
	wire RegWriteM, MemWriteM;
	StageE Execute(
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
		.imm32(imm32E),
		.ALUOp(ALUOpE),
		.ALUSrc(ALUSrcE),
		.Res(ResE),
		.MFALUBE(MemWDE)
	);
	//EXME
	EXME exme(
		.clk(clk),
		.reset(reset),
		.MemWDE(MemWDE),
		.ResE(ResE),
		.MemtoRegE(MemtoRegE),
		.RegWriteE(RegWriteE),
		.MemWriteE(MemWriteE),
		.resOpE(resOpE),
		.A3E(A3E),
		.A2E(A2E),
		.PC4E(PC4E),
		.MemWDM(MemWDM),
		.ResM(ResM),
		.MemWriteM(MemWriteM),
		.MemtoRegM(MemtoRegM),
		.RegWriteM(RegWriteM),
		.resOpM(resOpM),
		.A3M(A3M),
		.A2M(A2M),
		.PC4M(PC4M)
	);
	
	//stage M
	wire [31:0]MemRDM;
	StageM Memory(
		//.InstrM(InstrM),
		.MemWD(MemWDM),
		.MemWrite(MemWriteM),
		.ResM(ResM),
		.ResW(ResW),
		.clk(clk),
		.reset(reset),
		.MDMM(MWDM),
		.PC4W(PC4W),
		.PC4M(PC4M),
		.MemRDW(MemRDW),
		.MemRD(MemRDM)
	);
	
	//MEWB
	wire [1:0]resOpW, MemtoRegW;
	MEWB mewb(
		.clk(clk),
		.reset(reset),
		.PC4M(PC4M),
		.PC4W(PC4W),
		.ResM(ResM),
		.MemRDM(MemRDM),
		.MemtoRegM(MemtoRegM),
		.resOpM(resOpM),
		.A3M(A3M),
		.RegWriteM(RegWriteM),
		.ResW(ResW),
		.MemRDW(MemRDW),
		.MemtoRegW(MemtoRegW),
		.resOpW(resOpW),
		.A3W(A3W),
		.RegWriteW(RegWriteW)
	);
	//For WriteBack
	MUX_4_32 mux_wb(
		.in0(ResW),
		.in1(MemRDW),
		.in2(PC4W),
		.in3(PC4W+4),
		.sel(MemtoRegW),
		.out(WDW)
	);
	
	//Control Signal
	Controller controller(
		.Instr(InstrD),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.RegWrite(RegWriteD),
		.MemWrite(MemWriteD),
		.npcsel(NPCOp),
		.EXTOp(EXTOp),
		.ALUOp(ALUOp),
		.beq(beq),
		.j(j),
		.jal(jal)
	);
	wire Tuse_rs0,Tuse_rs1,Tuse_rt0,Tuse_rt1,Tuse_rt2,stall; 
	AT at(
		.Instr(InstrD),
		.A1(A1D),
		.A2(A2D),
		.A3(A3D),
		.Tuse_rs0(Tuse_rs0),
		.Tuse_rs1(Tuse_rs1),
		.Tuse_rt0(Tuse_rt0),
		.Tuse_rt1(Tuse_rt1),
		.Tuse_rt2(Tuse_rt2),
		.resOpD(resOpD)
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
		.MWDM(MWDM)
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
