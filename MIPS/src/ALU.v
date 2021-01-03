`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:44:55 PM
// Design Name: 
// Module Name: ALU
// Project Name: MIPS (Single cycle processor)
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
//ALU
module ALU(//TODO zero
      input clk,
      input rst,
      
      input [31:0] a,
      input [31:0] b,
      input [3:0] op,
      
      output reg [31:0]res,
      output reg zero
);
      reg[31:0] temp;
     
      always@(posedge clk)
      if (rst)
        begin
        end
        
      else
          begin
               case (op)
                  4'b0000:  res = a & b;       // AND
                  4'b0001:  res = a  |   b;    // OR
                  4'b0010:  res = a +  b;      // addition
                  4'b0110:  res = a - b;       // subtraction
                  4'b0111:                     // slt
                    begin
                        temp = a - b;
                        res[31:1] = 31'h0;
                        res[0] = (temp[31] ==  1'b1);
                    end
               endcase
               
               if (a == b)
               begin
                    zero <= 1'b1;
               end
           end

endmodule