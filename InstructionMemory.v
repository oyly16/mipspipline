
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0: Instruction<=32'h00002820;
			8'd1: Instruction<=32'h20040014;
			8'd2: Instruction<=32'haca40000;
			8'd3: Instruction<=32'h20a50004;
			8'd4: Instruction<=32'h20040010;
			8'd5: Instruction<=32'haca40000;
			8'd6: Instruction<=32'h20a50004;
			8'd7: Instruction<=32'h20040013;
			8'd8: Instruction<=32'haca40000;
			8'd9: Instruction<=32'h20a50004;
			8'd10: Instruction<=32'h20040006;
			8'd11: Instruction<=32'haca40000;
			8'd12: Instruction<=32'h20a50004;
			8'd13: Instruction<=32'h20040002;
			8'd14: Instruction<=32'haca40000;
			8'd15: Instruction<=32'h20040004;
			8'd16: Instruction<=32'h20050000;
			8'd17: Instruction<=32'h20100001;
			8'd18: Instruction<=32'h0090082a;
			8'd19: Instruction<=32'h1420000d;
			8'd20: Instruction<=32'h2211ffff;
			8'd21: Instruction<=32'h0220082a;
			8'd22: Instruction<=32'h14200008;
			8'd23: Instruction<=32'h00114080;
			8'd24: Instruction<=32'h00a84020;
			8'd25: Instruction<=32'h8d090000;
			8'd26: Instruction<=32'h8d0a0004;
			8'd27: Instruction<=32'h0149082a;
			8'd28: Instruction<=32'h14200005;
			8'd29: Instruction<=32'h2231ffff;
			8'd30: Instruction<=32'h08100015;
			8'd31: Instruction<=32'h22100001;
			8'd32: Instruction<=32'h08100012;
			8'd33: Instruction<=32'h08100021;
			8'd34: Instruction<=32'h00114880;
			8'd35: Instruction<=32'h00a94820;
			8'd36: Instruction<=32'h8d280000;
			8'd37: Instruction<=32'h8d2a0004;
			8'd38: Instruction<=32'had2a0000;
			8'd39: Instruction<=32'had280004;
			8'd40: Instruction<=32'h0810001d;
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule