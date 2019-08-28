module EX_MEM(clk,reset,intterupt,
    ALUequalEX,MemWriteEX,MemReadEX,MemtoRegEX,RegWriteEX,
    ALUoutEX,memwritedataEX,regwriteaddrEX,PCplus4EX,
    ALUequalMEM,MemWriteMEM,MemReadMEM,MemtoRegMEM,RegWriteMEM,
    ALUoutMEM,memwritedataMEM,regwriteaddrMEM,PCplus4MEM);

    input clk,reset,intterupt;
    input ALUequalEX,MemWriteEX,MemReadEX,RegWriteEX;
    input [1:0] MemtoRegEX; 
    input [31:0] ALUoutEX,memwritedataEX,PCplus4EX;
    input [4:0] regwriteaddrEX;
    output reg ALUequalMEM,MemWriteMEM,MemReadMEM,RegWriteMEM;
    output reg [1:0] MemtoRegMEM;
    output reg [31:0] ALUoutMEM,memwritedataMEM,PCplus4MEM;
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
            PCplus4MEM<=0;
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
            PCplus4MEM<=PCplus4EX;
        end
    end

endmodule