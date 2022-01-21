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
/*
module AT(
	input [31:0]Instr,
	input clk,
	output [4:0]A1D,
	output [4:0]A1E,
	output [4:0]A2D,
	output [4:0]A2E,
	output [4:0]A2M,
	output [4:0]A3D,
	output [4:0]A3E,
	output [4:0]A3M,
	output Tuse_rs0,
	output Tuse_rs1,
	output Tuse_rt0,
	output Tuse_rt1,
	output Tuse_rt2,
	output [2:0]resOp
    );

	
endmodule 
*/

module AT_Unit(
    input clk,
    input reset,
    input [31:0]Instr,
    input stall_md,
    input FlushIDEX,
    output [4:0]A1D,
    output [4:0]A2D,
    output [4:0]A1E,
    output [4:0]A2E,
    output [4:0]A3E,
    output [2:0]resOpE,
    output [4:0]A3M,
    output [4:0]A2M,
    output [2:0]resOpM,
    output [4:0]A3W,
    output [2:0]resOpW,
    output Tuse_rs0,
	output Tuse_rs1,
	output Tuse_rt0,
	output Tuse_rt1,
	output Tuse_rt2
);
	assign A1D = Instr[`rs];
	assign A2D = Instr[`rt];
	
    wire [4:0]A3D;
	wire [2:0]resOpD;
   Decoder decode_AT(
   		.Instr(Instr),
   		.Tuse_rs0(Tuse_rs0),
   		.Tuse_rs1(Tuse_rs1),
   		.Tuse_rt0(Tuse_rt1),
   		.Tuse_rt1(Tuse_rt1),
   		.Tuse_rt2(Tuse_rt2),
   		.A3(A3D),
   		.resOp(resOpD)
   );
    IDEX idex_at(
        .resOpD(resOpD),
        .A1D(A1D),
        .A2D(A2D),
        .A3D(A3D),
        .clk(clk),
        .reset(reset),
        .flush(FlushIDEX),
        .stall_md(stall_md),
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
