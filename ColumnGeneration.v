module ColumnGeneration(
	input clock_Value,
	input wire[3:0] rowValue,
	
	output reg[3:0] column,
	output reg debounceEnable,
	output[17:0]LEDR
);

reg[3:0] colValue;
initial colValue = 4'b1110;

always @ (posedge clock_Value)
begin
		/*if(rowValue != 4'b1111) begin
			debounceEnable = 1;
		end
		else begin*/
			debounceEnable = 0; 
	// Rotating the column every clock count...
			if (colValue == 4'b1110) begin
				column <= 4'b0111;
				colValue <= column;
				end
			else if (colValue == 4'b1101) begin
				column <= 4'b1110;
				colValue <= column;
				end
			else if (colValue == 4'b1011) begin
				column <= 4'b1101;
				colValue <= column;
				end
			else if (colValue == 4'b0111) begin
				column <= 4'b1011;
				colValue <= column;
				end
		//end
end

assign LEDR[10:7] = colValue;
assign LEDR[15:12] = column;
endmodule 