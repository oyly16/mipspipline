module WB(clk,reset,intterupt,
    memreaddataWB,ALUoutWB,MemtoRegWB,regwritedataWB);

    input clk,reset,intterupt;
    input [31:0] memreaddataWB,ALUoutWB;
    input MemtoRegWB;
    output [31:0] regwritedataWB;

    assign regwritedataWB=MemtoRegWB? memreaddataWB:ALUoutWB;

endmodule