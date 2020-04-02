module segDisplay(
		input [3:0] inCode,
		output reg [6:0] outCode
    );
     
    always @(inCode)
    begin
        case (inCode)  
            4'd0 : outCode = 7'b0000001;
            4'd1 : outCode = 7'b1001111;
            4'd2 : outCode = 7'b0010010;
            4'd3 : outCode = 7'b0000110;
            4'd4 : outCode = 7'b1001100;
            4'd5 : outCode = 7'b0100100;
            4'd6 : outCode = 7'b0100000;
            4'd7 : outCode = 7'b0001111;
            4'd8 : outCode = 7'b0000000;
            4'd9 : outCode = 7'b0000100;
				// If we have time at the end make it say "ADD" when you wanna add
				4'd10 : outCode = 7'b0001000;
				4'd11 : outCode = 7'b1111111;
				4'd12 : outCode = 7'b0110001;
				4'd13 : outCode = 7'b0000001;
				4'd14 : outCode = 7'b0110000;
				4'd15 : outCode = 7'b0111000;
				
            default : outCode = 7'b1111111; 
        endcase
    end
    
endmodule
