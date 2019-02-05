// Slows down the actual clock used by the circuit
// New barriers are generated in this frequency
module counter3 (clk, reset, pause, enable);
   input  logic clk, reset, pause;
	output logic enable;
	logic [12:0] counter;
	
	always_ff @(posedge clk) begin
		if (reset)
			counter <= 13'b0000000000000;
		else if (pause)
			counter <= counter;
		else
			counter <= counter + 13'b0000000000001; 
	end
		
	assign enable = (counter == 13'b0000000000000);
endmodule

// Test the counter3 module
module counter3_testbench();
	logic clk, enable, reset, pause;
	
	counter3 dut (.clk, .reset, .pause, .enable);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		  reset <= 1; pause <= 0; 					 @(posedge clk);
		  reset <= 0;              repeat(5000) @(posedge clk);
						  pause <= 1; 	repeat(5)    @(posedge clk);
						  pause <= 0; 	repeat(5000) @(posedge clk);
		$stop;
	end
	
endmodule
	
	
	