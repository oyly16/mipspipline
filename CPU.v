
module CPU(reset, clk, intterupt);

	input reset, clk, intterupt;//reset,clock and intterupt
    wire stall;

    wire PCSrcMEM;//control signal to decide the next PC
    //wire [31:0] jumpaddr;//address of j,jal
    wire [31:0] branchaddrMEM;//address of branch
    //wire [31:0] regaddr;//address of $ra
    wire [31:0] instructionIF,instructionID;//instruction in IF,ID
    wire [31:0] PCplus4IF;//PC+4 in IF
	
    IF IF(.clk(clk),.reset(reset),.intterupt(intterupt),.stall(stall),
        .PCSrcMEM(PCSrcMEM),//input control signals
        .branchaddrMEM(branchaddrMEM),.instructionID(instructionID),//input data
        .instructionIF(instructionIF),.PCplus4IF(PCplus4IF));//output data    

    //wire [31:0] instructionID;//used in IF stall
    wire [31:0] PCplus4ID;

    IF_ID IF_ID(.clk(clk),.reset(reset),.intterupt(intterupt),
        .PCplus4IF(PCplus4IF),.instructionIF(instructionIF),//input
        .PCplus4ID(PCplus4ID),.instructionID(instructionID));//output

    wire [4:0] regwriteaddrWB;//regwrite address from WB
    wire [31:0] regwritedataWB;//regwrite data from WB
    wire RegWriteWB;//regwrite control signal from WB
    wire [31:0] readdata1ID;
    wire [31:0] readdata2ID;//read data from registers
    wire [31:0] extenddataID;//imm extend data
    wire [4:0] rdaddrID,rsaddrID,rtaddrID;//register dst address
    wire RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID,MemtoRegID,BranchID;
    wire [1:0] RegDstID;
    wire [3:0] ALUOpID;
    wire [5:0] FunctID;//control signals

    ID ID(.clk(clk),.reset(reset),.intterupt(intterupt),.stall(stall),
        .instructionID(instructionID),
        .regwriteaddrWB(regwriteaddrWB),.regwritedataWB(regwritedataWB),.RegWriteWB(RegWriteWB),//input data and control signals
        .readdata1ID(readdata1ID),.readdata2ID(readdata2ID),.extenddataID(extenddataID),
        .rdaddrID(rdaddrID),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),//output data
        .RegWriteID(RegWriteID),.ExtOpID(ExtOpID),.MemReadID(MemReadID),
        .MemWriteID(MemWriteID),.ALUSrcID(ALUSrcID),.MemtoRegID(MemtoRegID),
        .BranchID(BranchID),.RegDstID(RegDstID),.ALUOpID(ALUOpID),.FunctID(FunctID));//output control signals
    
    wire [31:0] PCplus4EX;
    wire [31:0] readdata1EX;
    wire [31:0] readdata2EX;//read data from registers
    wire [31:0] extenddataEX;//imm extend data
    wire [4:0] rdaddrEX,rtaddrEX,rsaddrEX;//register dst address
    wire RegWriteEX,ExtOpEX,MemReadEX,MemWriteEX,ALUSrcEX,MemtoRegEX,BranchEX;
    wire [1:0] RegDstEX;
    wire [3:0] ALUOpEX;
    wire [5:0] FunctEX;//control signals

    Stall Stall(.clk(clk),.reset(reset),.intterupt(intterupt),
        .MemReadEX(MemReadEX),.rtaddrEX(rtaddrEX),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),//input data and sig
        .stall(stall));//output sig

    ID_EX ID_EX(.clk(clk),.reset(reset),.intterupt(intterupt),
        .PCplus4ID(PCplus4ID),.readdata1ID(readdata1ID),.readdata2ID(readdata2ID),.extenddataID(extenddataID),
        .rdaddrID(rdaddrID),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),
        .RegWriteID(RegWriteID),.ExtOpID(ExtOpID),.MemReadID(MemReadID),
        .MemWriteID(MemWriteID),.ALUSrcID(ALUSrcID),.MemtoRegID(MemtoRegID),
        .BranchID(BranchID),.RegDstID(RegDstID),.ALUOpID(ALUOpID),.FunctID(FunctID),
        .PCplus4EX(PCplus4EX),.readdata1EX(readdata1EX),.readdata2EX(readdata2EX),.extenddataEX(extenddataEX),
        .rdaddrEX(rdaddrEX),.rtaddrEX(rtaddrEX),.rsaddrEX(rsaddrEX),
        .RegWriteEX(RegWriteEX),.ExtOpEX(ExtOpEX),.MemReadEX(MemReadEX),
        .MemWriteEX(MemWriteEX),.ALUSrcEX(ALUSrcEX),.MemtoRegEX(MemtoRegEX),
        .BranchEX(BranchEX),.RegDstEX(RegDstEX),.ALUOpEX(ALUOpEX),.FunctEX(FunctEX));

    wire [31:0] branchaddrEX;
    wire [31:0] ALUoutEX;
    wire [31:0] memwritedataEX;
    wire [4:0] regwriteaddrEX;
    wire ALUequalEX;
    wire [31:0] ALUoutMEM;
    wire [4:0] regwriteaddrMEM;
    wire RegWriteMEM;//forward input

    EX EX(.clk(clk),.reset(reset),.intterupt(intterupt),
        .PCplus4EX(PCplus4EX),.readdata1EX(readdata1EX),.readdata2EX(readdata2EX),.extenddataEX(extenddataEX),
        .rdaddrEX(rdaddrEX),.rtaddrEX(rtaddrEX),.rsaddrEX(rsaddrEX),
        .regwritedataWB(regwritedataWB),.ALUoutMEM(ALUoutMEM),.regwriteaddrWB(regwriteaddrWB),.regwriteaddrMEM(regwriteaddrMEM),//input data
        .RegWriteWB(RegWriteWB),.RegWriteMEM(RegWriteMEM),
        .ALUSrcEX(ALUSrcEX),.ALUOpEX(ALUOpEX),.RegDstEX(RegDstEX),.FunctEX(FunctEX),//input control signals
        .ALUequalEX(ALUequalEX),//output control signals
        .branchaddrEX(branchaddrEX),.ALUoutEX(ALUoutEX),.memwritedataEX(memwritedataEX),.regwriteaddrEX(regwriteaddrEX));//output data

    //wire [31:0] branchaddrMEM;//used in IF
    //wire [31:0] ALUoutMEM;//used in EX
    wire [31:0] memwritedataMEM;
    //wire [4:0] regwriteaddrMEM;//uesd in EX
    wire ALUequalMEM,MemWriteMEM,MemReadMEM,BranchMEM,MemtoRegMEM;//,RegWriteMEM;

    EX_MEM EX_MEM(.clk(clk),.reset(reset),.intterupt(intterupt),
        .ALUequalEX(ALUequalEX),.MemWriteEX(MemWriteEX),.MemReadEX(MemReadEX),.BranchEX(BranchEX),.MemtoRegEX(MemtoRegEX),.RegWriteEX(RegWriteEX),
        .branchaddrEX(branchaddrEX),.ALUoutEX(ALUoutEX),.memwritedataEX(memwritedataEX),.regwriteaddrEX(regwriteaddrEX),
        .ALUequalMEM(ALUequalMEM),.MemWriteMEM(MemWriteMEM),.MemReadMEM(MemReadMEM),.BranchMEM(BranchMEM),.MemtoRegMEM(MemtoRegMEM),.RegWriteMEM(RegWriteMEM),
        .branchaddrMEM(branchaddrMEM),.ALUoutMEM(ALUoutMEM),.memwritedataMEM(memwritedataMEM),.regwriteaddrMEM(regwriteaddrMEM));

    wire [31:0] memreaddataMEM;
    //wire PCSrcMEM;//used in IF

    MEM MEM(.clk(clk),.reset(reset),.intterupt(intterupt),
        .branchaddrMEM(branchaddrMEM),.memaddrMEM(ALUoutMEM),.memwritedataMEM(memwritedataMEM),//input data
        .ALUequalMEM(ALUequalMEM),.MemWriteMEM(MemWriteMEM),.MemReadMEM(MemReadMEM),.BranchMEM(BranchMEM),//input control signals
        .memreaddataMEM(memreaddataMEM),.PCSrcMEM(PCSrcMEM));//output data and control signals

    wire [31:0] ALUoutWB;
    wire [31:0] memreaddataWB;
    //wire [4:0] regwriteaddrWB;//used in ID
    wire MemtoRegWB;
    //wire RegWriteWB;//used in ID

    MEM_WB MEM_WB(.clk(clk),.reset(reset),.intterupt(intterupt),
        .ALUoutMEM(ALUoutMEM),.memreaddataMEM(memreaddataMEM),.regwriteaddrMEM(regwriteaddrMEM),
        .MemtoRegMEM(MemtoRegMEM),.RegWriteMEM(RegWriteMEM),
        .ALUoutWB(ALUoutWB),.memreaddataWB(memreaddataWB),.regwriteaddrWB(regwriteaddrWB),
        .MemtoRegWB(MemtoRegWB),.RegWriteWB(RegWriteWB));

    //wire [31:0] regwritedataWB;//used in ID

    WB WB(.clk(clk),.reset(reset),.intterupt(intterupt),
        .memreaddataWB(memreaddataWB),.ALUoutWB(ALUoutWB),.MemtoRegWB(MemtoRegWB),//input
        .regwritedataWB(regwritedataWB));//output

endmodule
	