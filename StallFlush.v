module StallFlush(clk,reset,intterupt,
    MemReadEX,rtaddrEX,rtaddrID,rsaddrID,PCSrcID,BranchID,JRID,regwriteaddrEX,
    MemReadMEM,regwriteaddrMEM,MemtoRegMEM,RegWriteEX,
    ,stall,flush);

    input clk,reset,intterupt;
    input MemReadEX,BranchID,JRID,MemReadMEM,RegWriteEX;
    input [4:0] regwriteaddrEX,rtaddrEX,rsaddrID,rtaddrID,regwriteaddrMEM;
    input [2:0] PCSrcID;
    input [1:0] MemtoRegMEM;
    output stall,flush;

    assign stall=(MemReadEX & (rtaddrEX!=0) & ((rtaddrEX==rsaddrID) | (rtaddrEX==rtaddrID)))//load-use
    | (BranchID & RegWriteEX & (regwriteaddrEX!=0) & (regwriteaddrEX==rsaddrID | regwriteaddrEX==rtaddrID))//R and beq
    | (BranchID & MemReadMEM & (regwriteaddrMEM!=0) & ((regwriteaddrMEM==rsaddrID) | (regwriteaddrMEM==rtaddrID)))//lw and beq
    | (BranchID & (MemtoRegMEM==2'b10) & (rsaddrID==5'b11111 | rtaddrID==5'b11111))//jal and beq
    | (BranchID & (MemtoRegMEM==2'b11) & (rsaddrID==5'b11010 | rtaddrID==5'b11010))//$26 and beq
    | (JRID & RegWriteEX & (regwriteaddrEX!=0) & (regwriteaddrEX==rsaddrID))//R and jr
    | (JRID & MemReadMEM & (regwriteaddrMEM!=0) & (regwriteaddrMEM==rsaddrID))//lw and jr
    | (JRID & (MemtoRegMEM==2'b10) & rsaddrID==5'b11111)//jal and jr
    | (JRID & (MemtoRegMEM==2'b11) & rsaddrID==5'b11010);//$26 and jr

    assign flush=(stall!=1) & (PCSrcID!=0);

endmodule