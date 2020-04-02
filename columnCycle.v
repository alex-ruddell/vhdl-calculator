module columnCycle(
	input clock_Value,
	input[3:0] rowValue,
	output reg[3:0] colValue,
	output reg debounceEnable
);
 //This is just a simple module that will rotate through the colunmn values and output a 4 bit number that determines what voltages are sent to the columns.
initial colValue = 4'b1110;

always @ (posedge clock_Value)
begin
		if(rowValue != 4'b1111) begin
			debounceEnable = 1;
		end
		else begin
			debounceEnable = 0; 
	// Rotating the column every clock count...
			if (colValue == 4'b1110) begin
				colValue <= 4'b0111;
				end
			else if (colValue == 4'b1101) begin
				colValue <= 4'b1110;
				end
			else if (colValue == 4'b1011) begin
				colValue <= 4'b1101;
				end
			else if (colValue == 4'b0111) begin
				colValue <= 4'b1011;
				end
		end
end

endmodule 
