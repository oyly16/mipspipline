module IF(clk,reset,intterupt,stall,flush,exception,
    PCSrcID,branchaddrID,jumpaddrID,instructionIF,
    PCIF,PCplus4IF,instructionID);

    input clk,reset,intterupt,stall,flush,exception;
    input [2:0] PCSrcID;
    input [31:0] branchaddrID,jumpaddrID;
    input [31:0] instructionID;//stall
    output [31:0] instructionIF;
    output [31:0] PCplus4IF,PCIF;

    reg [31:0] PC;
    wire [31:0] PCnext;
    assign PCIF=flush? PC-32'd4:PC;

    assign PCplus4IF=(stall)?PC:PC+32'd4;
    assign PCnext=
        (PCSrcID==3)? 32'h80000004:
        (PCSrcID==4)? 32'h80000008:
        (stall)? PC:
        (PCSrcID==1)? branchaddrID:
        (PCSrcID==2)? jumpaddrID:
        (PCSrcID==0)? PCplus4IF:32'd0;

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
    assign instructionIF=flush? 32'b0: stall? instructionID: instructionPC;
endmodule