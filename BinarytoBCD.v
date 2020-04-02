module BinarytoBCD(
	input[19:0] numberInput,
	
	output reg[3:0] hundredThousands,
	output reg[3:0] tenThousands,
	output reg[3:0] thousands,
	output reg[3:0] hundreds,
	output reg[3:0] tens,
	output reg[3:0] ones
);
//This module will convert the binary output of the ALU back to BCD that can be used on the displays. The module makes use of the Double Dabble algorithm.
integer i;

always @ (numberInput) begin
	hundredThousands = 4'b0000;
	tenThousands = 4'b0000;
	thousands = 4'b0000;
	hundreds = 4'b0000;
	tens = 4'b0000;
	ones = 4'b0000;
	
	//It uses a for loop to loop through every value of the binary number. It will bit shift to the left the binary number, effectively moving the bits into the BCD registers.
	//When the value of nay of the BCD registers is greater than 4, the value of 3 will be added to the register, which will carry it into the next BCD register.
	for (i = 19; i >= 0; i = i-1) begin
		if(hundredThousands >= 5) begin
			hundredThousands = hundredThousands + 4'd3;
		end 
		if(tenThousands >= 5) begin
			tenThousands = tenThousands + 4'd3;
		end
		if(thousands >= 5) begin
			thousands = thousands + 4'd3;
		end
		if(hundreds >= 5) begin
			hundreds = hundreds + 4'd3;
		end
		if(tens >= 5) begin
			tens = tens + 4'd3;
		end
		if(ones >= 5) begin
			ones = ones + 4'd3;
		end
		
		
		hundredThousands = hundredThousands << 1;
		hundredThousands[0] = tenThousands[3];
		tenThousands = tenThousands << 1;
		tenThousands[0] = thousands[3];
		thousands = thousands << 1;
		thousands[0] = hundreds[3];
		hundreds	= hundreds << 1;
		hundreds[0] = tens[3];
		tens = tens << 1;
		tens[0] = ones[3];
		ones = ones << 1;
		ones[0] = numberInput[i];
		end
		
end


endmodule
