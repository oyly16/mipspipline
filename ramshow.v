module ramshow(sysclk,ramdata,AN,digi);
    input sysclk;
    input [31:0] ramdata;
    output reg [3:0] AN;
    output reg [7:0] digi;
    
    reg showclk;
    reg [16:0] state;
    always@(posedge sysclk) begin
        if(state==0) showclk=~showclk;
        state=state+17'd2;
        if(state>=17'd100000) state=0;
    end
    
    reg [1:0] stateshow;
    reg [3:0] numshow;
    always@(posedge showclk)begin
        case(stateshow)
            2'b00:begin
                AN=4'b0001;
                numshow=ramdata[3:0];end
            2'b01:begin
                AN=4'b0010;
                numshow=ramdata[7:4];end
            2'b10:begin
                AN=4'b0100;
                numshow=ramdata[11:8];end
            2'b11:begin
                AN=4'b1000;
                numshow=ramdata[15:12];end
        endcase
        digi=(numshow==4'h0)?8'b00111111:
             (numshow==4'h1)?8'b00000110:
             (numshow==4'h2)?8'b01011011:
             (numshow==4'h3)?8'b01001111:
             (numshow==4'h4)?8'b01100110:
             (numshow==4'h5)?8'b01101101:
             (numshow==4'h6)?8'b01111101:
             (numshow==4'h7)?8'b00000111:
             (numshow==4'h8)?8'b01111111:
             (numshow==4'h9)?8'b01101111:
             (numshow==4'ha)?8'b01110111:
             (numshow==4'hb)?8'b01111100:
             (numshow==4'hc)?8'b00111001:
             (numshow==4'hd)?8'b01011110:
             (numshow==4'he)?8'b01111001:
             (numshow==4'hf)?8'b01110001:8'b0;
        if(stateshow==2'b11) stateshow=2'b00;
        else stateshow=stateshow+1;
    end
endmodule
