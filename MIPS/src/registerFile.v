`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 11:44:46 AM
// Design Name: 
// Module Name: registerFile
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
//REGISTER FILE
module reg_file(
    input clk,
    input rst,

    //Read side
    input [4:0] regA_addr,  //5 bits for the address therefore 32 registers
    input [4:0] regB_addr,  //5 bits for the address therefore 32 registers
    output [31:0] regA,     //registers are 32 bits wide
    output [31:0] regB,     //registers are 32 bits wide

    //Write side
    input [4:0] wr_addr,
    input [31:0] data,
    input we                //write enable
);

//Storage elements
reg [31:0]  registers[31:0]; // 32 32-bit registers (32 bit wide with 5 bits to address the 32 registers)

integer i;

always@(posedge clk)
begin
    if(rst)  
    begin
        //The one and only time a for loop is ok
        for (i=0; i < 32; i = i + 1)
            registers[i] <= 32'd0;
    end
    
    else
    begin
        //If write enable
        if(we)
        begin
            registers[wr_addr] <= data; //Put the value of the data to the address w/ wr_addr
        end
    end
end

assign regA = registers[regA_addr];
assign regB = registers[regB_addr];

endmodule

//MUX modules
/*module MUX(
    input clk,
    input rst,
    
    input [31:0] inTrue,
    input [31:0] inFalse,
    input sel,
    
    output reg [31:0] out
);
    always@(posedge clk)
        if (rst)
        begin
            out <= 32'b0;
        end  
        else
        begin
            out <= sel ? inTrue : inFalse; //condition ? if true : if false
        end
endmodule
*/


