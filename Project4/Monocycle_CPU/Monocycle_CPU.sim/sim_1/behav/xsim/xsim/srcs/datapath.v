`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 11:34:36
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input reset,
    input RegWrite,
    input MemWrite,
    input [1:0] RegDst,
    input beq,
    input ALUSrc,
    input SignExt,
    input [1:0] WhichtoReg,
    input j_jal,
    input jr,
    input [2:0] ALUOp,
    output [31:0] Instr
    );
    wire [31:0]PC, NPC, PC4, Zero; //for PC and NPC
    //for GRF
    wire [31:0] RD1, RD2, RegData, PC_jr;
    wire [4:0] RegAddr;
    //for ALU
    wire [31:0]B;
    wire [31:0]Res;
   //for EXT;
   wire [31:0]imm32;
   //for DM
   wire [31:0]MemRead;
    
    NPC npc(
    .beq(beq),
    .jr(jr),
    .j_jal(j_jal),
    .Zero(Zero),
    .PC(PC),
    .imm32(imm32),
    .Instr(Instr),
    .PC_jr(PC_jr),
    .PC4(PC4),
    .NPC(NPC)
    );
    
    PC pc(
        .clk(clk),
        .reset(reset),
        .NPC(NPC),
        .PC(PC)
    );
    
    IM im (
    .PC(PC), 
    .Instr(Instr)
    );
    
   GRF grf(
    .clk(clk),
    .reset(reset),
    .WE(RegWrite),
    .A1(Instr[25:21]),
    .A2(Instr[20:16]),
    .A3(RegAddr),
    .WD(RegData),
    .PC(PC),
    .RD1(RD1),
    .RD2(RD2),
    .PC_jr(PC_jr)
   );
   
   MUX_4_32 MUX_RegWrite( //for store the data to the grf
    .in0(Res),
    .in1(MemRead),  
    .in2(PC4),
    .in3(),
    .sel(WhichtoReg),
    .out(RegData)
   );
   
   MUX_4_5 MuxRegAddr (	// choose the one to write
    .in0(Instr[15:11]), 
    .in1(Instr[20:16]),
	.in2(5'd31),
	.in3(0),
    .sel(RegDst), 
    .out(RegAddr)
    );
  MUX_2_32 MuxAluB (
    .in0(RD2), 
    .in1(imm32), 
    .sel(ALUSrc), 
    .out(B)
    );
   EXT ext(
    .imm16(Instr[15:0]), 
    .EXTOp(SignExt), 
    .imm32(imm32)
   );
    ALU alu (
    .SrcA(RD1), 
    .SrcB(B), 
    .ALUOp(ALUOp), 
    .Zero(Zero), 
    .Result(Res)
    );
    DM dm (
    .clk(clk), 
    .reset(reset), 
    .Memwrite(MemWrite), 
    .Address(Res), 
    .WD(RD2), 
    .RD(MemRead),
	.PC(PC)
    );
    
    DASM Dasm(
    .pc(PC),
    .instr(Instr),
    .imm_as_dec(1'b1),
    .reg_name(1'b0),
    .asm()
);
endmodule
