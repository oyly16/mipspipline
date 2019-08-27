module DataForward(clk,reset,intterupt,
    readdata1EX,readdata2EX,regwritedataWB,ALUoutMEM,
    regwriteaddrWB,regwriteaddrMEM,rsaddrEX,rtaddrEX,rdaddrEX,
    RegWriteWB,RegWriteMEM,
    forwardout1EX,forwardout2EX);

    input clk,reset,intterupt;
    input [31:0] readdata1EX,readdata2EX,regwritedataWB,ALUoutMEM;
    input [4:0] regwriteaddrWB,regwriteaddrMEM,rsaddrEX,rtaddrEX,rdaddrEX;
    input RegWriteWB,RegWriteMEM;
    output [31:0] forwardout1EX,forwardout2EX;

    wire [1:0] Forward1,Forward2;//00 choose readdata,01 choose ALUoutMEM,10 choose regwritedataWB
    assign Forward1=(RegWriteMEM & (regwriteaddrMEM!=0) & (regwriteaddrMEM==rsaddrEX))? 2'b01:
        (RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==rsaddrEX))? 2'b10:2'b00;
    assign Forward2=(RegWriteMEM & (regwriteaddrMEM!=0) & (regwriteaddrMEM==rtaddrEX))? 2'b01:
        (RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==rtaddrEX))? 2'b10:2'b00;

    assign forwardout1EX=(Forward1==2'b01)? ALUoutMEM:(Forward1==2'b10)? regwritedataWB:readdata1EX;
    assign forwardout2EX=(Forward2==2'b01)? ALUoutMEM:(Forward2==2'b10)? regwritedataWB:readdata2EX;

endmodule