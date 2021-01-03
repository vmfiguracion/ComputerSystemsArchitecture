`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:41:32 PM
// Design Name: 
// Module Name: dataMemory
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
//DATA MEMORY
module Dmemory(
    input clk,
    input rst,

    //Read side
    input [31:0] r_addr,		//32 bit read address
    output [31:0] data_out,     
    input re,                   //read enable

    //Write side
    input [31:0] wr_addr,		//32 bit write address
    input [31:0] data_in,		
    input we					//write enable
);

//Storage elements
reg [31:0]  registers[1023:0]; //killoword of data

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
        //If write enable
        if(we)
        begin
            registers[wr_addr] <= data_in; //Put the value of the data to the address w/ wr_addr
        end
    end
end

//If read enable
//assign data_out = (re) ? registers[r_addr]: 32'd0;

assign data_out = registers[r_addr];
endmodule