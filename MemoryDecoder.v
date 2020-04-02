//The memory decoder module will take in a 12 bit number that represents a register. The register will contain anything from 0 -> 3 numbers (each one being 4 bit). It will then
//call the segment display function by breaking up the memory input number into 3 bits. Teh segDisplay function will decode this 4 bit number into a 7 bit number to be used on 
//the 7 segment displays.

module MemoryDecoder(
	input[11:0] memory,
	
	output [6:0] hex0code,
	output [6:0] hex1code,
	output [6:0] hex2code
);


	segDisplay hex0out(memory[3:0], hex0code);
	segDisplay hex1out(memory[7:4], hex1code);
	segDisplay hex2out(memory[11:8], hex2code);

endmodule
