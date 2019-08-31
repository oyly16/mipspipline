module peripherals(clk,reset,Read,Write,addr,wdata,interrupt,rdata,leds,digi,check);
    input clk,reset,check;
    input Read,Write;
    input [31:0] addr,wdata;
    output interrupt;
    output reg [31:0] rdata;
    output reg [7:0] leds;
    output reg [11:0] digi;

    reg [31:0] TH,TL,systick;
    reg [2:0] TCON;
    
    assign interrupt=TCON[2] & check==0;

    always@(*) begin
        if (Read) begin
            case (addr)
                32'h40000000: rdata<=TH;
                32'h40000004: rdata<=TL;
                32'h40000008: rdata<={29'b0,TCON};
                32'h4000000c: rdata<={24'b0,leds};
                32'h40000010: rdata<={20'b0,digi};
                32'h40000014: rdata<=systick; 
                default: rdata<=32'b0;
            endcase
        end
        else rdata<=32'b0;
    end

    always@(posedge reset or posedge clk) begin
        if (reset) begin
            TH<=0;
            TL<=0;
            TCON<=0;
            leds<=0;
            systick<=0;
            digi<=0;
        end
        else begin
            systick<=systick+1;
            if (TCON[0]) begin
                if (TL==32'hffffffff) begin
                    TL<=TH;
                    if (TCON[1]) TCON[2]<=1'b1;
                end
                else TL<=TL+1;
            end
            if (Write) begin
                case(addr)
                    32'h40000000: TH<=wdata;
                    32'h40000004: TL<=wdata;
                    32'h40000008: TCON<=wdata[2:0];
                    32'h4000000c: leds<=wdata[7:0];
                    32'h40000010: digi<=wdata[11:0];
                    32'h40000014: systick<=wdata;
                endcase
            end
            else begin
                systick<=systick+1;
            end 
        end
    end

endmodule