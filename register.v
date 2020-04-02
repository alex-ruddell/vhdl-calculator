module register(
	input[1:0] enable,
	input[3:0] digit,
	input Clock_10ms,
	input validHigh,
	input reset,
	input backspace,
	input negative,
	input[3:0] delayedStorage, 
	input isDelayed,
	input memRecall,
	input[11:0] memoryRecall,
	
	output reg[11:0] bitStore,
	output reg numberSign
);

initial bitStore = 12'b0;
reg run;
initial run = 1;

initial numberSign = 0;

always @ (posedge Clock_10ms) begin
	//Only store values in the register when it is correctly enabled. The enabled is controlled by the FSM.
	if (enable[1]) begin
		//Only store on the positive edge of the valid signal that comes from the debounce function. 
		if (validHigh) begin
			//Only store if the digit is a number and not an operand.
			if (digit < 10) begin
				//Shift the bits of the register to make room for the new numbers that are being input.
				bitStore[11:8] <= bitStore[7:4];
				bitStore[7:4] <= bitStore[3:0];
				bitStore[3:0] <=  digit;
			end
		end	
		
		//If the memory recall button is pressed, overwrite the current memory with what is stored in the other memory.
		if(memRecall) begin
			bitStore <= memoryRecall;
		end
		
	end
		if (delayedStorage != 4'b1111 && run && isDelayed) begin
			bitStore[3:0] <= delayedStorage;
			run <= 0;
		end
	
		if (reset) begin
			bitStore[11:0] <= 12'b0;
			run <= 1;
			numberSign <= 0;
		end
	
		if (backspace) begin
			bitStore[3:0] <= bitStore[7:4];
			bitStore[7:4] <= bitStore[11:8];
			bitStore[11:8] <= 4'b0;
		end
		

	//This will store the sign of the number in a different section of the memory that can still be accessed later. 
	if(enable[0]) begin
		if(memRecall) begin
			bitStore <= memoryRecall;
		end
		if (negative) begin
			if (numberSign) begin
				numberSign <= 0;
			end else begin
				numberSign <= 1;
			end
		end
	end
	


end

endmodule
