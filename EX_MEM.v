module EX_MEM(clk,reset,intterupt,
    ALUequalEX,MemWriteEX,MemReadEX,BranchEX,MemtoRegEX,RegWriteEX,
    branchaddrEX,ALUoutEX,memwritedataEX,regwriteaddrEX,
    ALUequalMEM,MemWriteMEM,MemReadMEM,BranchMEM,MemtoRegMEM,RegWriteMEM,
    branchaddrMEM,ALUoutMEM,memwritedataMEM,regwriteaddrMEM);

    input clk,reset,intterupt;
    input ALUequalEX,MemWriteEX,MemReadEX,BranchEX,MemtoRegEX,RegWriteEX;
    input [31:0] branchaddrEX,ALUoutEX,memwritedataEX;
    input [4:0] regwriteaddrEX;
    output reg ALUequalMEM,MemWriteMEM,MemReadMEM,BranchMEM,MemtoRegMEM,RegWriteMEM;
    output reg [31:0] branchaddrMEM,ALUoutMEM,memwritedataMEM;
    output reg [4:0] regwriteaddrMEM;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ALUequalMEM<=0;
            MemWriteMEM<=0;
            MemReadMEM<=0;
            BranchMEM<=0;
            MemtoRegMEM<=0;
            RegWriteMEM<=0;
            branchaddrMEM<=0;
            ALUoutMEM<=0;
            memwritedataMEM<=0;
            regwriteaddrMEM<=0;
        end
        else begin
            ALUequalMEM<=ALUequalEX;
            MemWriteMEM<=MemWriteEX;
            MemReadMEM<=MemReadEX;
            BranchMEM<=BranchEX;
            MemtoRegMEM<=MemtoRegEX;
            RegWriteMEM<=RegWriteEX;
            branchaddrMEM<=branchaddrEX;
            ALUoutMEM<=ALUoutEX;
            memwritedataMEM<=memwritedataEX;
            regwriteaddrMEM<=regwriteaddrEX;
        end
    end

endmodule