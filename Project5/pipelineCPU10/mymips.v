`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 17:01:01
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

//about instrction 31:0
`define instr 31:0
`define rs 25:21
`define base 25:21
`define rt 20:16
`define rd 15:11
`define imm16 15:0
`define imm26 25:0
`define op 31:26
`define func 5:0
`define shamt 10:6

//instruction infomation:

// R-Type only the funct
`define R 6'h0
`define ADDU 6'b100001

`define SUBU 6'b100011

// I-Type	only the op
`define LUI	 6'b001111
`define ORI	 6'b001101


// MEM	only op
`define LW	6'b100011
`define SW	6'b101011

// Branch only op
`define BEQ	 6'b000100

// JUMP
//only j
`define J 6'b000010	// only op
`define JAL	 6'b000011	// only op

// op `R
`define JR	6'b001000	// the func

//about PC


module mips(
    input clk, //clock
    input reset //reset
    );
	//Stall
	wire Stall;
	//Stage F
	wire [31:0] PCF, NPCF, InstrF, PCW;
	wire j_jal, jr, beq, b_judge, jal;

    //reset
    wire resetF, resetD, resetE, resetM, resetW;

    //Forward
     wire FflagW,FflagM,FflagE;
	 wire [4:0] FaddrM,FaddrE;
	 wire [1:0] FdataselM,FdataselE;
	 wire [31:0] FdataE,FdataM;
	 wire [31:0]SrcAE, SrcBE, ResE;
	 
	PC pc(
	   .NPC(NPCF),
	   .PC(PCF),
	   .clk(clk),
	   .reset(reset),
	   .PC_en(!Stall)
	);
	
	
	IM im(
	   .PC(PCF),
	   .Instr(InstrF)
	);
	
	//IFID
	 wire [31:0] InstrD, PCD;
	 IFID ifid(
		.clk(clk),
		.reset(reset),
		.IFID_en(!Stall), 		
		.InstrF(InstrF),
		.InstrD(InstrD),
		.PCF(PCF),
		.PCD(PCD)
	 );
	 
	//Stage D
	wire [2:0]ALUOpD;
	wire ForwardAD, ForwardBD, EXTOpD, RegWriteD, MemWriteD, ALUSrcD;
	//WDW, A3W for the writeback;
	wire [31:0]WDW;
	wire RegWriteW;
	wire [4:0]A3W, A3D;
	
	wire [1:0] SelD, RegDstD, WhichtoRegD;
	wire [31:0]imm32D, RD1D, RD2D;
		
	Controller controller(
	   .Instr(InstrD),
	   .RegWrite(RegWriteD),
	   .MemWrite(MemWriteD),
	   .RegDst(RegDstD),
	   .SignExt(EXTOpD),
	   .ALUSrc(ALUSrcD),
	   .beq(beq),
	   .j_jal(j_jal),
	   .jr(jr),
	   .jal(jal),
	   .WhichtoReg(WhichtoRegD), // 0 for res. 1 for mem, 2 for PC+8
	   .ALUOp(ALUOpD),
	   .Sel(SelD)
	); 
	MUX_4_5 MGRFD(
	   .in0(InstrD[`rd]),
	   .in1(InstrD[`rt]),
	   .in2(5'd31),
	   .in3(5'd0),
	   .sel(RegDstD),
	   .out(A3D)
	);
	EXT ext(
	   .imm16(InstrD[`imm16]),
	   .EXTOp(EXTOpD),
	   .imm32(imm32D)
	);
	
	NPC npc(
	   .btype(b_judge),
	   .jr(jr),
	   .j_jal(j_jal),
	   .PCF(PCF),
	   .imm32(imm32D),
	   .Instr(InstrD),
	   .PCD(PCD),
	   .JrJump(RD1D),
	   .NPC(NPCF)
	);
	//temp_Use
	wire [31:0]RD1, RD2;
	GRF grf(
	   .clk(clk),
	   .reset(reset),
	   .A1(InstrD[`rs]),
	   .A2(InstrD[`rt]),
	   .GRF_WE(RegWriteW),
	   .A3(A3W),
	   .WD(WDW),
	   .PC(PCW),
	   .RD1(RD1),
	   .RD2(RD2)
	);
	//Forward for the CMP & PCJR
	assign RD1D = (InstrD[`rs]===0)               ?0:
	              (InstrD[`rs]===FaddrE && FflagE)?FdataE:
	              (InstrD[`rs]===FaddrM && FflagM)?FdataM:
	              (InstrD[`rs]===A3W && FflagW)   ?WDW:
	                                              RD1;
	assign RD2D = (InstrD[`rt]===0)               ?0:
	              (InstrD[`rt]===FaddrE && FflagE)?FdataE:
	              (InstrD[`rt]===FaddrM && FflagM)?FdataM:
	              (InstrD[`rt]===A3W && FflagW)   ?WDW:
	                                              RD2;
	wire Zero;
	CMP cmp(
	   .A(RD1D),
	   .B(RD2D),
	   .Zero(Zero)
	);                                   
	 assign b_judge = Zero&&beq;
	 //IDEX
	 wire [31:0]RD1E, RD2E, InstrE, PCE, imm32E;
	 wire [1:0]WhichtoRegE;
	 wire [2:0] ALUOpE;
	 wire [4:0]A3E;
	 wire MemWriteE, ALUSrcE, RegWrieD, RegWriteE;
	 IDEX idex(
	   .clk(clk),
	   .reset(reset),
	   .flush(Stall||reset),
	   .RD1D(RD1D),
	   .RD2D(RD2D),
	   .InstrD(InstrD),
	   .MemtoRegD(WhichtoRegD),
	   .MemWriteD(MemWriteD),
	   .RegWriteD(RegWriteD),
	   .A3D(A3D),
	   .ALUOpD(ALUOpD),
	   .ALUSrcD(ALUSrcD),
	   .PCD(PCD),
	   .imm32D(imm32D),
	   .RD1E(RD1E),
	   .RD2E(RD2E),
	   .InstrE(InstrE),
	   .MemtoRegE(WhichtoRegE),
	   .MemWriteE(MemWriteE),
	   .A3E(A3E),
	   .ALUOpE(ALUOpE),
	   .ALUSrcE(ALUSrcE),
	   .PCE(PCE),
	   .imm32E(imm32E),
	   .RegWriteE(RegWriteE)
	 );
	 
	 //Stage E
	 
	 wire [31:0]RD1BALUE, RD2BALUE;
	 assign RD1BALUE = (InstrE[`rs]===0)               ?0:
	                   (InstrE[`rs]===FaddrM && FflagM)?FdataM:
	                   (InstrE[`rs]===A3W && FflagW)   ?WDW:
	                                                   RD1E;
	 assign RD2BALUE = (InstrE[`rt]===0)     ?0:
	                   (InstrE[`rt]===FaddrM && FflagM)?FdataM:
	                   (InstrE[`rt]===A3W && FflagW)   ?WDW:
	                                                   RD2E;
	 assign SrcAE = RD1BALUE;
	 MUX_2_32 MALUBE(
	   .in0(RD2BALUE),
	   .in1(imm32E),
	   .sel(ALUSrcE),
	   .out(SrcBE)
	 );      
    ALU alu(
        .SrcA(SrcAE),
        .SrcB(SrcBE),
        .shamt(InstrE[`shamt]),
        .ALUOp(ALUOpE),
        .Result(ResE)
    );  
    
    //E_Forward
    assign FdataE = PCE+8;
   
   //EXMEM
   wire [31:0]ResM, PCM, InstrM, imm32M, WDMemoryM;
   wire [1:0]WhichtoRegM;
   wire MemWriteM,RegWriteM;
   wire [4:0]A3M;
   EXMEM exmem(
        .clk(clk),
        .reset(reset),
        .PCE(PCE),
        .InstrE(InstrE),
        .MemtoRegE(WhichtoRegE),
        .MemWriteE(MemWriteE),
        .A3E(A3E),
        .ResE(ResE),
        .imm32E(imm32E),
        .WDMemoryE(RD2BALUE),
        .RegWriteE(RegWriteE),
        .PCM(PCM),
        .InstrM(InstrM),
        .MemtoRegM(WhichtoRegM),
        .MemWriteM(MemWriteM),
        .A3M(A3M),
        .ResM(ResM),
        .imm32M(imm32M),
        .WDMemoryM(WDMemoryM),
        .RegWriteM(RegWriteM)
   );
   
   //Stage M
   wire [31:0]ReadDMM, WDBDMM;
   assign WDBDMM = (InstrM[`rt] === 0) ?             0:
                   (InstrM[`rt] === A3W && FflagW) ? WDW:
                                                    WDMemoryM;
   DM dm(
        .clk(clk),
        .reset(reset),
        .Address(ResM),
        .Memwrite(MemWriteM),
        .WD(WDBDMM),
        .PC(PCM),
        .Sel(2'd0),
        .RD(ReadDMM)
   );
   
   //M_Forward
   assign FdataM = (FdataselM == 2'd0)? ResM:
                                       PCM+8;  
   //MEWB
   wire [31:0] ResW,InstrW, ReadDMW; 
   wire [1:0] WhichtoRegW;
   MEWB mewb(
        .clk(clk),
        .reset(reset),
        .PCM(PCM),
        .InstrM(InstrM),
        .ResM(ResM),
        .A3M(A3M),
        .RDM(ReadDMM),
        .MemtoRegM(WhichtoRegM),
        .RegWriteM(RegWriteM),
        .PCW(PCW),
        .InstrW(InstrW),
        .ResW(ResW),
        .A3W(A3W),
        .RDW(ReadDMW),
        .MemtoRegW(WhichtoRegW),
        .RegWriteW(RegWriteW)
   );  
   //WB
   MUX_4_32 MUXWB(
        .in0(ResW),
        .in1(ReadDMW),
        .in2(PCW+8),
        .in3(0),
        .sel(WhichtoRegW),
        .out(WDW)
   );    
   //Stall
   Stall sstall(
        .InstrD(InstrD),
        .InstrE(InstrE),
        .InstrM(InstrM),
        .InstrW(InstrW),
        .Stall(Stall)
   );
   
   // Forward
   FORWARD Forward(
        .InstrD(InstrD),
        .InstrE(InstrE),
        .InstrM(InstrM),
        .InstrW(InstrW),
        .FlagE(FflagE),
        .FlagM(FflagM),
        .FlagW(FflagW),
        .addrE(FaddrE),
        .addrM(FaddrM),
        .DataE(FdataselE),
        .DataM(FdataselM)
   );                                 
endmodule
