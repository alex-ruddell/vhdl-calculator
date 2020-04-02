module Calculator (
	input[17:0]SW,
	input Row0,
	input Row1,
	input Row2,
	input Row3,
	input CLOCK_50,
	input[3:0] KEY,
	
	output[0:6] HEX0,
	output[0:6] HEX1,
	output[0:6] HEX2,
	output[0:6] HEX3,
	output[0:6] HEX4,
	output[0:6] HEX5,
	output[0:6] HEX6,
	output[0:6] HEX7,
	
	output[17:0]LEDR,
	output[7:0]LEDG,
	output Col0,
	output Col1,
	output Col2,
	output Col3
);

wire[3:0] rowValue, inCode, colValue, digit, operator, ht, tt, t, h, te, on, rht, rtt, rt, rh, rte, ron;
wire clock_Value, Clock_10ms, debounceEnable, valid, validHigh, operand, reset, equals, backspace, ALUenable, memStore, memRecall, memClear, debounceButton, validButtonPress, validButtonHigh;
wire[4:0] enable;
wire delayedOne, delayedTwo, negative, firstNumberSign, secondNumberSign, ALUsign;
wire[11:0] number0Mem, number1Mem, memorytoDecode, memoryRecall;
wire[7:0] location;
wire[2:0] State;
wire[20:0] ALUoutput, remainder;
wire[3:0] delayedStorage;

wire[1:0] buttonPressed;

reg[3:0] regColValue;
reg[7:0] rowColValue;

// index:	 { 3  ,   2 ,   1  ,  0  }
// rowValue: {Row0, Row1, Row2 , Row3}
//Read in the values of the rows and save as a 4 bit number
assign rowValue[0] = Row3;
assign rowValue[1] = Row2;
assign rowValue[2] = Row1;
assign rowValue[3] = Row0;

//Output voltages to the columns, depending on the 4 bit number that is stored in colValue
assign Col0 = colValue[3];
assign Col1 = colValue[2];
assign Col2 = colValue[1];
assign Col3 = colValue[0];

//Run the clock divider function that will output a slower 20ms clock, and an even slower 10ms clock.
clockDivider clock1(CLOCK_50, clock_Value, Clock_10ms);

//The column cycle module is what will rotate the voltages across the columns on the keypad.
columnCycle columnCycle(clock_Value, rowValue, colValue, debounceEnable);

//Starts the module to read the button presses.
buttonRead buttonRead(KEY, clock_Value, buttonPressed, debounceButton);


Debounce rowDebounce(Clock_10ms, debounceEnable, valid);
positiveEdgeDetection validDetect(valid, Clock_10ms, validHigh);

Debounce buttonDebounce(Clock_10ms, debounceButton, validButtonPress);
NegativeEdgeDetector validButtonDetect(validButtonPress, Clock_10ms, validButtonHigh); // For rising edge of button press...

KeyDecode digitCreate(colValue, rowValue, valid, validHigh, Clock_10ms, buttonPressed, validButtonPress, validButtonHigh, State, digit, operator, operand, location, reset, equals, backspace, negative, memStore, memRecall, memClear);

fsm Controller(operand, negative, Clock_10ms, digit, reset, equals, validHigh, memRecall, enable, State, delayedStorage, delayedOne, delayedTwo, ALUenable);


assign LEDG[4:0] = enable; // SHOWS STATE OF THE MACHINE
assign LEDG[7:5] = State;

//Register for Number One
register registerZero(.enable(enable[1:0]),
							 .digit(digit), 
							 .Clock_10ms(Clock_10ms), 
							 .validHigh(validHigh),
							 .reset(reset),
							 .backspace(backspace),
							 .negative(negative),
							 .delayedStorage(delayedStorage),
							 .isDelayed(delayedOne),
							 .memRecall(memRecall),
							 .memoryRecall(memoryRecall),
							 .bitStore(number0Mem),
							 .numberSign(firstNumberSign)
							 );

//Register for the Number two
register registerTwo(.enable(enable[3:2]),
							.digit(digit),
							.Clock_10ms(Clock_10ms),
							.validHigh(validHigh),
							.reset(reset),
							.backspace(backspace),
							.negative(negative),
							.delayedStorage(delayedStorage),
							.isDelayed(delayedTwo),
							.memRecall(memRecall),
							.memoryRecall(memoryRecall),
							.bitStore(number1Mem),
							.numberSign(secondNumberSign)
							);
							
//Register to be used for the memory storing operations
memoryModule memory(.clock(Clock_10ms),
						  .memStore(memStore),
						  .memClear(memClear),
						  .displayMemory(memorytoDecode),
						  .numberStore(memoryRecall)

);

ALU theALU(State, Clock_10ms, number0Mem, number1Mem, operator, ALUenable, equals, reset, firstNumberSign, secondNumberSign, ALUoutput, remainder, ALUsign);
BinarytoBCD conv(ALUoutput, ht, tt, t, h, te, on);
BinarytoBCD remainderConvert(remainder, rht, rtt, rt, rh, rte, ron);

Display theDisplay(State, number0Mem, number1Mem, operator, firstNumberSign, secondNumberSign, ALUsign, Clock_10ms, ht, tt, t, h, te, on, rte, ron, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, memorytoDecode);

endmodule 

