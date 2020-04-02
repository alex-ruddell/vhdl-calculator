//This task makes use of all 8 HEX displays to show a maximum of 5 letters on the display at a time. The 3 other displays will show no output. Like task 5, the user is able to select the desired
//letters on the displays through the use of Switches 14:0. The user is then able to rotate the location of these letters through the control of switches 17:15. To meet the requirements, an 8-1 multiplexer is used
//being made through a combination of 7 2-1 multiplexer blocks. The code utilises 8 instantiations of this multiplexer to incorporate the 8 different input combinations.

module calculatorVHDL (SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, LEDR);
	//Setting the inputs and outputs based on the 
	input [17:0] SW; // toggle switches
	//7 Segment Displays
	output [0:6] HEX0;
	output [0:6] HEX1;
	output [0:6] HEX2;
	output [0:6] HEX3;
	output [0:6] HEX4;
	output [0:6] HEX5;
	output [0:6] HEX6;
	output [0:6] HEX7;
	//Instantiate output red LEDs.
	output[17:0]LEDR;
	
	//Instantiating the internal wires of the multiplexer
	wire [2:0] M;
	wire [2:0] N;
	wire [2:0] O;
	wire [2:0] P;
	wire [2:0] Q;
	wire [2:0] R;
	wire [2:0] S;
	wire [2:0] T;
	wire [2:0] BLANK;
	
	//Assigning the red LEDs to the switches to indicate that they have been turned on.
	assign LEDR = SW;
	
	//Setting the value of the blank to 111, so that it will not display anything.
	assign BLANK[0] = 1'b1;
	assign BLANK[1] = 1'b1;
	assign BLANK[2] = 1'b1;
	
	//Calling the 8 instantiations of the multiplexer with a different order of inputs to simulate the different positions of the letter. A binary 3 bit number will be output to feed into
	//the 7 segnment display module.
	mux_3bit_8to1 M0 (SW[17:15], SW[2:0], BLANK, BLANK, BLANK, SW[14:12], SW[11:9], SW[8:6], SW[5:3], M);
	mux_3bit_8to1 M2 (SW[17:15], SW[8:6], SW[5:3], SW[2:0], BLANK, BLANK, BLANK, SW[14:12], SW[11:9], O);	
	mux_3bit_8to1 M3 (SW[17:15], SW[11:9], SW[8:6], SW[5:3], SW[2:0], BLANK, BLANK, BLANK, SW[14:12], P);	
	mux_3bit_8to1 M4 (SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], BLANK, BLANK, BLANK, Q);	
	mux_3bit_8to1 M5 (SW[17:15], BLANK, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], BLANK, BLANK, R);	
	mux_3bit_8to1 M6 (SW[17:15], BLANK, BLANK, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], BLANK, S);	
	mux_3bit_8to1 M7 (SW[17:15], BLANK, BLANK, BLANK, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], T);	
	mux_3bit_8to1 M1 (SW[17:15], SW[5:3], SW[2:0], BLANK, BLANK, BLANK, SW[14:12], SW[11:9], SW[8:6], N);
	//Instantiations to feed in the outputs from respective multiplexers to control each HEX display. 
	char_7seg H0 (M, HEX0);
	char_7seg H1 (N, HEX1);
	char_7seg H2 (O, HEX2);
	char_7seg H3 (P, HEX3);
	char_7seg H4 (Q, HEX4);
	char_7seg H5 (R, HEX5);
	char_7seg H6 (S, HEX6);
	char_7seg H7 (T, HEX7);
	
endmodule
