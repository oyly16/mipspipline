module MEM_WB(clk,reset,intterupt,
    ALUoutMEM,memreaddataMEM,regwriteaddrMEM,MemtoRegMEM,RegWriteMEM,PCplus4MEM,PCMEM,
    ALUoutWB,memreaddataWB,regwriteaddrWB,MemtoRegWB,RegWriteWB,PCplus4WB,PCWB);

    input clk,reset,intterupt;
    input [31:0] ALUoutMEM,memreaddataMEM,PCplus4MEM,PCMEM;
    input [4:0] regwriteaddrMEM;
    input [1:0] MemtoRegMEM;
    input RegWriteMEM;
    output reg [31:0] ALUoutWB,memreaddataWB,PCplus4WB,PCWB;
    output reg [4:0] regwriteaddrWB;
    output reg [1:0] MemtoRegWB;
    output reg RegWriteWB;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ALUoutWB<=0;
            memreaddataWB<=0;
            regwriteaddrWB<=0;
            MemtoRegWB<=0;
            RegWriteWB<=0;
            PCplus4WB<=0;
            PCWB<=0;
        end
        else begin
            ALUoutWB<=ALUoutMEM;
            memreaddataWB<=memreaddataMEM;
            regwriteaddrWB<=regwriteaddrMEM;
            MemtoRegWB<=MemtoRegMEM;
            RegWriteWB<=RegWriteMEM;
            PCplus4WB<=PCplus4MEM;
            PCWB<=PCMEM;
        end
    end

endmodule