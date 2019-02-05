// Slows down the actual clock used by the circuit
// Barriers move left in this speed.
module counter2 (clk, reset, pause, enable);
   input  logic clk, reset, pause;
	output logic enable;
	logic [10:0] counter;
	
	always_ff @(posedge clk) begin
		if (reset)
			counter <= 11'b00000000000;
		else if (pause)
			counter <= counter;
		else
			counter <= counter + 11'b00000000001; 
	end
		
	assign enable = (counter == 11'b00000000000);
endmodule

// Test the counter2 module
module counter2_testbench();
	logic clk, enable, reset, pause;
	
	counter2 dut (.clk, .reset, .pause, .enable);
	
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
	
	
	