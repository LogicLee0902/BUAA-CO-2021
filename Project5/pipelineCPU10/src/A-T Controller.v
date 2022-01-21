`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 15:00:42
// Design Name: 
// Module Name: A-T Controller
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
module AT(
	input [31:0]Instr,
	output reg [4:0]A1,
	output reg [4:0]A2,
	output reg [4:0]A3,
	output reg Tuse_rs0,
	output reg Tuse_rs1,
	output reg Tuse_rt0,
	output reg Tuse_rt1,
	output reg Tuse_rt2,
	output reg [1:0]resOpD
    );
	reg addu,subu,ori,lui,beq,sw,lw,jr,j,jal, bgez, jalr, addi, sra;
	always@(*)
	begin 
			 addu<=(Instr[`op]==`R&&Instr[`func]==`ADDU)?1:0;
			 subu<=(Instr[`op]==`R&&Instr[`func]==`SUBU)?1:0;
			 ori<=(Instr[`op]==`ORI)?1:0;
			 lui<=(Instr[`op]==`LUI)?1:0;
			 beq<=(Instr[`op]==`BEQ)?1:0;
			 sw<=(Instr[`op]==`SW)?1:0;
			 lw<=(Instr[`op]==`LW)?1:0;
			 j<=(Instr[`op]==`J)?1:0;
			 jal<=(Instr[`op]==`JAL)?1:0;
			 jr<=(Instr[`op]==`R&&Instr[`func]==`JR)?1:0;
			 
			 A1<=Instr[`rs];
			 A2<=Instr[`rt];
			 A3<=(addu||subu)?Instr[`rd]:
				(ori||lw||lui)?Instr[`rt]:
				(jal)?5'd31:	//$31, ra
				 5'b0;
			
			 Tuse_rs0<=beq||jr;	//rs=0的指令
			 Tuse_rs1<=addu||subu||ori||lui||sw||lw;	//rs=1的指令
			 Tuse_rt0<=beq;
			 Tuse_rt1<=addu||subu||lui;
			 Tuse_rt2<=sw;
			 
			 resOpD<=(addu||subu||ori||lui)?`ALU:			//指令的对应部件（等价于Tnew初始值）
			        (lw)				  ?`DM:
				    (jal)				  ?`PC:
					  					  `NW;
	end
endmodule 

/*
module AT_Unit(
    input clk,
    input reset,
    input [31:0]Instr,
    input enIFID,
    input FlushIDEX,
    output [4:0]A1D,
    output [4:0]A2D,
    output [4:0]A1E,
    output [4:0]A2E,
    output [4:0]A3E,
    output [1:0]resOpE,
    output [4:0]A3M,
    output [4:0]A2M,
    output [1:0]resOpM,
    output [4:0]A3W,
    output [1:0]resOpW,
    output Tuse_rs0,
	output Tuse_rs1,
	output Tuse_rt0,
	output Tuse_rt1,
	output Tuse_rt2
);
    wire [4:0]A3D;
	wire [1:0]resOpD;
    AT at(
        .Instr(Instr),
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
    IDEX idex_at(
        .resOpD(resOpD),
        .A1D(A1D),
        .A2(A2D),
        .A3(A3D),
        .clk(clk),
        .reset(reset),
        .flush(FlushIDEX),
        .A1E(A1E),
        .A2E(A2E),
        .A3E(A3E),
        .resOpE(resOpE)
    );
    EXME exme_at(
        .resOpE(resOpE),
        .A2E(A2E),
        .A3E(A3E),
        .clk(clk),
        .reset(reset),
        .A2M(A2M),
        .A3M(A3M),
        .resOpM(resOpM)
    );
    MEWB mewb_at(
        .resOpM(resOpM),
        .A3M(A3M),
        .clk(clk),
        .reset(reset),
        .A3W(A3W),
        .resOpW(resOpW)
    );
endmodule
*/