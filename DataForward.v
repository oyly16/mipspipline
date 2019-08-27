module DataForward(clk,reset,intterupt,
    readdata1,readdata2,
    regwritedataWB,ALUoutMEM,
    regwriteaddrWB,regwriteaddrMEM,rsaddr,rtaddr,
    RegWriteWB,RegWriteMEM,
    forwardout1,forwardout2);

    input clk,reset,intterupt;
    input [31:0] readdata1,readdata2,regwritedataWB,ALUoutMEM;
    input [4:0] regwriteaddrWB,regwriteaddrMEM,rsaddr,rtaddr;
    input RegWriteWB,RegWriteMEM;
    output [31:0] forwardout1,forwardout2;

    wire [1:0] Forward1,Forward2;//00 choose readdata,01 choose ALUoutMEM,10 choose regwritedataWB
    assign Forward1=(RegWriteMEM & (regwriteaddrMEM!=0) & (regwriteaddrMEM==rsaddr))? 2'b01:
        (RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==rsaddr))? 2'b10:2'b00;
    assign Forward2=(RegWriteMEM & (regwriteaddrMEM!=0) & (regwriteaddrMEM==rtaddr))? 2'b01:
        (RegWriteWB & (regwriteaddrWB!=0) & (regwriteaddrWB==rtaddr))? 2'b10:2'b00;

    assign forwardout1=(Forward1==2'b01)? ALUoutMEM:(Forward1==2'b10)? regwritedataWB:readdata1;
    assign forwardout2=(Forward2==2'b01)? ALUoutMEM:(Forward2==2'b10)? regwritedataWB:readdata2;

endmodule