`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:55:19 PM
// Design Name: 
// Module Name: programCounter
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
//PROGRAM COUNTER
module PC(
    input [31:0] pcIn,
    input rst,
    input clk,
    
    output reg [31:0] pcRes
);

    always@(posedge clk)
    begin
        if(rst)
        begin
            pcRes <= 32'd0;
        end
        
        else
        begin
            pcRes <= pcIn;
        end
    end

endmodule

//PROGRAM COUNTER ADD
module pcAdd(
    input clk,
    input rst,
    input [31:0] pcRes,
    output reg [31:0] pcAddRes
);

   always@(posedge clk)
   if (rst)
        begin
        end
   
   else
        begin
            pcAddRes <= pcRes + 32'd4;
        end

endmodule