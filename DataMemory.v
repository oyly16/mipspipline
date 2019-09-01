
module DataMemory(reset, clk, Address, Write_data, Read_data, MemRead, MemWrite, showaddr,ramshowdata,
	interrupt,leds,digi,check);
	input reset, clk, check;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	input [6:0] showaddr;
	output [31:0] Read_data;
	output interrupt;
	output [7:0] leds;
	output [11:0] digi;
	output [31:0] ramshowdata;
	
	parameter RAM_SIZE = 128;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	wire [31:0] ramreaddata,preaddata;
	assign ramreaddata = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	assign ramshowdata=RAM_data[showaddr];

	always @(posedge reset or posedge clk)
		if (reset) begin
			RAM_data[0]<=32'd92;
            RAM_data[1]<=32'd54;
            RAM_data[2]<=32'd51;
            RAM_data[3]<=32'd27;
            RAM_data[4]<=32'd145;
            RAM_data[5]<=32'd122;
            RAM_data[6]<=32'd151;
            RAM_data[7]<=32'd92;
            RAM_data[8]<=32'd93;
            RAM_data[9]<=32'd94;
            RAM_data[10]<=32'd33;
            RAM_data[11]<=32'd55;
            RAM_data[12]<=32'd113;
            RAM_data[13]<=32'd114;
            RAM_data[14]<=32'd43;
            RAM_data[15]<=32'd190;
            RAM_data[16]<=32'd61;
            RAM_data[17]<=32'd32;
            RAM_data[18]<=32'd171;
            RAM_data[19]<=32'd199;
            RAM_data[20]<=32'd74;
            RAM_data[21]<=32'd150;
            RAM_data[22]<=32'd133;
            RAM_data[23]<=32'd90;
            RAM_data[24]<=32'd61;
            RAM_data[25]<=32'd173;
            RAM_data[26]<=32'd67;
            RAM_data[27]<=32'd163;
            RAM_data[28]<=32'd88;
            RAM_data[29]<=32'd136;
            RAM_data[30]<=32'd142;
            RAM_data[31]<=32'd183;
            RAM_data[32]<=32'd148;
            RAM_data[33]<=32'd44;
            RAM_data[34]<=32'd188;
            RAM_data[35]<=32'd152;
            RAM_data[36]<=32'd67;
            RAM_data[37]<=32'd168;
            RAM_data[38]<=32'd129;
            RAM_data[39]<=32'd190;
            RAM_data[40]<=32'd156;
            RAM_data[41]<=32'd89;
            RAM_data[42]<=32'd102;
            RAM_data[43]<=32'd160;
            RAM_data[44]<=32'd10;
            RAM_data[45]<=32'd199;
            RAM_data[46]<=32'd3;
            RAM_data[47]<=32'd89;
            RAM_data[48]<=32'd5;
            RAM_data[49]<=32'd65;
            RAM_data[50]<=32'd74;
            RAM_data[51]<=32'd125;
            RAM_data[52]<=32'd160;
            RAM_data[53]<=32'd139;
            RAM_data[54]<=32'd94;
            RAM_data[55]<=32'd67;
            RAM_data[56]<=32'd76;
            RAM_data[57]<=32'd98;
            RAM_data[58]<=32'd145;
            RAM_data[59]<=32'd186;
            RAM_data[60]<=32'd149;
            RAM_data[61]<=32'd182;
            RAM_data[62]<=32'd186;
            RAM_data[63]<=32'd52;
            RAM_data[64]<=32'd133;
            RAM_data[65]<=32'd97;
            RAM_data[66]<=32'd149;
            RAM_data[67]<=32'd52;
            RAM_data[68]<=32'd126;
            RAM_data[69]<=32'd104;
            RAM_data[70]<=32'd101;
            RAM_data[71]<=32'd23;
            RAM_data[72]<=32'd171;
            RAM_data[73]<=32'd21;
            RAM_data[74]<=32'd181;
            RAM_data[75]<=32'd42;
            RAM_data[76]<=32'd123;
            RAM_data[77]<=32'd92;
            RAM_data[78]<=32'd56;
            RAM_data[79]<=32'd188;
            RAM_data[80]<=32'd59;
            RAM_data[81]<=32'd41;
            RAM_data[82]<=32'd77;
            RAM_data[83]<=32'd43;
            RAM_data[84]<=32'd182;
            RAM_data[85]<=32'd176;
            RAM_data[86]<=32'd171;
            RAM_data[87]<=32'd180;
            RAM_data[88]<=32'd124;
            RAM_data[89]<=32'd19;
            RAM_data[90]<=32'd60;
            RAM_data[91]<=32'd10;
            RAM_data[92]<=32'd98;
            RAM_data[93]<=32'd66;
            RAM_data[94]<=32'd94;
            RAM_data[95]<=32'd55;
            RAM_data[96]<=32'd66;
            RAM_data[97]<=32'd142;
            RAM_data[98]<=32'd117;
            RAM_data[99]<=32'd4;
        end
		else if (MemWrite & Address[30]==0)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;

	peripherals peripherals(.clk(clk),.reset(reset),.interrupt(interrupt),.Read(MemRead),.Write(MemWrite),
		.addr(Address),.rdata(preaddata),.wdata(Write_data),.leds(leds),.digi(digi),.check(check));

	assign Read_data=Address[30]? preaddata:ramreaddata;
			
endmodule
