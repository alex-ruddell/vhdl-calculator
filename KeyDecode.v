module KeyDecode(
	input[3:0] Column,
	input[3:0] row, 
	input keypadValid, 
	input validHigh,
	input Clock_10ms,
	
	input[1:0] buttonPressed, // Gives the number of button pressed, e.g. form PB0 to PB3.
	input validButtonPress,
	input validButtonHigh,
	input[3:0] State,
	
	output wire[3:0] digit,
	output reg[3:0] operator,
	output reg operand,
	output reg[7:0] location,

	output reg reset,
	output reg equals,
	output reg backspace,
	output reg negative,
	output reg memStore,
	output reg memRecall,
	output reg memClear
	
);
//A digit lookup table is used to allow the program to detect what digit is currently being pressed based on the voltage location of the keyboard.
digitLookup digitTable(location, digit);

initial operator = 4'b0000;
initial operand = 0;
initial reset = 0;
initial equals = 0;
initial negative = 0;

always @ (posedge Clock_10ms) begin
	// ******** KEYPAD SEGMENT ************** //
	//Generate a location based on the row and column 4 bit numbers that represent the current voltages being sent or read on the keypad.
		location = {row, Column};
			
			//If the digit is greater than 11 then this means it is an operand. This will set the operand wire high, letting the FSM change state.
			if(digit > 11 && validHigh) begin
				operand = 1;
				//This allows the subtract key to also be used as a negative sign. This condition means it will only save the operator when in the correct state.
				if(State == 3'b001) begin
					operator = digit;
				end
			end
			else begin

				operand = 0;
			end
			
			if(digit == 10 && validHigh) begin
				reset = 1;
			end
			else begin
				reset = 0;
			end
			
			if(digit == 11 && validHigh) begin
				equals = 1;
			end
			else begin
				equals = 0;
			end
			
			if(digit == 14 && validHigh) begin
				negative = 1;
			end
			else begin
				negative = 0;
			end
			
	// *********** BUTTON SEGMENT ********* //
			if(buttonPressed == 2'b00 && validButtonHigh) begin
				backspace = 1;
			end
			else begin
				backspace = 0;
			end
			
			if(buttonPressed == 2'b01 && validButtonHigh) begin
				memStore = 1;
			end else begin
				memStore = 0;
			end
			
			if(buttonPressed == 2'b10 && validButtonHigh) begin
				memRecall = 1;
			end else begin
				memRecall = 0;
			end
			
			if(buttonPressed == 2'b11 && validButtonHigh) begin
				memClear = 1;
			end else begin
				memClear = 0;
			end
	
end 

endmodule
