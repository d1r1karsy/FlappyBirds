// Generate a random 4-bit number every clock cycle
module random (clk, reset, number);
	input logic clk, reset;
	output logic [3:0] number;
	
	// DFFs
	always @(posedge clk) begin
		if(reset)
			number <= 4'b0000;
		else	begin
			number[2:0] <= number[3:1];
			number[3] 	<= (number[0] & number[1]) | (~number[0] & ~number[1]);
			end
		end

endmodule

// Test the random module
module random_testbench();
	logic clk, reset;
	logic [3:0] number;
	
	random dut (.clk, .reset, .number);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
										    @(posedge clk);
		reset <= 1;					    @(posedge clk);
		reset <= 0; 	repeat(1025) @(posedge clk);
		$stop;
	end

endmodule 