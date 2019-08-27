
module Control(OpCode,Funct,stall,
	BranchID,JumpID,RegWriteID,RegDstID,MemReadID,MemWriteID,MemtoRegID,ALUSrcID,ExtOpID,ALUOpID);

	input [5:0] OpCode;
	input [5:0] Funct;
	input stall;
	//output [1:0] PCSrc;
	output BranchID,JumpID,RegWriteID,MemReadID,MemWriteID,MemtoRegID,ALUSrcID,ExtOpID;
	output [1:0] RegDstID;
	output [3:0] ALUOpID;
	
	assign ALUOpID[2:0] = 
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0d)? 3'b011:
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101:3'b000;
		
	assign ALUOpID[3] = OpCode[0];

	assign BranchID=
		(OpCode == 6'h04 || OpCode==6'h05 || OpCode==6'h06 || OpCode==6'h07)? 1:0;

	assign JumpID=
		(OpCode==6'h02 || OpCode==6'h03 || (OpCode==6'h00 & Funct==6'h08) || (OpCode==6'h00 & Funct==6'h09))?1:0;//j,jal,jr,jalr

	assign RegWriteID=
		(stall)? 0:
		(OpCode == 6'h2b || OpCode == 6'h04 || OpCode == 6'h05 || OpCode==6'h06 || OpCode==6'h07 ||
		 OpCode == 6'h02 || (OpCode == 6'h00 & Funct == 6'h08))? 0:1;//sw,beq,bne,blez,bgtz,j,jr
	
	assign RegDstID=
		(OpCode == 6'h23 || OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h0c || OpCode == 6'h0b || OpCode == 6'h0a)? 2'b00:
		(OpCode == 6'h03)? 2'b10:2'b01;

	assign MemReadID=
		(OpCode == 6'h23)? 1:0;

	assign MemWriteID=
		(stall)? 0:
		(OpCode == 6'h2b)? 1:0;

	assign MemtoRegID=
		(OpCode == 6'h23)? 2'b01:
		(OpCode == 6'h03 || (OpCode == 6'h00 & Funct == 6'h09))? 2'b10:2'b00;

	assign ALUSrcID=
		(OpCode == 6'h23 || OpCode == 6'h2b || OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h0c || OpCode == 6'h0a || OpCode == 6'h0b)? 1:0;

	assign ExtOpID=
		(OpCode == 6'h0c)? 0:1;
	
endmodule