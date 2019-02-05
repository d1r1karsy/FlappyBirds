// Checks if the bird goes out of the game's bounds
module bounds (clk, reset, key, gravity, top, bottom, out_of_bounds);
	input logic clk, reset, key, gravity, top, bottom;
	output logic out_of_bounds;
	
	// State variables
	enum { YES, NO } ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
			YES: 																				ns = NO;
 			NO:  if ((bottom & ~key & gravity) | (top & key & ~gravity))	ns = YES;
				  else 																		ns = NO;
		endcase
	end

	// Output logic
	assign out_of_bounds = (ps == YES);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= NO;
		else
			ps <= ns;
	end
	
endmodule 

// Test the bounds module
module bounds_testbench();
	logic clk, reset, key, gravity, top, bottom;
	logic out_of_bounds;
	
	bounds dut (.clk, .reset, .key, .gravity, .top, .bottom, .out_of_bounds);
	
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
					   key <= 1; 					top <= 1; 					@(posedge clk);
						key <= 0;	            								@(posedge clk);
																						@(posedge clk);
														top <= 0; 					@(posedge clk); 
																						@(posedge clk);
														          bottom <= 1; 	@(posedge clk);
									 gravity <= 1;									@(posedge clk);
									 gravity <= 0;									@(posedge clk);
																						@(posedge clk);
		$stop;
	end
	
endmodule 