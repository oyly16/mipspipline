module MEM(clk,reset,intterupt,
    branchaddrMEM,memaddrMEM,memwritedataMEM,
    ALUequalMEM,MemWriteMEM,MemReadMEM,BranchMEM,
    memreaddataMEM,PCSrcMEM);

    input clk,reset,intterupt;
    input [31:0] branchaddrMEM;
    input [31:0] memaddrMEM,memwritedataMEM;
    input ALUequalMEM,MemWriteMEM,MemReadMEM,BranchMEM;
    output [31:0] memreaddataMEM;
    output PCSrcMEM;

    assign PCSrcMEM=BranchMEM & ALUequalMEM;
    
    DataMemory DataMemory(.reset(reset),.clk(clk),.Address(memaddrMEM),.Write_data(memwritedataMEM),.Read_data(memreaddataMEM),
        .MemRead(MemReadMEM),.MemWrite(MemWriteMEM));

endmodule