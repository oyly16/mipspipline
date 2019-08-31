
module DataMemory(reset, clk, Address, Write_data, Read_data, MemRead, MemWrite, 
	interrupt,leds,digi,check);
	input reset, clk, check;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output interrupt;
	output [7:0] leds;
	output [11:0] digi;
	
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	wire [31:0] ramreaddata,preaddata;
	assign ramreaddata = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 0; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		else if (MemWrite & Address[30]==0)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;

	peripherals peripherals(.clk(clk),.reset(reset),.interrupt(interrupt),.Read(MemRead),.Write(MemWrite),
		.addr(Address),.rdata(preaddata),.wdata(Write_data),.leds(leds),.digi(digi),.check(check));

	assign Read_data=Address[30]? preaddata:ramreaddata;
			
endmodule
