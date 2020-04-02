module Display(
	input[2:0] State,
	input[11:0] memory1,
	input[11:0] memory2,
	input[3:0] operator,
	input number1Sign,
	input number2Sign,
	input ALUsign,
	input Clock_1ms,
	input[3:0] hundredt,
	input[3:0] tent,
	input[3:0] t,
	input[3:0] hundred,
	input[3:0] tens,
	input[3:0] one,
	input[3:0] remaindertens,
	input[3:0] remainderones,
	
	output reg[0:6] HEX0,
	output reg[0:6] HEX1,
	output reg[0:6] HEX2,
	output reg[0:6] HEX3,
	output reg[0:6] HEX4,
	output reg[0:6] HEX5,
	output reg[0:6] HEX6,
	output reg[0:6] HEX7,
	
	output reg[11:0] memorytoDecode
);

//The display module controls the output to the 7 seg displays. Based on the state of the FSM, it will change the incode that is being sent to the display decoders. 

parameter blank = 7'b1111111, r = 7'b1111010;

wire[6:0] hex0code, hex1code, hex2code, hex3code, hex4code, hex5code, remainder1code, remainder2code;

initial memorytoDecode = 12'b0;

initial HEX0 = blank;
initial HEX1 = blank;
initial HEX2 = blank;
initial HEX3 = blank;
initial HEX4 = blank;
initial HEX5 = blank;
initial HEX6 = blank;
initial HEX7 = blank;

always @ (*) begin

	HEX7 = blank;
	case(State)  
		
		3'b000: begin		// Display blank, wait for sign
			memorytoDecode = 12'b0;
			HEX0 = blank;
			HEX1 = blank;
			HEX2 = blank;
			HEX3 = blank;
			HEX4 = blank;
		   HEX5 = blank;

			HEX6[6] = ~number1Sign;
		end
		
		3'b001: begin		// Display sign + first num, wait for operator
			memorytoDecode = memory1;
			HEX0 = hex0code;
			HEX1 = hex1code;
			HEX2 = hex2code;
			HEX3 = blank;
	      HEX4 = blank;
			HEX5 = blank;
			
			HEX6[6] = ~number1Sign;
		end
		
		3'b010: begin		// Display same, wait for sign
			memorytoDecode = memory2;
			HEX0 = hex0code;
			HEX1 = hex1code;
			HEX2 = hex2code;
			HEX3 = blank;
			HEX4 = blank;
			HEX5 = blank;
			
			HEX6[6] = ~number2Sign;
			end
		
		3'b011: begin		// Display sign + second num, wait for equals
			memorytoDecode = memory2;
			HEX0 = hex0code;
			HEX1 = hex1code;
			HEX2 = hex2code;
			HEX3 = blank;
			HEX4 = blank;
			HEX5 = blank;
			
			HEX6[6] = ~number2Sign;
		end
		
		3'b100: begin		// Displaying ALU result...
			memorytoDecode[3:0] = one;
			memorytoDecode[7:4] = tens;
			memorytoDecode[11:8] = hundred;
			
			if(operator == 4'b1100) begin
				HEX5 = hex2code;
				HEX4 = hex1code;
				HEX3 = hex0code;
				HEX2 = r;
				HEX1 = remainder2code;
				HEX0 = remainder1code;
			end else begin

				HEX0 = hex0code;
				HEX1 = hex1code;
				HEX2 = hex2code;
				HEX3 = hex3code;
				HEX4 = hex4code;
				HEX5 = hex5code;
			end
			HEX6[6] = ~ALUsign;

		end
		
		3'b101: begin
			memorytoDecode[3:0] = one;
			memorytoDecode[7:4] = tens;
			memorytoDecode[11:8] = hundred;
			
			if(operator == 4'b1100) begin
				HEX5 = hex2code;
				HEX4 = hex1code;
				HEX3 = hex0code;
				HEX2 = r;
				HEX1 = remainder2code;
				HEX0 = remainder1code;
			end else begin

				HEX0 = hex0code;
				HEX1 = hex1code;
				HEX2 = hex2code;
				HEX3 = hex3code;
				HEX4 = hex4code;
				HEX5 = hex5code;
			end
			HEX6[6] = ~ALUsign;
		end
		
		default: begin
			memorytoDecode = 12'b0;
			HEX0 = blank;
			HEX1 = blank;
			HEX2 = blank;
			HEX3 = blank;
			HEX4 = blank;
		   HEX5 = blank;
			
			HEX6 = blank;
		end
			
	endcase
	
end 
//use these modules when displaying the number input
segDisplay hex0out(memorytoDecode[3:0], hex0code);
segDisplay hex1out(memorytoDecode[7:4], hex1code);
segDisplay hex2out(memorytoDecode[11:8], hex2code);

//use these modules for dispalying alu output 
segDisplay hex3out(t, hex3code);
segDisplay hex4out(tent, hex4code);
segDisplay hex5out(hundredt, hex5code);

segDisplay rem1(remainderones, remainder1code);
segDisplay rem2(remaindertens, remainder2code);

endmodule
