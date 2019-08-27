module ID(clk,reset,intterupt,stall,instructionID,regwriteaddrWB,regwritedataWB,RegWriteWB,
    readdata1ID,readdata2ID,extenddataID,rdaddrID,rtaddrID,rsaddrID,
    RegWriteID,ExtOpID,MemReadID,MemWriteID,ALUSrcID,MemtoRegID,BranchID,RegDstID,ALUOpID,FunctID);

    input clk,reset,intterupt,stall;
    input [31:0] instructionID;
    input [4:0] regwriteaddrWB;
    input [31:0] regwritedataWB;
    input RegWriteWB;
    output [31:0] readdata1ID;
    output [31:0] readdata2ID;
    output [31:0] extenddataID;
    output [4:0] rdaddrID,rtaddrID,rsaddrID;
    output RegWriteID,ExtOpID,MemReadID,MemWriteID,MemtoRegID,ALUSrcID,BranchID;
    output [1:0] RegDstID;
    output [3:0] ALUOpID;
    output [5:0] FunctID;

    Control Control(.OpCode(instructionID[31:26]),.Funct(instructionID[5:0]),.stall(stall),
		.BranchID(BranchID),.RegWriteID(RegWriteID),.RegDstID(RegDstID), 
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
    assign FunctID=instructionID[5:0];

    wire forwardWB_ID1,forwardWB_ID2;
    assign forwardWB_ID1=RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==instructionID[25:21]);
    assign forwardWB_ID2=RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==instructionID[20:16]);

    assign readdata1ID=forwardWB_ID1? regwritedataWB:regreaddata1;
    assign readdata2ID=forwardWB_ID2? regwritedataWB:regreaddata2;//WB_ID forwarding

endmodule