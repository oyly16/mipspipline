module MEM(clk,reset,intterupt,
    memaddrMEM,memwritedataMEM,check,
    ALUequalMEM,MemWriteMEM,MemReadMEM,
    memreaddataMEM,leds,digi,showaddr,ramshowdata);

    input clk,reset,check;
    input [31:0] memaddrMEM,memwritedataMEM;
    input ALUequalMEM,MemWriteMEM,MemReadMEM;
    input [6:0] showaddr;
    output intterupt;
    output [31:0] memreaddataMEM,ramshowdata;
    output [7:0] leds;
    output [11:0] digi;
    
    DataMemory DataMemory(.reset(reset),.clk(clk),.interrupt(intterupt),.Address(memaddrMEM),.Write_data(memwritedataMEM),.Read_data(memreaddataMEM),
        .MemRead(MemReadMEM),.MemWrite(MemWriteMEM),.leds(leds),.digi(digi),.check(check),.showaddr(showaddr),.ramshowdata(ramshowdata));

endmodule