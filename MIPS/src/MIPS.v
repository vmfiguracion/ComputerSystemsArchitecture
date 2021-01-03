`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 03:38:12 PM
// Design Name: 
// Module Name: MIPS
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
//PROCESSOR
module MIPS(
	input clk,
	input rst
);

wire [31:0] PCin;
wire [31:0] RF_wr_data;
wire [31:0] pcAddRes;
wire [31:0] pcRes;
wire [31:0] instruction;
wire [31:0] jumpAddr;
wire RegDST, JUMP, BRANCH, MemREAD, MemtoREG, MemWRITE, ALUSRC, RegWRITE;
wire [1:0] ALUOP;
wire [3:0] ALUctlout;    
wire [31:0] seOut;
wire [31:0] aluOut;
wire [31:0] regAData;
wire [31:0] regBData;
wire [31:0] DMAddr;
wire [31:0] DMOut;

//Instantiate program counter
PC pc(
    .pcIn(PCin),
    .rst(rst),
    .clk(clk),
    
    .pcRes(pcRes)
);

//Instantiate PC adder
pcAdd pca(
    .clk(clk),
    .rst(rst),
    .pcRes(pcRes),
    .pcAddRes(pcAddRes)
);

//Instantiate the instruction memory
Imemory Imem(
    .clk(clk),
    .rst(rst),

    //Read side
    .addr(pcRes),  //32 bit input (address) from program counter
    .instruction(instruction)     
);

//Instantiate shift for jump address
instructionShift IS(
    .clk(clk),
    .rst(rst),
    .instruction(instruction[25:0]),
    .PC4(pcAddRes[31:28]),
    
    .jumpAddr(jumpAddr)
);

//Instantiate control module
Control ctrl(
    .clk(clk),
    .rst(rst),
    
    .opCode(instruction[31:26]),
    
    .RegDst(RegDST),
    .Jump(JUMP), 
    .Branch(BRANCH), 
    .MemRead(MemREAD), 
    .MemtoReg(MemtoREG),
    .ALUOp(ALUOP), 
    .MemWrite(MemWRITE), 
    .ALUSrc(ALUSRC), 
    .RegWrite(RegWRITE)
);

//Instantiate ALU Control module
ALUControl aluctrl(
    .clk(clk),
    .rst(rst),
    
    .ALUOp(ALUOP),
    .func(instruction[5:0]),
        
    .ALU_control_out(ALUctlout)
);

//The bottom left most mux in the diagram
wire [4:0] RF_wr_addr = (RegDST) ? instruction[20:16] : instruction[15:11]; //condition ? if true : if false

//Instantiate register file
reg_file RF(
    .clk(clk),
    .rst(rst),

    //Read side
	//Dependent on which instruction is exiting the instruction memory
    .regA_addr(instruction[25:21]), //rs in MIPS ISA
    .regB_addr(instruction[20:16]), //rt in MIPS ISA
    .regA(regAData),				//registers are 32 bits wide
    .regB(regBData),				//registers are 32 bits wide

    //Write side
    .wr_addr(RF_wr_addr), // The register is dependant on what the value of the control unit
    .data(RF_wr_data),
    .we(RegWRITE)               //write enable
);

//Instantiate sign extention
signExtend se(
    .clk(clk),
    .rst(rst),
    .in(instruction[15:11]), 
    .out(seOut)
);

//Shift sign extended instruction by 2
wire [31:0] seOutShift = seOut << 2;

//Instantiate ALU for the instruction
ALU instructionALU(
      .clk(clk),
      .rst(rst),
      .a(pcAddRes),
      .b(seOutShift),
      .op(4'b0010),    //Add
      .res(aluOut),
      .zero(ZERO)
);

//The bottom middle mux in the diagram
wire [4:0] aluInput = (ALUSRC) ? seOut : regBData; //condition ? if true : if false

//Instantiate ALU from Register File to Data Memory
ALU aluRF_DM(
      .clk(clk),
      .rst(rst),
      .a(regAData),
      .b(seOut),
      .op(ALUctlout),
      
      .res(DMAddr),
      .zero(ZERO)
);

//The top left mux in the diagram
wire [31:0] firstMux = ((BRANCH & ZERO)) ? aluOut : pcAddRes; //condition ? if true : if false

//The top right mux in the diagram
assign PCin = (JUMP) ? jumpAddr : firstMux; //condition ? if true : if false

//Instantiate Data Memory
Dmemory Dmem(
    .clk(clk),
    .rst(rst),

    //Read side
    .r_addr(DMAddr),     //32 bit read address
    .data_out(DMOut),   //The only output
    .re(memREAD),       //read enable

    //Write side
    .wr_addr(DMAddr),	//32 bit write address
    .data_in(regBData),		
    .we(MemWRITE)		//write enable
);

//The bottom right most mux in the diagram
assign RF_wr_data = (MemtoREG) ? DMOut : DMAddr; //condition ? if true : if false

endmodule