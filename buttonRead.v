module buttonRead(
	input[3:0] KEY,
	input clock,
	
	output reg[1:0] button,
	output reg debounceEnable
);

initial debounceEnable = 0;

always @ (posedge clock)
begin
	if (KEY != 4'b1111) begin
		debounceEnable = 1;
		case (KEY)
			4'b1110: button <= 2'b00; // Button PB0 pushed
			4'b1101: button <= 2'b01; // Button PB1 pushed
			4'b1011: button <= 2'b10; // Button PB2 pushed
			4'b0111: button <= 2'b11; // Button PB3 pushed
		endcase
	end
	else begin
		debounceEnable = 0;
	end
end
endmodule 