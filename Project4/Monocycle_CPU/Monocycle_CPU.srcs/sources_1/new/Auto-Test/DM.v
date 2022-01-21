`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 01:23:03
// Design Name: 
// Module Name: DM
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


module DM(
    input Memwrite,
    input reset,
    input clk,
    input [31:0] Address,
    input [31:0] WD,
    input [1:0]Sel,
    output reg [31:0] RD,
    input [31:0] PC
    );
    reg [31:0] DM[1023:0];
    reg [31:0] WData;
	integer i, File;
	initial begin
		for (i = 0; i < 1024; i = i + 1)
			DM[i] = 0;
	end
	
//	assign RD = DM[Address[11:2]];
    always@(*)
    begin
    case(Sel)
		      2'b00:
		          RD = DM[Address[11:2]];
		      2'b01:
		          RD = (Address[1:0] == 2'b00) ? {{24{DM[Address[11:2]][7]}}, DM[Address[11:2]][7:0]}:
		               (Address[1:0] == 2'b01) ? {{24{DM[Address[11:2]][15]}}, DM[Address[11:2]][15:8]}:
		               (Address[1:0] == 2'b10) ? {{24{DM[Address[11:2]][23]}}, DM[Address[11:2]][23:16]}:
		               {{24{DM[Address[11:2]][31]}}, DM[Address[11:2]][31:24]};
		      2'b10:
		          RD = (Address[1] == 1'b0) ? {{16{DM[Address[11:2]][15]}}, DM[Address[11:2]][15:0]}:{{16{DM[Address[11:2]][31]}}, DM[Address[11:2]][31:16]};
		      default:RD = 32'h00000000;
		    endcase
    end
	
	always@(posedge clk) 
	begin
		if(reset == 1) 
		begin
			for (i = 0; i < 1024; i = i + 1)
				DM[i] = 0;
		end
		else begin
		    File = $fopen("src.txt", "a+");
			if(Memwrite == 1) begin
			    case(Sel)
			         2'b00:
			            WData = WD;
			         2'b01:
			            WData = (Address[1:0] == 2'b00) ? {{{DM[Address[11:2]][31:8]}}, WD[7:0]}:
		                        (Address[1:0] == 2'b01) ? {{{DM[Address[11:2]][31:16]}}, WD[7:0], DM[Address[11:2]][7:0]}:
		                        (Address[1:0] == 2'b10) ? {{{DM[Address[11:2]][31:24]}}, WD[7:0], DM[Address[11:2]][15:0]}:
		                                                  {WD[7:0], DM[Address[11:2]][23:0]};
		             2'b10:
		                WData = (Address[1] == 1'b0) ? {{DM[Address[11:2]][31:16]}, WD[15:0]}:{WD[15:0], DM[Address[11:2]][15:0]};
			    endcase 
				DM[Address[11:2]] = WData;
				case(Sel)
				    2'b00:
				        WData = WD;
				    2'b01:
				        WData = {24'b0,WD[7:0]};
				    2'b10:
				        WData = {16'b0, WD[15:0]};
				endcase
				$display("@%h: *%h <= %h", PC,Address, WData);		// the pre-test requires
				$fdisplay(File, "@%h: *%h <= %h", PC,Address, WData);
			end
			$fclose(File);
		end
	end
endmodule
