module IF_ID(clk,reset,intterupt,PCplus4IF,instructionIF,PCplus4ID,instructionID);

    input clk,reset,intterupt;
    input [31:0] PCplus4IF;
    input [31:0] instructionIF;
    output reg [31:0] PCplus4ID;
    output reg [31:0] instructionID;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            PCplus4ID<=0;
            instructionID<=0;
        end
        else begin
            PCplus4ID<=PCplus4IF;
            instructionID<=instructionIF;
        end
    end

endmodule