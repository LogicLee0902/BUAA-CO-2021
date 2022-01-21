`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/12 19:57:30
// Design Name: 
// Module Name: StageW
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


module StageW(
    input [31:0] InstrW,
    input [31:0] PC4W,
    input [31:0]ResW,
    input [31:0]MemRDW,
    input [31:0]HIW,
    input [31:0]LOW,
    input [31:0]CP0RDW,
    output [31:0]WDW,
    output RegWriteW
    );
    wire [2:0]MemtoRegW;
    Decoder decode_W(
        .Instr(InstrW),
        .MemtoReg(MemtoRegW),
        .RegWrite(RegWriteW)
    );
    MUX_6_32 mux_wb(
        .in0(ResW),
        .in1(MemRDW),
        .in2(PC4W+4),
        .in3(HIW),
        .in4(LOW),
        .in5(CP0RDW),
        .sel(MemtoRegW),
        .out(WDW)
    );
    
endmodule
