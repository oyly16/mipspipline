
module InstructionMemoryT(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])//pay attention to j,jal, in MARS the PC begin at 0x00400000 but in our CPU it's 0x0

			8'd0: Instruction<=32'h20040000;//addi $a0,$0,0
			8'd1: Instruction<=32'h20040000;//addi $a0,$0,0
			8'd2: Instruction<=32'h20050003;//addi $a1,$0,3
			8'd3: Instruction<=32'hac850000;
			8'd4: Instruction<=32'h8c860000;
			8'd5: Instruction<=32'h20c70001;
			8'd6: Instruction<=32'h10e60001;
			8'd7: Instruction<=32'h21080001;
			8'd8: Instruction<=32'h8c870000;
			8'd9: Instruction<=32'h10e60001;
			8'd10: Instruction<=32'h21290001;
			8'd11: Instruction<=32'h0c00000c;
			8'd12: Instruction<=32'h14bf0006;
			8'd13: Instruction<=32'h214a0001;
			8'd14: Instruction<=32'h10a60006;
			8'd15: Instruction<=32'h216b0001;
			8'd16: Instruction<=32'hac850000;
			8'd17: Instruction<=32'h8c860000;
			8'd18: Instruction<=32'h00c00008;
			8'd19: Instruction<=32'h23e50000;
			8'd20: Instruction<=32'h00a00008;
			8'd21: Instruction<=32'h0c000018;
			8'd22: Instruction<=32'h218c0001;
			8'd23: Instruction<=32'h08000017;
			8'd24: Instruction<=32'h03e00008;
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule