module StallFlush(clk,reset,intterupt,
    MemReadEX,rtaddrEX,rtaddrID,rsaddrID,PCSrcID,BranchID,regwriteaddrEX,
    ,stall,flush);

    input clk,reset,intterupt;
    input MemReadEX,BranchID;
    input [4:0] regwriteaddrEX,rtaddrEX,rsaddrID,rtaddrID;
    input [2:0] PCSrcID;
    output stall,flush;

    assign stall=(MemReadEX & (rtaddrEX!=0) & ((rtaddrEX==rsaddrID) | (rtaddrEX==rtaddrID)))
    | (BranchID & (regwriteaddrEX!=0) & (regwriteaddrEX==rsaddrID | regwriteaddrEX==rtaddrID));
    assign flush=(stall!=1) & (PCSrcID!=0);

endmodule