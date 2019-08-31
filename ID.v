module ID(clk,reset,intterupt,stall,exception,instructionID,PCplus4ID,PCID,regwriteaddrWB,regwritedataWB,RegWriteWB,RegWriteMEM,
    ALUoutMEM,regwriteaddrMEM,readdata1ID,readdata2ID,extenddataID,rdaddrID,rtaddrID,rsaddrID,branchaddrID,jumpaddrID,
    JumpID,JRID,PCSrcID,RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID,MemtoRegID,BranchID,RegDstID,ALUOpID,FunctID,shamtID);

    input clk,reset,intterupt,stall;
    input [31:0] instructionID,PCplus4ID,PCID;
    input [4:0] regwriteaddrWB,regwriteaddrMEM;
    input [31:0] regwritedataWB,ALUoutMEM;
    input RegWriteWB,RegWriteMEM;
    output exception;
    output [31:0] readdata1ID;
    output [31:0] readdata2ID;
    output [31:0] extenddataID;
    output [31:0] branchaddrID,jumpaddrID;
    output [4:0] rdaddrID,rtaddrID,rsaddrID,shamtID;
    output RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID,BranchID,JumpID,JRID;
    output [1:0] RegDstID,MemtoRegID;
    output [3:0] ALUOpID;
    output [5:0] FunctID;
    output [2:0] PCSrcID;

    assign exception=(instructionID[31:26]==6'h3f);
    Control Control(.OpCode(instructionID[31:26]),.Funct(instructionID[5:0]),.stall(stall),.intterupt(intterupt),.exception(exception),
		.BranchID(BranchID),.RegWriteID(RegWriteID),.RegDstID(RegDstID),.JumpID(JumpID),.JRID(JRID), 
		.MemReadID(MemReadID),.MemWriteID(MemWriteID),.MemtoRegID(MemtoRegID),
		.ALUSrcID(ALUSrcID),.ExtOpID(ExtOpID),.ALUOpID(ALUOpID));

    wire [31:0] regreaddata1,regreaddata2;

    RegisterFile RegisterFile(.reset(reset),.clk(clk),.RegWriteWB(RegWriteWB),
        .readaddr1(instructionID[25:21]),.readaddr2(instructionID[20:16]),.regwriteaddrWB(regwriteaddrWB),.regwritedataWB(regwritedataWB),
	    .readdata1(regreaddata1),.readdata2(regreaddata2));

    assign extenddataID={ExtOpID? {16{instructionID[15]}}:16'h0000, instructionID[15:0]};
    assign rdaddrID=instructionID[15:11];
    assign rtaddrID=instructionID[20:16];
    assign rsaddrID=instructionID[25:21];
    assign shamtID=instructionID[10:6];
    assign FunctID=instructionID[5:0];

    wire forwardWB_ID1,forwardWB_ID2;
    assign forwardWB_ID1=RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==instructionID[25:21]);
    assign forwardWB_ID2=RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==instructionID[20:16]);

    assign readdata1ID=forwardWB_ID1? regwritedataWB:regreaddata1;
    assign readdata2ID=forwardWB_ID2? regwritedataWB:regreaddata2;//WB_ID forwarding

    wire compare;
    wire [31:0] forwardout1ID,forwardout2ID;
    Compare Compare(.forwardout1ID(forwardout1ID),.forwardout2ID(forwardout2ID),.OpCode(instructionID[31:26]),.compare(compare));
    assign PCSrcID=(intterupt)? 3'd3: (exception & PCID[31]==0)? 3'd4: (BranchID & compare)? 3'd1:(JumpID)?3'd2:3'd0;
    assign branchaddrID=PCplus4ID+{extenddataID[29:0],2'b00};

    DataForward DataForwardID(.clk(clk),.reset(reset),.intterupt(intterupt),
      .readdata1(readdata1ID),.readdata2(readdata2ID),.regwritedataWB(regwritedataWB),.ALUoutMEM(ALUoutMEM),//input data
      .regwriteaddrWB(regwriteaddrWB),.regwriteaddrMEM(regwriteaddrMEM),.rsaddr(rsaddrID),.rtaddr(rtaddrID),
      .RegWriteWB(RegWriteWB),.RegWriteMEM(RegWriteMEM),//input control signals
      .forwardout1(forwardout1ID),.forwardout2(forwardout2ID));//output data

    assign jumpaddrID=JRID?forwardout1ID:{PCplus4ID[31:28],instructionID[25:0],2'b00};

endmodule