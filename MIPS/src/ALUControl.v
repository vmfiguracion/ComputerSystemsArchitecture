`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 04:12:38 PM
// Design Name: 
// Module Name: ALUControl
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
//ALU CONTROL UNIT
/*              ALUOp      |    Function            |   ALU Control
            (from control) |(from instruction[5:0]) |   (output)
    - ADD       10         |    100000              |   0010
    - SUB       10         |    100010              |   0110
    - AND       10         |    100100              |   0000
    - OR        10         |    100101              |   0001
    - SLT       10         |    101010              |   0111
*/
module ALUControl(
    input clk,
    input rst,
    
    input [1:0] ALUOp,
    input [5:0] func,
        
    output reg [3:0] ALU_control_out
);

    always@(posedge clk)
    if (rst)
        begin
        end
        
    else
        begin
            if (ALUOp == 2'b10)
                case(func)
                    6'b100000: ALU_control_out <= 4'b0010; //ADD
                    6'b100010: ALU_control_out <= 4'b0110; //SUB
                    6'b100100: ALU_control_out <= 4'b0000; //AND
                    6'b100101: ALU_control_out <= 4'b0001; //OR
                    6'b101010: ALU_control_out <= 4'b0111; //SLT
                endcase
        end

endmodule