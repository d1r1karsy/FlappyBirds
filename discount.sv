module discount (disc, upc);
	input logic [2:0] upc;
	output logic disc;
	
	assign disc = upc[1] | (upc[0] & upc[2]);
endmodule

module discount_testbench();    
   logic  disc;
	logic [2:0] upc;
	
   discount dut (.disc, .upc);
   
	// Try all combinations of inputs.
   integer i;
   initial begin
      for(i = 0; i < 8; i++) begin
         upc[2:0] = i; #10;
      end
   end
endmodule 