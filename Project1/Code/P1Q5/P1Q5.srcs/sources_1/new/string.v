`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 10:02:11
// Design Name: 
// Module Name: string
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



module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11; 
    //clr: asynchronous
    reg [1:0]Status = 0;
    wire Number;
    assign Number = (in >= "0" && in <= "9") ? 1'b1 : 1'b0;
    assign out = (Status == S1)? 1'b1 : 1'b0;
    always@(posedge clk, posedge clr)
    begin
        if(clr == 1)
        begin
            Status <= S0;                
        end
        else
        begin
          case(Status)
            S0:
            begin
                if(Number == 1'b1)
                begin
                    Status <= S1;
                end
                else
                begin
                    Status <= S2;
                end
            end
            S1:
            begin
                if(Number == 1'b1) Status <= S2;
                else Status <= S3;
            end
            S2:
            begin
                Status <= S2;
            end
            S3:
            begin
                if(Number == 1'b1) Status <= S1;
                else Status <=  S2;
            end
           endcase
        end
    end
endmodule
