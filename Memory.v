module Memory(
	input[1:0] validCount,
	input valid,
	input operand,
	input[3:0] digit,
	input Clock_1ms,
	
	output reg[2:0] memoryState,
	output reg[3:0] operandMemory,
	output reg[11:0] number1Memory,
	output reg[11:0] number2Memory,
	output reg memory
);
 //reg memory;
 initial memory = 0;
 wire validHigh;
positiveEdgeDetection validEdgeDetect(valid, Clock_1ms, validHigh);
 
always @ (posedge Clock_1ms) begin
//=====================================================================//
//Number 1
if(validHigh) begin
	if (memory == 0) begin
/*
	memoryState = 3'b001;
	case(validCount)
	
		2'b00: number1Memory = 12'b000000000000;
		
		2'b01: number1Memory[3:0] = digit;
		
		2'b10: begin
			number1Memory[7:4] = number1Memory[3:0];
			number1Memory[3:0] = digit;
		end
		
		2'b11: begin
			number1Memory[11:8] = number1Memory[7:4];
			number1Memory[7:4] = number1Memory[3:0];
			number1Memory[3:0] = digit;
		end
		
		default : number1Memory = 12'b000000000000;
		
		endcase
*/
			number1Memory[11:8] = number1Memory[7:4];
			number1Memory[7:4] = number1Memory[3:0];
			number1Memory[3:0] = digit;

			
	end

//=====================================================================//
//operand
	if(operand) begin
		memoryState = 3'b010;
		operandMemory = digit;
		memory = 1;
	
	end



//=====================================================================//
// Number 2

	if (memory == 1) begin
		memoryState = 3'b100;
		case(validCount)
	
			2'b00: number2Memory = 12'b000000000000;
		
			2'b01: number2Memory[3:0] = digit;
			
			2'b10: begin
				number2Memory[7:4] = number2Memory[3:0];
				number2Memory[3:0] = digit;
			end
			
			2'b11: begin
				number2Memory[11:8] = number2Memory[7:4];
				number2Memory[7:4] = number2Memory[3:0];
				number2Memory[3:0] = digit;
			end
		
			default : number2Memory = 12'b000000000000;
		
			endcase
		

	end
//=====================================================================//
end
end
endmodule
