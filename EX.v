module EX(clk,reset,intterupt,
    readdata1EX,readdata2EX,extenddataEX,rdaddrEX,rtaddrEX,rsaddrEX,shamtEX,
    regwritedataWB,ALUoutMEM,regwriteaddrWB,regwriteaddrMEM,RegWriteWB,RegWriteMEM,
    ALUSrcEX,ALUOpEX,RegDstEX,FunctEX,
    ALUequalEX,ALUoutEX,memwritedataEX,regwriteaddrEX);

    input clk,reset,intterupt;
    input [31:0] readdata1EX,readdata2EX,extenddataEX;
    input [31:0] regwritedataWB,ALUoutMEM;
    input [4:0] rdaddrEX,rtaddrEX,rsaddrEX;
    input [4:0] regwriteaddrMEM,regwriteaddrWB;
    input [4:0] shamtEX;
    input ALUSrcEX;
    input RegWriteMEM,RegWriteWB;
    input [1:0] RegDstEX;
    input [3:0] ALUOpEX;
    input [5:0] FunctEX;
    output ALUequalEX;
    output [31:0] ALUoutEX,memwritedataEX;
    output [4:0] regwriteaddrEX;

    wire [4:0] ALUCt;
    wire Sign;
    ALUControl ALUControl(.ALUOp(ALUOpEX),.Funct(FunctEX),.ALUCt(ALUCt),.Sign(Sign));

    wire [31:0] forwardout1EX,forwardout2EX;
    DataForward DataForwardEX(.clk(clk),.reset(reset),.intterupt(intterupt),
        .readdata1(readdata1EX),.readdata2(readdata2EX),.regwritedataWB(regwritedataWB),.ALUoutMEM(ALUoutMEM),//input data
        .regwriteaddrWB(regwriteaddrWB),.regwriteaddrMEM(regwriteaddrMEM),.rsaddr(rsaddrEX),.rtaddr(rtaddrEX),
        .RegWriteWB(RegWriteWB),.RegWriteMEM(RegWriteMEM),//input control signals
        .forwardout1(forwardout1EX),.forwardout2(forwardout2EX));//output data

    wire [31:0] ALUin2;
    assign ALUin2=ALUSrcEX?extenddataEX:forwardout2EX;
    ALU ALU(.in1(forwardout1EX),.in2(ALUin2),.ALUCt(ALUCt),.Sign(Sign),.shamt(shamtEX),
        .out(ALUoutEX),.zero(ALUequalEX));

    assign memwritedataEX=forwardout2EX;
    assign regwriteaddrEX=(RegDstEX==2'b00)? rtaddrEX:(RegDstEX==2'b01)? rdaddrEX:(RegDstEX==2'b10)? 5'b11111:5'b11010;

endmodule