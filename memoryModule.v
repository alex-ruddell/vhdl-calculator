module memoryModule(
	input clock,
	input memStore,
	input memClear,
	input[11:0] displayMemory,
	
	output reg[11:0] numberStore
);
//This is the memory register that will store the number if the user enters memory store, and clear the number when the press memory press. If the user presses memory call, 
//then the system will use the number that is stored in MemoryStore.
initial numberStore = 12'b0;

always @ (posedge clock) begin
	if(memStore) begin
		numberStore = displayMemory;
	end else if(memClear) begin
		numberStore = 12'b0;
	end

end
endmodule 