module MEM(clk,reset,intterupt,
    memaddrMEM,memwritedataMEM,
    ALUequalMEM,MemWriteMEM,MemReadMEM,
    memreaddataMEM);

    input clk,reset,intterupt;
    input [31:0] memaddrMEM,memwritedataMEM;
    input ALUequalMEM,MemWriteMEM,MemReadMEM;
    output [31:0] memreaddataMEM;
    
    DataMemory DataMemory(.reset(reset),.clk(clk),.Address(memaddrMEM),.Write_data(memwritedataMEM),.Read_data(memreaddataMEM),
        .MemRead(MemReadMEM),.MemWrite(MemWriteMEM));

endmodule