`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 10:47:12
// Design Name: 
// Module Name: Controller
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


module Controller(
    input [31:0] Instr,
    output [2:0] ALUOp,
    output RegWrite,
    output MemWrite,
    output beq,
    output ALUSrc,
    output [1:0] WhichtoReg,
    output[1:0] RegDst,
    output SignExt,
    output j_jal,
    //output jal,
    output jr
    );
    wire [5:0]op;
    wire [5:0]func;
    
    assign op = Instr[31:26];
	assign func = Instr[5:0];
	wire addu, subu, ori, lw, sw, beq_w, lui, jal_w, nop, j, jr_w, R;
	
	assign R = (op == 6'b000000);
	
	assign addu = R&(func == 6'b100001);
	assign subu = R&(func == 6'b100011);
	
	assign lui = (op == 6'b001111);
	assign ori = (op == 6'b001101);
	
	assign lw = (op == 6'b100011);
	assign sw = (op == 6'b101011);
	assign beq_w = (op == 6'b000100);
	
	assign jal_w = (op == 6'b000011);
	assign j = (op == 6'h000010);
	
	assign jr_w = R&(func == 6'b001000);
	
	assign nop= R&(func == 6'b000000);
    
    //conntect the wire to the sign
    
    // RegWrite
	assign RegWrite = addu || subu|| ori || lw || lui || jal_w;
	assign MemWrite = sw;
	
	assign RegDst = (jal_w) ? 2'b10 :			// $31,ra
					(ori|| lw || lui) ? 2'b01 :	// rt
					2'b00;					// rd
	
	// WhichtoReg
	// choose from PC4 / MemRead / res
	assign WhichtoReg =	jal_w	? 2'b10:	// PC4
						lw	? 2'b01 :	// Memread
						2'b00;			// res
	
	// AluSrc
	assign ALUSrc = ori|lw|sw|lui;
	
	// AluOp
	
	assign ALUOp =	addu ?	3'b000 :
					subu ?	3'b001 :
					ori?	3'b010 :
					lui?    3'b011:0;
	
	// sign
	assign SignExt = lw|sw|beq_w;
	
	// branch
	assign beq = beq_w;
	
	// JType
	assign j_jal = j|jal_w;
	
	// JReg
	assign jr = jr_w;
endmodule
