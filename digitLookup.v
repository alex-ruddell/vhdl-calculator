module digitLookup(
	input[7:0] location,
	output reg[3:0] digit
);

always @ (*) begin
	case(location)
			8'b11101011: begin
								digit = 0;
							end
			
			8'b01110111: begin
								digit = 1;
							end 
							
			8'b01111011: begin
								digit = 2;
							end 
							
			8'b01111101: begin
								digit = 3;
							end 
							
			8'b10110111: begin
								digit = 4;
							end 
							
			8'b10111011: begin
								digit = 5;
							end 
							
			8'b10111101: begin
								digit = 6;
							end 
							
			8'b11010111: begin
								digit = 7;
							end 
							
			8'b11011011: begin
								digit = 8;
							end 
							
			8'b11011101: begin
								digit = 9;
							end 
							
			8'b11100111: begin
								digit = 10;
							end
							
			8'b11101101: begin
								digit = 11;
							end
							
			8'b11101110: begin
								digit = 12;
							end
							
			8'b11011110: begin
								digit = 13;
							end
							
			8'b10111110: begin
								digit = 14;
							end
							
			8'b01111110: begin
								digit = 15;
							end
							
			default: digit = 0;
							
			endcase
end
endmodule 