// Module controlling one digit HEX which displays the score
module increment (clk, reset, in, hex, out);
	input logic clk, reset, in;
	output logic out;
	output logic [3:0] hex;
	logic [3:0] counter;

	// Output logic
	assign hex = counter;
	assign out = ((counter == 4'b1001) & in);
	
	logic local_in;
	useInput loc_in (.clk, .reset, .keyin(in), .keyout(local_in));
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset | ((counter == 4'b1001) & in ))
			counter <= 4'b0000;
		else if (local_in)
			counter <= counter + 4'b0001; 
		else
			counter <= counter; 
	end
	
endmodule 

// Test the increment module
module increment_testbench();
	logic clk, reset, in;
	logic out;
	logic [3:0] hex;
	
	increment dut (.clk, .reset, .in, .hex, .out);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
														 @(posedge clk);
		reset <= 1;					    			 @(posedge clk);
		reset <= 0; in <= 0; 		repeat(5) @(posedge clk);
						in <= 1; 		repeat(5) @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
						in <= 0; 					 @(posedge clk);
						in <= 1; 		 			 @(posedge clk);
		$stop;
	end

endmodule 