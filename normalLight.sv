// Module defining if the LEDs, except for the middle, should be on or off
module normalLight (clk, reset, pause, key, gravity, top, bottom, light);
	input logic clk, reset, pause, key, gravity, top, bottom;
	output logic light;
	
	// State variables
	enum { ON, OFF } ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
			ON:  if ((key & ~gravity) | (~key & gravity))		            ns = OFF;
				  else																	   ns = ON;
 			OFF: if ((bottom & key & ~gravity) | (top & ~key & gravity))	ns = ON;
				  else 											                     ns = OFF;
		endcase
	end

	// Output logic
	assign light = (ps == ON);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= OFF;
		else if (pause)
			ps <= ps;
		else
			ps <= ns;
	end
	
endmodule 

// Test the normalLight module
module normalLight_testbench();
	logic clk, reset, pause, key, gravity, top, bottom;
	logic light;
	
	normalLight dut (.clk, .reset, .pause, .key, .gravity, .top, .bottom, .light);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																						@(posedge clk);
		reset <= 1;																	@(posedge clk);
																						@(posedge clk);
		reset <= 0; key <= 0; gravity <= 0; top <= 0; bottom <= 0;	@(posedge clk);
																						@(posedge clk);
								    gravity <= 1; top <= 1; 					@(posedge clk);
								    gravity <= 0;									@(posedge clk);
																						@(posedge clk);
						key <= 1; 													@(posedge clk); 
																						@(posedge clk);
														          bottom <= 1; 	@(posedge clk);
									 gravity <= 1;									@(posedge clk);
									 gravity <= 0;									@(posedge clk);
																						@(posedge clk);
		$stop;
	end
	
endmodule 