`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 19:59:37
// Design Name: 
// Module Name: decoder
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

module Decoder(
	input [31:0]Instr,
	input Request,
	output RegWrite,
	output MemWrite,
	output [1:0]EXTOp,
	output [3:0]ALUOp,
	output [2:0]NPCOp,
	output [2:0]SelOp,
	output [2:0]MemtoReg,
	output ALUSrcA,
	output ALUSrcB,
	output j_type,
	output jr_type,
	output b_type,
	output [1:0] MDWrite,
	output [2:0] MDcal,
	output Start,
	output mul_div,
	output lb,
	output lbu,
	output lh,
	output lhu,
	output lw,
	output sb,
	output sh,
	output sw,
	output beq,
	output bne,
	output blez,
	output bltz,
	output bgez,
	output bgtz,
	output store,
	output load,
	output [4:0]A3,
	output [2:0]resOp,
	output Tuse_rs0,
	output Tuse_rs1,
	output Tuse_rt0,
	output Tuse_rt1,
	output Tuse_rt2,
	output mfc0,
	output mtc0,
	output eret,
	output Exc_RI,
	output CP0Write,
	output ALU_Res,
	output ALU_Addr,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] rd
    );
    wire add,addu,sub,subu,mult,multu,div,divu,sll,srl,sra,sllv,srlv,srav,And,Or,Xor,Nor;
	wire addi,addiu,andi,ori,xori,lui,slt,slti,sltiu,sltu,j,jal,jalr,jr,mfhi,mflo,mthi,mtlo;
	wire cal_r,cal_i,branch,jump,shift;
	
	wire [5:0] op = Instr[`op];
	wire [5:0] func = Instr[`func];
	assign rt = Instr[`rt];
	assign rs = Instr[`rs];
	assign rd = Instr[`rd];
	//Cal_r
	assign addu = (op == `R && func == `ADDU);
	assign subu = (op == `R && func == `SUBU);
	assign sub = (op == `R && func == `SUB);
	assign add = (op == `R && func == `ADD);
	assign And = (op == `R && func == `AND);
	assign Or = (op == `R && func == `OR);
	assign Xor = (op == `R && func == `XOR);
	assign Nor = (op == `R && func == `NOR);
	assign slt = (op == `R && func == `SLT);
	assign sltu = (op == `R && func == `SLTU);
	assign sllv = (op == `R && func == `SLLV);
	assign srlv = (op == `R && func == `SRLV);
	assign srav = (op == `R && func == `SRAV);
	
	//cal_i
	assign addi = (op == `ADDI),
		   lui = (op == `LUI),
		   ori = (op == `ORI),
		   addiu = (op == `ADDIU),
		   andi = (op == `ANDI),
		   xori = (op == `XORI),
		   slti = (op == `SLTI),
		   sltiu = (op == `SLTIU);
	
	//Load
	assign  lw = (op == `LW), 
			lb = (op == `LB),
			lbu = (op == `LBU),
			lh = (op == `LH),
			lhu = (op == `LHU);
	//Store
	assign  sw = (op == `SW),
			sb = (op == `SB),
			sh = (op == `SH);
	
	//Beq
	assign  beq = (op == `BEQ),
			bne = (op == `BNE),
			blez = (op == `BLEZ),
			bgtz = (op == `BGTZ),
			bltz = (op == `BLTZ) && (rt == 0),
			bgez = (op == `BGEZ) && (rt == 5'b00001);
	
	// Jump
	assign  j = (op == `J),
			jal = (op == `JAL),
			jr = (op == `R)&(func == `JR),
			jalr = (op == `R)&(func == `JALR);
	
	//Shift
	assign  sll = (op == `R) && (func == `SLL),
			srl = (op == `R) && (func == `SRL),
			sra = (op == `R) && (func == `SRA),
			sllv = (op == `R) && (func == `SLLV),
			srlv = (op == `R) && (func == `SRLV),
			srav = (op == `R) && (func == `SRAV);
	
	//mul_div:
	assign  mult = (op == `R) && (func == `MULT),
			multu = (op == `R) && (func == `MULTU),
			div = (op == `R) && (func == `DIV),
			divu = (op == `R) && (func == `DIVU),
			mfhi = (op == `R) && (func == `MFHI),
			mflo = (op == `R) && (func == `MFLO),
			mthi = (op == `R) && (func == `MTHI),
			mtlo = (op == `R) && (func == `MTLO);
			
	//Exception
	assign mfc0 = (op == `CP0_Op) && (rs == `MFC0);
	assign mtc0 = (op == `CP0_Op) && (rs == `MTC0); 
    assign eret = (Instr == `ERET);
    
    assign Exc_RI = !(beq | bne | bgez | bgtz | blez | bltz |
                    j | jal | jalr | jr |
                    lb | lbu | lh | lhu | lw | sb | sh | sw |
                    lui | addi | addiu | andi | ori | xori | slti | sltiu |
                    add | addu | sub | subu | And | Nor | Or | Xor | ori | slt | sltu |
                    sll | sllv | sra | srav | srl | srlv |
                    ((op == 6'b000000) && (func==6'b000000)) | //for nop
                    div | divu | mfhi | mflo | mthi | mtlo | mult | multu |
                    mtc0 | mfc0 | eret);
                   
			
	assign  cal_r = add | addu | sub| subu | And | Or | Nor| Xor | slt | sltu | sllv | srlv | srav,
	  		cal_i = addi | addiu | andi | ori | xori | lui | slti | sltiu,
			load = lb | lbu | lh | lhu | lw,
			store = sb | sh | sw,
			branch = beq | bne | blez | bgtz | bltz | bgez,
			jump = j | jal | jr | jalr,
			shift = sll | srl | sra,
			mul_div = mult | multu | div | divu | mfhi | mflo | mthi | mtlo;
	
	//ALU
	assign  ALUSrcA = (shift)?1:0;	//1:shamt  0:RS
	assign	ALUSrcB = (cal_i|load|store)?1:0;	//1:EXT  0:RT
	assign	ALUOp = (load|store|add|addu|addi|addiu|lui)?     `add:	//Encrypting for the ALU ADD
			 		(sub|subu)?                               `sub://SUB
			 		(And|andi)?                               `andi://AND
			 		(Or|ori)?                                 `ori://OR
			 		(Xor|xori)?                               `xori://Xor
			 		(Nor)?                                    `nori://Nor
			 		(sll|sllv)?                               `left:// shift left logioal
			 		(srl|srlv)?                               `zero_right://shift right logical
			 		(sra|srav)?                               `sign_right://shift right arithmetic
			 		(slt|slti)?                               `sign_less://set less than
			 		(sltiu|sltu)?                             `zero_less:0;//set less than unsigned
	//NPC
	assign	NPCOp = (Request)?                               `Itrpt:
	                (eret)?                                  `Exc:
	                (branch|j|jal)?                          `NPC:
				  	(jr|jalr)?                               `MFPCF:
				  	(cal_r|cal_i|load|store|shift|mul_div|mfc0|mtc0)?  `ADD4:0;	
				  	//0:`ADD4
	//EXT
	assign	EXTOp = (addi|addiu|slti|sltiu|load|store)?   `sign_ext:
				 	(ori|andi|xori)?                      `zero_ext:
				 	(lui)?                                `high_ext:0;
	//RF
	assign RegWrite = (load|cal_r|cal_i|mfhi|mflo|jal|jalr|shift|mfc0)?1:0;
	assign A3 =  (cal_r|mfhi|mflo|shift|jalr)?Instr[`rd]:
				 (load|cal_i|mfc0   )?Instr[`rt]:
				 (jal)?5'd31:	//$ra
				 5'b0;
		
	//DM
	assign	MemWrite = (store)?1:0;//Ð´ÄÚ´æ
	assign MemtoReg = (cal_r|cal_i|shift)? `Res:
					  (load)?              `MemRD:
					  (jal|jalr)?          `PC8:
					  (mfhi)?              `HI:
					 (mflo)?               `LO:
					 (mfc0)?               `CP_0:0;
	//Forwarding
	assign	resOp =	(cal_r|cal_i|shift)?    `ALU:	//the source of the value of the reg, namely Tnew
                    (load)?                 `DM:
					(jal|jalr)?             `PC:
					(mflo)?                 `LOout://LO£¿
					(mfhi)?                 `HIout://HI£¿
					(mfc0)?	                `CP0Out: `NW;// no new result for the reg coming out
				
	//Stall
	assign	Tuse_rs0 = jr|jalr|branch,	//rs=0
			Tuse_rs1=cal_r|cal_i|mthi|mtlo|mult|multu|div|divu|load|store,	//rs=1
			Tuse_rt0=beq|bne, //rt = 1
			Tuse_rt1=cal_r|shift|mult|multu|div|divu,
			Tuse_rt2=store|mtc0;
	
	//Mul & Div
	assign MDWrite = mthi? `whi: //write hi
					 mtlo? `wlo:0;//write lo
	assign MDcal =  mult?  `sign_mults:// signed mul
			 		multu? `mults: // unsigned mul
			 		div?   `sign_divs://signed div
			 		divu?  `divs:0;//unsigned div
			 		
	assign Start = mult||multu||div||divu;//sign for mul and div

	//NPC_jump
	assign	j_type = jal||j;//jump unconditionally
	assign	jr_type = jr||jalr;//jump to reg
	assign	b_type = branch;// jump condotionally
	//mode for save & load
	assign SelOp =  (sw||lw)?      `Word:
					(sb||lb||lbu)? `Byte:
					(sh||lh||lhu)? `Half:0;

    assign CP0Write = (mtc0)?1:0;
    assign ALU_Res = addi || add || sub;
    assign ALU_Addr = store || load;
endmodule

