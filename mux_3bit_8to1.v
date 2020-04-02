//This is the 3 bit 8 to 1 multiplexer sub-file for task 6. This multiplexer is created using 7x 2 to 1 multiplexers to differentiate between different input selections.
//Z1, Z2, and Z3 have been added as the extra inputs to the multiplexer as placeholders for the blank space that will rotate at the end of the word.
module mux_3bit_8to1 (S, U, V, W, X, Y, Z1, Z2, Z3, Output);

	input [2:0] S, U, V, W, X, Y, Z1, Z2, Z3;
	output [2:0] Output;
	//Instatiation of internal wiring.
	wire[2:0]a0;
	wire[2:0]a1;
	wire[2:0]a2;
	wire[2:0]a3;
	wire[2:0]a4;
	wire[2:0]a5;
	//Multiplexer logic, done by element.
	// First tier
	assign a0[0] = (~S[0] & U[0]) | (S[0] & V[0]);
	assign a0[1] = (~S[0] & U[1]) | (S[0] & V[1]);
	assign a0[2] = (~S[0] & U[2]) | (S[0] & V[2]);
	
	assign a2[0] = (~S[0] & W[0]) | (S[0] & X[0]);
	assign a2[1] = (~S[0] & W[1]) | (S[0] & X[1]);
	assign a2[2] = (~S[0] & W[2]) | (S[0] & X[2]);
	
	assign a3[0] = (~S[0] & Y[0]) | (S[0] & Z1[0]);
	assign a3[1] = (~S[0] & Y[1]) | (S[0] & Z1[1]);
	assign a3[2] = (~S[0] & Y[2]) | (S[0] & Z1[2]);
	
	assign a4[0] = (~S[0] & Z2[0]) | (S[0] & Z2[0]);
	assign a4[1] = (~S[0] & Z2[1]) | (S[0] & Z2[1]);
	assign a4[2] = (~S[0] & Z2[2]) | (S[0] & Z2[2]);
	// Second tier
	assign a1[0] = (~S[1] & a0[0]) | (S[1] & a2[0]);
	assign a1[1] = (~S[1] & a0[1]) | (S[1] & a2[1]);
	assign a1[2] = (~S[1] & a0[2]) | (S[1] & a2[2]);	
	
	assign a5[0] = (~S[1] & a3[0]) | (S[1] & a4[0]);
	assign a5[1] = (~S[1] & a3[1]) | (S[1] & a4[1]);
	assign a5[2] =	(~S[1] & a3[2]) | (S[1] & a4[2]);
	// Third tier / output
	assign Output[0] = (~S[2] & a1[0]) | (S[2] & a5[0]);
	assign Output[1] = (~S[2] & a1[1]) | (S[2] & a5[1]);
	assign Output[2] = (~S[2] & a1[2]) | (S[2] & a5[2]);

endmodule
