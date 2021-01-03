`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 04:02:39 PM
// Design Name: 
// Module Name: signExtend
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
//SIGN EXTEND
module signExtend(
    input clk,
    input rst,
    input [15:0] in, 
    output reg [31:0] out
);

    always@(posedge clk)
    if (rst)
        begin
        end
    
    else
        begin
            if (in[15]==1)
            begin
                out <= {16'd1 , in};
            end
            else
            begin
                out <= {16'd0 , in};
            end
        end

endmodule
