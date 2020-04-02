module clockDivider(
	input wire Clock,
	output wire Clock_div1000,

	output wire Clock_10ms
);
//The clock divider will provide a slower clock that will control the cycling of column voltages, and a faster clock that will control the rest of the circuit.
reg[24:0] count_internal = 24'd0;

reg[24:0] count3 = 24'd0;
reg clock_out = 1'b0;

reg clock3_out = 1'b0;

always @ (posedge Clock) begin
	if(count_internal == 24'd250000) begin // Currently at 50ms
		count_internal <= 24'd0;
		clock_out <= ~clock_out;	
	end else begin
		count_internal <= count_internal + 1;
	end
	

	if(count3 == 24'd50000) begin //Currently at 10ms
		count3 <= 24'd0;
		clock3_out <= ~clock3_out;
	end else begin
		count3 <= count3 + 1;
	end
end

assign Clock_div1000 = clock_out;
assign Clock_10ms = clock3_out;

endmodule
