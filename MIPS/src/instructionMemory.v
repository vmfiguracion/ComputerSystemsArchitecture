`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:28:59 PM
// Design Name: 
// Module Name: instructionMemory
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
//INSTRUCTION MEMORY
module Imemory(
    input clk,
    input rst,

    //Read side
    input [32:0] addr,  //32 bit input (address) from program counter
    output [31:0] instruction     
);

//Storage elements
reg [31:0]  registers[1023:0]; //killoword of instruction memory

integer i;

always@(posedge clk)
begin
    if(rst)  
        begin
            //The one and only time a for loop is ok
            for (i=0; i < 1024; i = i + 1)
                registers[i] <= 32'd0;
        end
    
    else
        begin
        end
end

assign instruction = registers[addr];

endmodule
