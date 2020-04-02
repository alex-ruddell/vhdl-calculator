module ALU( 
	input[2:0] state,
	input clock,
	input[11:0] number0,
	input[11:0] number1,
	input[3:0] operator,
	input ALUenable,
	input equals,
	input reset,
	
	input firstSign,
	input secondSign,

	output reg[19:0] outputNumber, 
	output reg[19:0] remainder,
	output reg signOut
	
);
//**********		Divide = C	 , 	Multiply = D	,    	Subtract = E  , 	Add = F **//
parameter[3:0] Divide = 4'b1100, Multiply = 4'b1101, Subtract = 4'b1110, Add = 4'b1111;

wire[11:0] binaryeq0, binaryeq1;
wire[20:0] tempNumber0, tempNumber1;
reg[20:0] tempNumber2, multiplicationOut;
wire[8:0] concatenateValue1, concatenateValue2;

reg[20:0] runningDividend;
initial runningDividend = tempNumber0;

initial multiplicationOut = 21'b0;

reg[9:0] count, divideCount;
initial count = 10'b0;
initial divideCount = 10'b0;

//Use the converter to get the binary equivalent of the input values.
BCDtoBinary bcd1Converter(.numberIn(number0), .sign(firstSign), .numberOut(binaryeq0));
BCDtoBinary bcd2Converter(.numberIn(number1), .sign(secondSign), .numberOut(binaryeq1));

//Need to make the numbers bigger to allow for overflow. There is a max value of 998,001 which is 20bits. Due to using two's compliment, either need to concatenate with 
//ones or zeros depending on the sign of the number.
assign concatenateValue1 = firstSign ? 9'b111111111 : 9'b000000000;
assign concatenateValue2 = secondSign ? 9'b111111111 : 9'b000000000;

//Create the two bigger numbers through concatenation.
assign tempNumber0 = {concatenateValue1, binaryeq0};
assign tempNumber1 = {concatenateValue2, binaryeq1};

always @ (posedge clock) begin

	if(reset) begin
		count = 10'b0;
		multiplicationOut = 21'b0;
		tempNumber2 = 21'b0;
		outputNumber = 20'b0;
		remainder = 21'b0;
		divideCount = 10'b0;
	end else begin
	
		if(equals) begin
			runningDividend = tempNumber0;
		end
			
		if (state == 3'b100 && ALUenable) begin	// only trigger the ALU once in state four of fsm...
			
			case (operator)
				
				Add: begin
					//The add function will add the two two's compliment numbers together

						tempNumber2 = tempNumber0 + tempNumber1;
						//The sign of the output number will be the MSB of the output. 
						signOut = tempNumber2[20];
						
						//Depending on the sign, the number may need to be converted out of two's compliment to allow it to be correctly decoded to the display.
						if(signOut) begin
							outputNumber = ~tempNumber2[19:0] + 1'b1;
						end else begin
							outputNumber = tempNumber2[19:0];
						end
					
				end
				
				Subtract: begin
					//This will perform the minus operation, and again convert out of two's compliment depending on the sign of the output. 
					tempNumber2 = tempNumber0 - tempNumber1;
					signOut = tempNumber2[20];
					if(signOut) begin
						outputNumber = ~tempNumber2[19:0] + 1'b1;
					end else begin
						outputNumber = tempNumber2[19:0];
					end
					
				end
				
				Multiply: begin
					//The multiplication function makes use of repeated addition. A x B, the module will simply add A to itself B times.
						//Case for if both numbers are negative. Need to change around the order of addition
						if(firstSign && secondSign) begin 
							if(count < -tempNumber1) begin
								multiplicationOut = multiplicationOut - tempNumber0;
								count = count + 1;
							end
						end else begin
						
							//Cases for if only one of the signs is negative, once again need to change the order of the addition. 
							if(firstSign) begin
								if(count < tempNumber1) begin
									multiplicationOut = multiplicationOut + tempNumber0;
									count = count + 1;
								end
							end else begin
								if(count < tempNumber0) begin
									multiplicationOut = multiplicationOut + tempNumber1;
									count = count + 1;
								end
							end
						end
						
						//Convert out of two's compliment depending on the sign of the output. 
						signOut = multiplicationOut[20];
						if(signOut) begin
							outputNumber = ~multiplicationOut[19:0] + 1'b1;
						end else begin
							outputNumber = multiplicationOut[19:0];
						end
				end
				
				Divide: begin
					
					if(tempNumber1 == 0) begin
						divideCount = 0;
						
					end else begin
						if(firstSign || secondSign) begin
						signOut = 1;
							if(firstSign) begin
								if(-runningDividend >= tempNumber1) begin
									runningDividend = runningDividend + tempNumber1;
									divideCount = divideCount + 1;
								end else begin
									remainder = -runningDividend;
								end
							end else begin
								if(runningDividend >= -tempNumber1) begin
									runningDividend = runningDividend + tempNumber1;
									divideCount = divideCount + 1;
								end else begin
									remainder = runningDividend;
								end
							end
						end else begin
							if(runningDividend >= tempNumber1) begin
								runningDividend = runningDividend - tempNumber1;
								divideCount = divideCount + 1;
							end else begin
								remainder = runningDividend;
							end
						end
					end

					outputNumber = divideCount;
				end
			
			endcase
		end
	end
end

endmodule 