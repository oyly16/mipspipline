
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0: Instruction<=32'h20050004;
			8'd1: Instruction<=32'hac050004;
			8'd2: Instruction<=32'h8c060004;
			8'd3: Instruction<=32'h00a63022;
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule