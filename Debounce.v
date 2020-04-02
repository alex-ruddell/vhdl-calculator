module Debounce(
	input clock_10ms,
	input debounceEnable,
	output wire valid
	);
//Debounce makes use of 2 D flip flops that compare the signal to see if it is valid or not.
wire prePreValid, preValid, notPreValid;
Dflop d1(clock_10ms, debounceEnable, prePreValid);
Dflop d2(clock_10ms, prePreValid, preValid);

assign notPreValid = ~preValid;
assign valid = notPreValid & prePreValid;

endmodule

module Dflop(
	input clock_10ms,
	input D,
	output reg Q
);

always @ (posedge clock_10ms) begin
	Q <= D;
end

endmodule

