module ID_EX(clk,reset,intterupt,
    PCplus4ID,readdata1ID,readdata2ID,extenddataID,rdaddrID,rtaddrID,rsaddrID,
    RegWriteID,ExtOpID,MemReadID,MemWriteID,FunctID,shamtID,PCID,
    ALUSrcID,MemtoRegID,RegDstID,ALUOpID,
    PCplus4EX,readdata1EX,readdata2EX,extenddataEX,rdaddrEX,rtaddrEX,rsaddrEX,
    RegWriteEX,ExtOpEX,MemReadEX,MemWriteEX,FunctEX,shamtEX,PCEX,
    ALUSrcEX,MemtoRegEX,RegDstEX,ALUOpEX);

    input clk,reset,intterupt;
    input [31:0] PCplus4ID,readdata1ID,readdata2ID,extenddataID,PCID;
    input [4:0] rdaddrID,rtaddrID,rsaddrID,shamtID;
    input RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID;
    input [1:0] RegDstID,MemtoRegID;
    input [3:0] ALUOpID;
    input [5:0] FunctID;
    output reg [31:0] PCplus4EX,readdata1EX,readdata2EX,extenddataEX,PCEX;
    output reg [4:0] rdaddrEX,rtaddrEX,rsaddrEX,shamtEX;
    output reg RegWriteEX,ExtOpEX,MemReadEX,MemWriteEX,ALUSrcEX;
    output reg [1:0] RegDstEX,MemtoRegEX;
    output reg [3:0] ALUOpEX;
    output reg [5:0] FunctEX;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            PCplus4EX<=0;
            PCEX<=0;
            readdata1EX<=0;
            readdata2EX<=0;
            extenddataEX<=0;
            rdaddrEX<=0;
            rtaddrEX<=0;
            rsaddrEX<=0;
            shamtEX<=0;
            RegWriteEX<=0;
            ExtOpEX<=0;
            MemReadEX<=0;
            MemWriteEX<=0;
            ALUSrcEX<=0;
            MemtoRegEX<=0;
            RegDstEX<=0;
            ALUOpEX<=0;
            FunctEX<=0;
        end
        else begin
            PCplus4EX<=PCplus4ID;
            PCEX<=PCID;
            readdata1EX<=readdata1ID;
            readdata2EX<=readdata2ID;
            extenddataEX<=extenddataID;
            rdaddrEX<=rdaddrID;
            rtaddrEX<=rtaddrID;
            rsaddrEX<=rsaddrID;
            shamtEX<=shamtID;
            RegWriteEX<=RegWriteID;
            ExtOpEX<=ExtOpID;
            MemReadEX<=MemReadID;
            MemWriteEX<=MemWriteID;
            ALUSrcEX<=ALUSrcID;
            MemtoRegEX<=MemtoRegID;
            RegDstEX<=RegDstID;
            ALUOpEX<=ALUOpID;
            FunctEX<=FunctID;
        end
    end

endmodule