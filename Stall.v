module Stall(clk,reset,intterupt,
    MemReadEX,rtaddrEX,rtaddrID,rsaddrID,stall);

    input clk,reset,intterupt;
    input MemReadEX;
    input [4:0] rtaddrEX,rsaddrID,rtaddrID;
    output stall;

    assign stall=MemReadEX & ((rtaddrEX==rsaddrID) | (rtaddrEX==rtaddrID));

endmodule