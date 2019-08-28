module WB(clk,reset,intterupt,
    memreaddataWB,ALUoutWB,PCplus4WB,MemtoRegWB,regwritedataWB);

    input clk,reset,intterupt;
    input [31:0] memreaddataWB,ALUoutWB,PCplus4WB;
    input [1:0] MemtoRegWB;
    output [31:0] regwritedataWB;

    assign regwritedataWB=(MemtoRegWB==2'b01)? memreaddataWB:(MemtoRegWB==2'b00)? ALUoutWB:PCplus4WB;

endmodule