module stolen (stol, upc, mark);
	input logic [2:0] upc;
	input logic mark;
	output logic stol;
	
	assign stol = (upc[2] & ~upc[1] & ~mark) | (~upc[1] & ~upc[0] & ~mark);
endmodule

module stolen_testbench();    
   logic stol, mark;
	logic [2:0] upc;
	
   stolen dut (.stol, .upc, .mark);
   
	// Try all combinations of inputs.
   integer i;
   initial begin
      for(i = 0; i < 16; i++) begin
         { upc[2:0], mark } = i; #10;
      end
   end
endmodule 