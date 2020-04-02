module NegativeEdgeDetector(
	input in,
	input clock,
	output out
);

wire q0,q1;

D_FF D1(in,clock,q0); //instantiation of D Flip Flop
D_FF D2(q0,clock,q1);
assign out=(q0 && !q1);
endmodule

module D_FF(d,clock,q); //D Flip Flop module
input d,clock;
output reg q;
always@(negedge clock)
begin
q<=d;
end
endmodule