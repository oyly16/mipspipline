module MEM_WB(clk,reset,intterupt,
    ALUoutMEM,memreaddataMEM,regwriteaddrMEM,MemtoRegMEM,RegWriteMEM,
    ALUoutWB,memreaddataWB,regwriteaddrWB,MemtoRegWB,RegWriteWB);

    input clk,reset,intterupt;
    input [31:0] ALUoutMEM,memreaddataMEM;
    input [4:0] regwriteaddrMEM;
    input MemtoRegMEM,RegWriteMEM;
    output reg [31:0] ALUoutWB,memreaddataWB;
    output reg [4:0] regwriteaddrWB;
    output reg MemtoRegWB,RegWriteWB;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ALUoutWB<=0;
            memreaddataWB<=0;
            regwriteaddrWB<=0;
            MemtoRegWB<=0;
            RegWriteWB<=0;
        end
        else begin
            ALUoutWB<=ALUoutMEM;
            memreaddataWB<=memreaddataMEM;
            regwriteaddrWB<=regwriteaddrMEM;
            MemtoRegWB<=MemtoRegMEM;
            RegWriteWB<=RegWriteMEM;
        end
    end

endmodule