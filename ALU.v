
module ALU(in1, in2, ALUCt, Sign, out, zero,shamt);
	input [31:0] in1, in2;
	input [4:0] ALUCt,shamt;
	input Sign;
	output reg [31:0] out;
	output zero;
	
	assign zero = (out == 0);
	
	wire ss;
	assign ss = {in1[31], in2[31]};
	
	wire lt_31;
	assign lt_31 = (in1[30:0] < in2[30:0]);
	
	wire lt_signed;
	assign lt_signed = (in1[31] ^ in2[31])? 
		((ss == 2'b01)? 0: 1): lt_31;
	
	always @(*)
		case (ALUCt)
			5'b00000: out <= in1 & in2;
			5'b00001: out <= in1 | in2;
			5'b00010: out <= in1 + in2;
			5'b00110: out <= in1 - in2;
			5'b00111: out <= {31'h00000000, Sign? lt_signed: (in1 < in2)};
			5'b01100: out <= ~(in1 | in2);
			5'b01101: out <= in1 ^ in2;
			5'b10000: out <= (in2 << shamt);
			5'b11000: out <= (in2 >> shamt);
			5'b11001: out <= ({{32{in2[31]}}, in2} >> shamt);
			5'b11010: out <= {in2[15:0],16'b0};
			default: out <= 32'h00000000;
		endcase
	
endmodule