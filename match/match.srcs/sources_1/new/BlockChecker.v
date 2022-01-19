`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 19:41:49
// Design Name: 
// Module Name: BlockChecker
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



module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );
    
 parameter S0 = 4'b0000,
            S1 = 4'b0001,
            S2 = 4'b0010,
            S3 = 4'b0011,
            S4 = 4'b0100,
            S5 = 4'b0101,
            S6 = 4'b0110,
            S7 = 4'b0111,
            S8 = 4'b1000,
            S9 = 4'b1001,
            S10 = 4'b1010;
           
   reg [3:0] Status = S1;
   reg [31:0] Cnt_Begin = 0;
   reg [31:0] Cnt_End = 0;
   assign result = (Cnt_Begin == Cnt_End )? 1'b1 : 1'b0;
   always@(posedge clk, posedge reset)
   begin
    if(reset == 1)
    begin
        Status <= S1;
        Cnt_Begin <= 0;
        Cnt_End <= 0;
    end
    else
    begin
        case(Status)
            S0:
            begin
                if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S1:
            begin
                if(in == "b" || in == "B") Status <=S2;
                else if(in == "e" || in == "E") Status <= S7;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S2:
            begin
                if(in == "e" || in == "E") Status <= S3;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S3:
            begin
                if((in == "g") || (in == "G")) Status <= S4;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
            S4:
            begin
                if((in == "i") || (in == "I")) Status <= S5;
                else if(in == " ") Status <= S1;
                else Status <= S0;
            end
           S5:
           begin
            if((in == "N") || (in == "n"))
            begin
                Cnt_Begin <= Cnt_Begin + 1;
                Status <= S6;
            end
            else if(in == " ") Status <= S1;
            else Status <= S0;
           end
           S6:
           begin
            if(in == " ") Status <= S1;
            else 
            begin
                Cnt_Begin <= Cnt_Begin - 1;
                Status <= S0;
            end
           end
           S7:
           begin
            if(in == "n" || in == "N") Status <= S8;
            else if(in == " ") Status <= S1;
            else Status <= S0;
           end
           S8:
           begin
            if(in == "d" || in == "D")
            begin
                Cnt_End <= Cnt_End + 1;
                Status <= S9;
            end
            else if(in == " ") 
            begin
                Status <= S1;
            end
            else Status <= S0;
           end
           S9:
           begin
            if(in == " ")
            begin
                 if((Cnt_Begin < Cnt_End)) Status <= S10;
                 else Status <= S1;
            end
            else
            begin
                Cnt_End <= Cnt_End - 1;
                Status <= S0;
            end
           end
           S10:
           begin
            Status <= S10;
           end
           default: Status <= S0;
        endcase
    end
   end
   /*
    always@(Cnt_Begin, Cnt_End)
    begin
        if((Cnt_Begin < Cnt_End) && Status == S1) Status <= S10;
    end*/
endmodule
