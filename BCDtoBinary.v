module BCDtoBinary(
	input[11:0] numberIn,
	input sign,
	output reg[11:0] numberOut
);
//The bcd to binary converter will take the BCD number form from the input and convert it to a binary number that can be used in the ALU.
//It will take each BCD individually, and multiply it by its placeholder value (e.g hundreds, tens, ones). It will then add these 3 values together to get the binary equivalent.
reg[11:0] hundreds, tens, ones, temp;

always @ (numberIn) begin

	hundreds = numberIn[11:8] * 8'b01100100;
	tens = numberIn[7:4] * 4'b1010;
	ones = numberIn[3:0];

	temp = hundreds + tens + ones;
	
	//If the number is negative, then convert it into two's complement notation to use in the ALU.
	if(sign) begin
		numberOut = ~temp + 1'b1;
	end else begin
		numberOut = temp;
	end

end
endmodule 