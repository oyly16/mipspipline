module EX_MEM(clk,reset,intterupt,
    ALUequalEX,MemWriteEX,MemReadEX,MemtoRegEX,RegWriteEX,
    ALUoutEX,memwritedataEX,regwriteaddrEX,
    ALUequalMEM,MemWriteMEM,MemReadMEM,MemtoRegMEM,RegWriteMEM,
    ALUoutMEM,memwritedataMEM,regwriteaddrMEM);

    input clk,reset,intterupt;
    input ALUequalEX,MemWriteEX,MemReadEX,MemtoRegEX,RegWriteEX;
    input [31:0] ALUoutEX,memwritedataEX;
    input [4:0] regwriteaddrEX;
    output reg ALUequalMEM,MemWriteMEM,MemReadMEM,MemtoRegMEM,RegWriteMEM;
    output reg [31:0] ALUoutMEM,memwritedataMEM;
    output reg [4:0] regwriteaddrMEM;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ALUequalMEM<=0;
            MemWriteMEM<=0;
            MemReadMEM<=0;
            MemtoRegMEM<=0;
            RegWriteMEM<=0;
            ALUoutMEM<=0;
            memwritedataMEM<=0;
            regwriteaddrMEM<=0;
        end
        else begin
            ALUequalMEM<=ALUequalEX;
            MemWriteMEM<=MemWriteEX;
            MemReadMEM<=MemReadEX;
            MemtoRegMEM<=MemtoRegEX;
            RegWriteMEM<=RegWriteEX;
            ALUoutMEM<=ALUoutEX;
            memwritedataMEM<=memwritedataEX;
            regwriteaddrMEM<=regwriteaddrEX;
        end
    end

endmodule