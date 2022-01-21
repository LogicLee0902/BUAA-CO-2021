`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 13:45:47
// Design Name: 
// Module Name: MUX
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
				 (sel == 2'b11)? in3:0;
endmodule 

module MUX_8_32(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [31:0] in7,
    input [2:0] sel,
    output [31:0] out
);

  assign out = (sel == 3'b000)? in0:
			   (sel == 3'b001)? in1:
			   (sel == 3'b010)? in2:
			   (sel == 3'b011)? in3:
               (sel == 3'b100)? in4:
               (sel == 3'b101)? in5:
               (sel == 3'b110)? in6:
               (sel == 3'b111)? in7:0;
endmodule

module MUX_6_32(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [2:0] sel,
    output [31:0] out
);

  assign out = (sel == 3'b000)? in0:
			   (sel == 3'b001)? in1:
			   (sel == 3'b010)? in2:
			   (sel == 3'b011)? in3:
               (sel == 3'b100)? in4:
               (sel == 3'b101)? in5:0;
            
endmodule

module MUX_7_32(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [2:0] sel,
    output [31:0] out
);

  assign out = (sel == 3'b000)? in0:
			   (sel == 3'b001)? in1:
			   (sel == 3'b010)? in2:
			   (sel == 3'b011)? in3:
               (sel == 3'b100)? in4:
               (sel == 3'b101)? in5:
               (sel == 3'b110)? in6: 0;
            
endmodule

module MUX_10_32(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [31:0] in7,
    input [31:0] in8,
    input [31:0] in9,
    input [31:0] in10,
    input [3:0] sel,
    output [31:0] out
);

  assign out = (sel == 4'b0000)? in0:
			   (sel == 4'b0001)? in1:
			   (sel == 4'b0010)? in2:
			   (sel == 4'b0011)? in3:
               (sel == 4'b0100)? in4:
               (sel == 4'b0101)? in5:
               (sel == 4'b0110)? in6:
               (sel == 4'b0111)? in7:
               (sel == 4'b1000)? in8:
               (sel == 4'b1001)? in9: 
               (sel == 4'b1010)? in10:32'd0;           
endmodule
