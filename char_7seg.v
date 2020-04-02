//This is the 7-segment display sub-file for Task 6. Same as previous, used to display information passed in as input 'C' to the HEX display
//referenced through the 'Display' variable.
module char_7seg (C, Display);

	input [2:0] C; //Input information
	output [0:6] Display; //Output 7-seg code
	
	//Logic for each segment of the HEX display as determined through truth tables earlier in the project.
	assign Display[0] = ((~C[2] & ~C[0]) | C[2]);
	assign Display[1] = ((~C[2] & ~C[1] & C[0]) | (~C[2] & C[1] & ~C[0]) | C[2]);
	assign Display[2] = ((~C[2] & ~C[1] & C[0]) | (~C[2] & C[1] & ~C[0]) | C[2]);
	assign Display[3] = ((~C[2] & ~C[1] & ~C[0]) | C[2]);
	assign Display[4] = C[2];
	assign Display[5] = C[2];
	assign Display[6] = ((~C[2] & C[1]) | C[2]);

endmodule
