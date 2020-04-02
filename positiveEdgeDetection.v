module positiveEdgeDetection ( 
	input D,          
   input clk,           
   output Q
);           
 
reg  D_dly;                        
 
always @ (posedge clk) begin
   D_dly <= D;
end

assign Q = D & ~D_dly;            
endmodule 