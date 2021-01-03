`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:59:44 PM
// Design Name: 
// Module Name: instructionShift
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
//SHIFT REGISTER 2 BIT for Jump Address
module instructionShift(
    input clk,
    input rst,
    input [25:0] instruction,
    input [3:0] PC4,
    
    output reg [31:0] jumpAddr
);

    always@(posedge clk)
    if (rst)
        begin
        end
    
    else
        begin
            jumpAddr <= {PC4, instruction, 2'b00};   
        end
endmodule
