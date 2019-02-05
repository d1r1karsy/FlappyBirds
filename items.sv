module items (let5, let4, let3, let2, let1, let0, upc);
	input  logic [2:0] upc;
	output logic [6:0] let5, let4, let3, let2, let1, let0;
	
	always_comb begin
		case (upc)
			3'b000: begin let5 = 7'b0010010; let4 = 7'b0001001; let3 = 7'b1111001; let2 = 7'b0101111; let1 = 7'b0000111; let0 = 7'b1111111; end //SHIrt
			3'b001: begin let5 = 7'b0001000; let4 = 7'b0001100; let3 = 7'b0001100; let2 = 7'b1000111; let1 = 7'b0000110; let0 = 7'b1111111; end //APPLE
			3'b011: begin let5 = 7'b0000000; let4 = 7'b0001000; let3 = 7'b1000111; let2 = 7'b1000111; let1 = 7'b1111111; let0 = 7'b1111111; end //BALL
			3'b100: begin let5 = 7'b0000010; let4 = 7'b1000111; let3 = 7'b0001000; let2 = 7'b0010010; let1 = 7'b0010010; let0 = 7'b1111111; end //GLASS
			3'b101: begin let5 = 7'b0000000; let4 = 7'b0000110; let3 = 7'b1000111; let2 = 7'b0000111; let1 = 7'b1111111; let0 = 7'b1111111; end //BELt
			3'b110: begin let5 = 7'b0101111; let4 = 7'b1000000; let3 = 7'b0001100; let2 = 7'b0000110; let1 = 7'b1111111; let0 = 7'b1111111; end //rOPE
			default: begin let5 = 7'bX; let4 = 7'bX; let3 = 7'bX; let2 = 7'bX; let1 = 7'bX; let0 = 7'bX; end
		endcase
	end
endmodule 

module items_testbench();
	logic  let5, let4, let3, let2, let1, let0;
	logic [2:0] upc;
   items dut (.let5, .let4, .let3, .let2, .let1, .let0, .upc);
   
	// Try all combinations of inputs.
   integer i;
   initial begin
      for(i = 0; i < 8; i++) begin
         upc[2:0] = i; #10;
      end
   end
endmodule 
