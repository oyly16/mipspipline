
module RegisterFile(reset,clk,RegWriteWB,readaddr1,readaddr2,regwriteaddrWB,regwritedataWB,
	readdata1,readdata2);
	input reset,clk;
	input RegWriteWB;
	input [4:0] readaddr1,readaddr2,regwriteaddrWB;
	input [31:0] regwritedataWB;
	output [31:0] readdata1,readdata2;
	
	reg [31:0] RF_data[31:1];
	
	assign readdata1 = (readaddr1 == 5'b00000)? 32'h00000000: RF_data[readaddr1];
	assign readdata2 = (readaddr2 == 5'b00000)? 32'h00000000: RF_data[readaddr2];
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 1; i < 32; i = i + 1)
				RF_data[i] <= 32'h00000000;
		else if (RegWriteWB && (regwriteaddrWB != 5'b00000))
			RF_data[regwriteaddrWB] <= regwritedataWB;

endmodule
			