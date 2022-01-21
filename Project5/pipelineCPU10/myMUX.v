`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 17:03:24
// Design Name: 
// Module Name: MUX_2_32
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


module MUX_2_32( //32-bit, select 1 from 2
    input [31:0] in0,
    input [31:0] in1,
    input sel,
    output [31:0] out
    );
    assign out = (sel == 0)? in0 : in1;
endmodule

module MUX_4_5(
	input [4:0] in0,
	input [4:0] in1,
	input [4:0] in2,
	input [4:0] in3,
	input [1:0] sel,
	output [4:0] out
	);
	assign out = (sel == 2'b00)? in0:
				 (sel == 2'b01)? in1:
				 (sel == 2'b10)? in2:
				  in3;
endmodule 

module MUX_4_32(
	input [31:0] in0,
	input [31:0] in1,
	input [31:0] in2,
	input [31:0] in3,
	input [1:0] sel,
	output [31:0] out
	);
	assign out = (sel == 2'b00)? in0:
				 (sel == 2'b01)? in1:
				 (sel == 2'b10)? in2:
				  in3;
endmodule 