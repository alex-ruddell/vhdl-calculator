module fsm(
	input operand,
	input negative,
	input Clock,
	input[3:0] digit,
	input reset,
	input equals,
	input validHigh,
	input memRecall,
	
	output reg[5:0] enable,
	
	output reg[2:0] State,

	output reg[3:0] delayedStorage,
	output reg delayedOne,
	output reg delayedTwo,
	output reg ALUenable
);

// States and their functions
// Zero: First sign || One: First number || Two: Operand || Three: Second sign || Four: Second number || Five: Equals pressed
parameter[2:0] StateZero = 3'b000, StateOne = 3'b001, StateTwo = 3'b010, StateThree = 3'b011, StateFour = 3'b100;
initial State = StateZero;

// Enable register:
// Corresponds to each state: e.g enable = 00001, enable[0] = 1 so in state zero.
initial enable = 5'b00001;

initial delayedStorage = 4'b1111; // Initialise as this bc it can only logically be a number...

initial delayedOne = 0;
initial delayedTwo = 0;

always @ (posedge Clock) begin
	//if the reset button is pressed then we want to return to the original or starting state zero.
	if(reset) begin

		State <= StateZero;

	end
	
	case(State)
		StateZero: begin  
			//This state will be waiting for the sign input of the first number from the keypad. If no sign is pressed, it will detect that the digit is less than 10
			//and so will store the digit press and move to StateOne where it can begin to store the number in a register. Or if the memory recall button is pressed
			//then it will move to the next state.
			if ((validHigh && digit <= 10) || memRecall) begin

				State <= StateOne;
			end	
		end
		
		StateOne: begin  
			//State one will enable the first register and store the number in there. Once an operand digit is detected, it will move to the next state.
			if (operand || memRecall) begin
	
				State <= StateTwo;
			end
	
		end
		
		StateTwo: begin  
			//Like state zero, it will wait for the sign of the second number or else move to the next state.
			if ((validHigh && digit <= 10) || memRecall) begin

				State <= StateThree;
			end	
		end
		
		StateThree: begin  
			//Will enable register 2 and will store the number in it
			if (equals) begin
				State <= StateFour;
			end
		end
			
		StateFour: begin   // Do stuff
			// Idle for now... ALU STUFF
		end
		
	endcase
end
	


always @ (*) begin
	
	if(reset) begin
		ALUenable = 0;
		delayedStorage <= 4'b1111;

		delayedOne <= 0;
		delayedTwo <= 0;
		enable = 5'b00001;

	end
	
	case(State) 
		StateZero: begin
				ALUenable = 0;
				delayedTwo <= 0;
				enable <= 5'b00001;

				//in this state, pressing a digit that isn't the sign will trigger a move to the next state. The digit must be stored as without this then the first digit press
				//would be missed.
				if (validHigh && digit <= 10) begin
					delayedStorage <= digit;
					delayedOne <= 1'b1;
				end else begin
					delayedStorage <= 4'b1111;
					delayedOne <= 0;
				end
		end
		
		StateOne: begin
				ALUenable = 0;
				enable <= 5'b00010;
				delayedStorage <= 4'b1111;

				delayedOne <= 0;
				delayedTwo <= 0;
		end
		
		StateTwo: begin
				ALUenable = 0;
				enable <= 5'b00100;

				delayedOne <= 0;

				if (validHigh && digit <= 10) begin
					delayedStorage <= digit;
					delayedTwo <= 1'b1;
				end else begin
					delayedStorage <= 4'b1111;
					delayedTwo <= 0;
				end
		end
		
		StateThree: begin
				ALUenable = 0;
				enable <= 5'b01000;
				delayedStorage <= 4'b1111;

				delayedOne <= 0;
				delayedTwo <= 0;
		end
		
		StateFour: begin
				enable <= 5'b10000;
				ALUenable = 1;
				delayedStorage <= 4'b1111;

				delayedOne <= 0;
				delayedTwo <= 0;
		end	
		
		default: begin
			ALUenable = 0;
			enable = 5'b00001;
			delayedStorage <= 4'b1111;

			delayedOne <= 0;
			delayedTwo <= 0;
		end
	endcase
end

endmodule



