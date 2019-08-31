
module CPU(reset, clk);

	input reset, clk;//reset,and clock
    wire stall,flush;//stall for load-use,flush for beq,j
    wire intterupt,exception;
    wire [7:0] leds;
    wire [11:0] digi;

    //wire PCSrcMEM;//control signal to decide the next PC
    wire [2:0] PCSrcID;//control signal to decide the next PC
    wire [31:0] jumpaddrID;//address of j,jal
    wire [31:0] branchaddrID;//address of branch
    //wire [31:0] regaddr;//address of $ra
    wire [31:0] instructionIF,instructionID;//instruction in IF,ID
    wire [31:0] PCplus4IF,PCIF;//PC and PC+4 in IF
	
    IF IF(.clk(clk),.reset(reset),.intterupt(intterupt),.stall(stall),.flush(flush),.exception(exception),
        .PCSrcID(PCSrcID),//input control signals
        .branchaddrID(branchaddrID),.instructionID(instructionID),.jumpaddrID(jumpaddrID),//input data
        .instructionIF(instructionIF),.PCplus4IF(PCplus4IF),.PCIF(PCIF));//output data    

    //wire [31:0] instructionID;//used in IF stall
    wire [31:0] PCplus4ID,PCID;

    IF_ID IF_ID(.clk(clk),.reset(reset),.intterupt(intterupt),
        .PCIF(PCIF),.PCplus4IF(PCplus4IF),.instructionIF(instructionIF),//input
        .PCID(PCID),.PCplus4ID(PCplus4ID),.instructionID(instructionID));//output

    wire [4:0] regwriteaddrWB,regwriteaddrMEM;//regwrite address from WB,MEM
    wire [31:0] regwritedataWB,ALUoutMEM;//regwrite data from WB,MEM
    wire RegWriteWB,RegWriteMEM;//regwrite control signal from WB,MEM
    wire [31:0] readdata1ID;
    wire [31:0] readdata2ID;//read data from registers
    wire [31:0] extenddataID;//imm extend data
    //wire [31:0] branchaddrID;
    wire [4:0] rdaddrID,rsaddrID,rtaddrID;//register dst address
    wire [4:0] shamtID;
    wire RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID,BranchID,JumpID,JRID;
    wire [1:0] RegDstID,MemtoRegID;
    wire [3:0] ALUOpID;
    wire [5:0] FunctID;//control signals

    ID ID(.clk(clk),.reset(reset),.intterupt(intterupt),.stall(stall),.exception(exception),
        .instructionID(instructionID),.PCplus4ID(PCplus4ID),.PCID(PCID),
        .regwriteaddrWB(regwriteaddrWB),.regwritedataWB(regwritedataWB),.RegWriteWB(RegWriteWB),
        .regwriteaddrMEM(regwriteaddrMEM),.ALUoutMEM(ALUoutMEM),.RegWriteMEM(RegWriteMEM),//input data and control signals
        .readdata1ID(readdata1ID),.readdata2ID(readdata2ID),.extenddataID(extenddataID),
        .rdaddrID(rdaddrID),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),.branchaddrID(branchaddrID),.jumpaddrID(jumpaddrID),//output data
        .RegWriteID(RegWriteID),.ExtOpID(ExtOpID),.MemReadID(MemReadID),.PCSrcID(PCSrcID),.shamtID(shamtID),
        .MemWriteID(MemWriteID),.ALUSrcID(ALUSrcID),.MemtoRegID(MemtoRegID),.JumpID(JumpID),.JRID(JRID),
        .BranchID(BranchID),.RegDstID(RegDstID),.ALUOpID(ALUOpID),.FunctID(FunctID));//output control signals
    
    wire [31:0] PCplus4EX,PCEX;
    wire [31:0] readdata1EX;
    wire [31:0] readdata2EX;//read data from registers
    wire [31:0] extenddataEX;//imm extend data
    wire [4:0] rdaddrEX,rtaddrEX,rsaddrEX;//register dst address
    wire [4:0] shamtEX;
    wire RegWriteEX,ExtOpEX,MemReadEX,MemWriteEX,ALUSrcEX;
    wire [1:0] RegDstEX,MemtoRegEX;
    wire [3:0] ALUOpEX;
    wire [5:0] FunctEX;//control signals

    wire [4:0] regwriteaddrEX;
    wire MemReadMEM;
    wire [1:0] MemtoRegMEM;
    StallFlush StallFlush(.clk(clk),.reset(reset),.intterupt(intterupt),
        .regwriteaddrEX(regwriteaddrEX),.BranchID(BranchID),.RegWriteEX(RegWriteEX),.JRID(JRID),
        .MemReadEX(MemReadEX),.rtaddrEX(rtaddrEX),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),.PCSrcID(PCSrcID),
        .MemReadMEM(MemReadMEM),.MemtoRegMEM(MemtoRegMEM),.regwriteaddrMEM(regwriteaddrMEM),//input data and sig
        .stall(stall),.flush(flush));//output sig

    ID_EX ID_EX(.clk(clk),.reset(reset),.intterupt(intterupt),
        .readdata1ID(readdata1ID),.readdata2ID(readdata2ID),.extenddataID(extenddataID),.PCplus4ID(PCplus4ID),
        .rdaddrID(rdaddrID),.rtaddrID(rtaddrID),.rsaddrID(rsaddrID),.shamtID(shamtID),.PCID(PCID),
        .RegWriteID(RegWriteID),.ExtOpID(ExtOpID),.MemReadID(MemReadID),
        .MemWriteID(MemWriteID),.ALUSrcID(ALUSrcID),.MemtoRegID(MemtoRegID),
        .RegDstID(RegDstID),.ALUOpID(ALUOpID),.FunctID(FunctID),
        .readdata1EX(readdata1EX),.readdata2EX(readdata2EX),.extenddataEX(extenddataEX),.PCplus4EX(PCplus4EX),
        .rdaddrEX(rdaddrEX),.rtaddrEX(rtaddrEX),.rsaddrEX(rsaddrEX),.shamtEX(shamtEX),.PCEX(PCEX),
        .RegWriteEX(RegWriteEX),.ExtOpEX(ExtOpEX),.MemReadEX(MemReadEX),
        .MemWriteEX(MemWriteEX),.ALUSrcEX(ALUSrcEX),.MemtoRegEX(MemtoRegEX),
        .RegDstEX(RegDstEX),.ALUOpEX(ALUOpEX),.FunctEX(FunctEX));

    //wire [31:0] branchaddrEX;
    wire [31:0] ALUoutEX;
    wire [31:0] memwritedataEX;
    //wire [4:0] regwriteaddrEX;
    wire ALUequalEX;
    //wire [31:0] ALUoutMEM;
    //wire [4:0] regwriteaddrMEM;
    //wire RegWriteMEM;//forward input

    EX EX(.clk(clk),.reset(reset),.intterupt(intterupt),
        .readdata1EX(readdata1EX),.readdata2EX(readdata2EX),.extenddataEX(extenddataEX),
        .rdaddrEX(rdaddrEX),.rtaddrEX(rtaddrEX),.rsaddrEX(rsaddrEX),.shamtEX(shamtEX),
        .regwritedataWB(regwritedataWB),.ALUoutMEM(ALUoutMEM),.regwriteaddrWB(regwriteaddrWB),.regwriteaddrMEM(regwriteaddrMEM),//input data
        .RegWriteWB(RegWriteWB),.RegWriteMEM(RegWriteMEM),
        .ALUSrcEX(ALUSrcEX),.ALUOpEX(ALUOpEX),.RegDstEX(RegDstEX),.FunctEX(FunctEX),//input control signals
        .ALUequalEX(ALUequalEX),//output control signals
        .ALUoutEX(ALUoutEX),.memwritedataEX(memwritedataEX),.regwriteaddrEX(regwriteaddrEX));//output data

    //wire [31:0] branchaddrMEM;//used in IF
    //wire [31:0] ALUoutMEM;//used in EX
    wire [31:0] memwritedataMEM;
    //wire [4:0] regwriteaddrMEM;//uesd in EX
    wire [31:0] PCplus4MEM,PCMEM;
    wire ALUequalMEM,MemWriteMEM;//MemReadMEM,RegWriteMEM;
    //wire [1:0] MemtoRegMEM;

    EX_MEM EX_MEM(.clk(clk),.reset(reset),.intterupt(intterupt),
        .ALUequalEX(ALUequalEX),.MemWriteEX(MemWriteEX),.MemReadEX(MemReadEX),.MemtoRegEX(MemtoRegEX),.RegWriteEX(RegWriteEX),
        .ALUoutEX(ALUoutEX),.memwritedataEX(memwritedataEX),.regwriteaddrEX(regwriteaddrEX),.PCplus4EX(PCplus4EX),.PCEX(PCEX),
        .ALUequalMEM(ALUequalMEM),.MemWriteMEM(MemWriteMEM),.MemReadMEM(MemReadMEM),.MemtoRegMEM(MemtoRegMEM),.RegWriteMEM(RegWriteMEM),
        .ALUoutMEM(ALUoutMEM),.memwritedataMEM(memwritedataMEM),.regwriteaddrMEM(regwriteaddrMEM),.PCplus4MEM(PCplus4MEM),.PCMEM(PCMEM));

    wire [31:0] memreaddataMEM;
    //wire PCSrcMEM;//used in IF

    MEM MEM(.clk(clk),.reset(reset),.intterupt(intterupt),.leds(leds),.digi(digi),
        .memaddrMEM(ALUoutMEM),.memwritedataMEM(memwritedataMEM),.check(PCIF[31]),//input data
        .ALUequalMEM(ALUequalMEM),.MemWriteMEM(MemWriteMEM),.MemReadMEM(MemReadMEM),//input control signals
        .memreaddataMEM(memreaddataMEM));//output data and control signals

    wire [31:0] ALUoutWB;
    wire [31:0] memreaddataWB;
    wire [31:0] PCplus4WB,PCWB;
    //wire [4:0] regwriteaddrWB;//used in ID
    wire [1:0] MemtoRegWB;
    //wire RegWriteWB;//used in ID

    MEM_WB MEM_WB(.clk(clk),.reset(reset),.intterupt(intterupt),
        .ALUoutMEM(ALUoutMEM),.memreaddataMEM(memreaddataMEM),.regwriteaddrMEM(regwriteaddrMEM),
        .MemtoRegMEM(MemtoRegMEM),.RegWriteMEM(RegWriteMEM),.PCplus4MEM(PCplus4MEM),.PCMEM(PCMEM),
        .ALUoutWB(ALUoutWB),.memreaddataWB(memreaddataWB),.regwriteaddrWB(regwriteaddrWB),
        .MemtoRegWB(MemtoRegWB),.RegWriteWB(RegWriteWB),.PCplus4WB(PCplus4WB),.PCWB(PCWB));

    //wire [31:0] regwritedataWB;//used in ID

    WB WB(.clk(clk),.reset(reset),.intterupt(intterupt),
        .PCWB(PCWB),.PCplus4WB(PCplus4WB),.memreaddataWB(memreaddataWB),.ALUoutWB(ALUoutWB),.MemtoRegWB(MemtoRegWB),//input
        .regwritedataWB(regwritedataWB));//output

endmodule
	