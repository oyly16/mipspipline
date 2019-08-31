module IF_ID(clk,reset,intterupt,PCIF,PCplus4IF,instructionIF,PCID,PCplus4ID,instructionID);

    input clk,reset,intterupt;
    input [31:0] PCplus4IF,PCIF;
    input [31:0] instructionIF;
    output reg [31:0] PCplus4ID,PCID;
    output reg [31:0] instructionID;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            PCplus4ID<=0;
            PCID<=0;
            instructionID<=0;
        end
        else begin
            PCplus4ID<=PCplus4IF;
            PCID<=PCIF;
            instructionID<=instructionIF;
        end
    end

endmodule