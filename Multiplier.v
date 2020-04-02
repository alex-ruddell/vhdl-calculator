module Multiplier(
		input Enable,
		input[20:0] Number0,
		input[20:0] Number1,
		
		output reg[20:0] outputNumber
);

reg[20:0] first, second, third;
integer i;
reg firstEnable;

always @ (*) begin
	if(Enable) begin
		for(i = 1; i <= 19; i = i + 1) begin 
					if(firstEnable) begin
						if(Number1[0]) begin
							first = Number0;
						end else begin
							first = 20'b0;
						end
						firstEnable = 0;
					end
					
					if(Number1[i]) begin
						//second = tempNumber1;
						second = second<<1'b1;
					end else begin
						second = 20'b0;
					end
					
					first = first + second;
					
		end
		
		outputNumber = first;
		end

end

endmodule
