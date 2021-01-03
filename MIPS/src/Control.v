`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 04:12:38 PM
// Design Name: 
// Module Name: Control
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
//CONTROL UNIT
/*
R-Type (000000) Go to ALU control
    - ADD, SUB, AND, OR, SLT
I-Type
    Load/Store
        - LW (100011) 
        - SW (101011)
    Immediate
        - ADDI (001000) 
J-Type
    Branch
        - BEQ (000100) 
    Jump
        - J (000010) 
*/
module Control(
    input clk,
    input rst,
    
    input [5:0] opCode,
    
    output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
);

    always@(posedge clk)
    if (rst) 
    begin
    end
    
    else
        begin
            case(opCode)
                //ALUControl
                6'b000000:
                    begin
                    RegDst <= 1'b1; 
                    Jump <= 1'b0; 
                    Branch <= 1'b0; 
                    MemRead <= 1'b0; 
                    MemtoReg <= 1'b0; 
                    ALUOp <= 2'b10;
                    MemWrite <= 1'b0;
                    ALUSrc <= 1'b0; 
                    RegWrite <= 1'b1;
                    end
                    
                //Jump(J)
                6'b000010:
                    begin
                    RegDst <= 1'b0; 
                    Jump <= 1'b1; 
                    Branch <= 1'b0; 
                    MemRead <= 1'b0; 
                    MemtoReg <= 1'b0; 
                    ALUOp <= 2'b00;
                    MemWrite <= 1'b0;
                    ALUSrc <= 1'b0; 
                    RegWrite <= 1'b0;
                    end
                
                //Branch(BEQ)
                6'b000100:
                    begin
                    RegDst <= 1'b0; 
                    Jump <= 1'b0; 
                    Branch <= 1'b1; 
                    MemRead <= 1'b0; 
                    MemtoReg <= 1'b0; 
                    ALUOp <= 2'b01;
                    MemWrite <= 1'b0;
                    ALUSrc <= 1'b0; 
                    RegWrite <= 1'b0;
                    end
                    
                //Add intermediate(ADDI)
                6'b001000:
                    begin
                    RegDst <= 1'b0; 
                    Jump <= 1'b0; 
                    Branch <= 1'b0; 
                    MemRead <= 1'b0; 
                    MemtoReg <= 1'b0;
                    ALUOp <= 2'b00; 
                    MemWrite <= 1'b0;
                    ALUSrc <= 1'b1; 
                    RegWrite <= 1'b1;
                    end
                 
                //Load (LW)
                6'b100011:
                    begin
                    RegDst <= 1'b0; 
                    Jump <= 1'b0; 
                    Branch <= 1'b0; 
                    MemRead <= 1'b1; 
                    MemtoReg <= 1'b1;
                    ALUOp <= 2'b00; 
                    MemWrite <= 1'b0;
                    ALUSrc <= 1'b1; 
                    RegWrite <= 1'b1;
                    end
                
                //Store (SW)
                6'b101011:
                    begin
                    RegDst <= 1'b0; 
                    Jump <= 1'b0; 
                    Branch <= 1'b0; 
                    MemRead <= 1'b0; 
                    MemtoReg <= 1'b0;
                    ALUOp <= 2'b00; 
                    MemWrite <= 1'b1;
                    ALUSrc <= 1'b1; 
                    RegWrite <= 1'b0;
                    end
            endcase
        end
endmodule
