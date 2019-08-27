module Compare(forwardout1ID,forwardout2ID,OpCode,compare);

    input [31:0] forwardout1ID,forwardout2ID;
    input [5:0] OpCode;
    output compare;

    wire [31:0] diff;
    assign diff=forwardout1ID-forwardout2ID;

    assign compare=
        (OpCode==6'h4 & diff==0) | (OpCode==6'h5 & diff!=0) | (OpCode==6'h6 & forwardout1ID<=0) | (OpCode==6'h7 & forwardout1ID>0);

endmodule