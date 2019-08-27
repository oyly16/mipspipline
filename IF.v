module IF(clk,reset,intterupt,stall,
    PCSrcMEM,branchaddrMEM,instructionIF,PCplus4IF,
    instructionID);

    input clk,reset,intterupt,stall;
    input PCSrcMEM;
    input [31:0] branchaddrMEM;
    input [31:0] instructionID;//stall
    output [31:0] instructionIF;
    output [31:0] PCplus4IF;

    reg [31:0] PC;
    wire [31:0] PCnext;

    assign PCplus4IF=PC+32'd4;
    assign PCnext=
        (stall==1)? PC:
        (PCSrcMEM==0)? PCplus4IF:
        (PCSrcMEM==1)? branchaddrMEM:32'd0;

    always @(posedge clk or posedge reset) 
    begin
        if (reset) begin
            PC<=0;
        end
        else begin
            PC<=PCnext;
        end
    end

    wire [31:0] instructionPC;
    InstructionMemory InstructionMemory(.Address(PC),.Instruction(instructionPC));
    //assign instructionIF=instructionPC;
    assign instructionIF=stall? instructionID:instructionPC;
endmodule