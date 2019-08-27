module test_cpu();
	
	reg reset;
	reg clk;
	reg intterupt;
	
	CPU cpu1(reset, clk, intterupt);
	
	initial begin
		reset = 1;
		clk = 1;
		intterupt=0;
		#100 reset = 0;
	end
	
	always #50 clk = ~clk;
		
endmodule
