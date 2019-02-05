// Module controlling first HEX digit which displays the score
module score (clk, reset, green_array, enable, hex, out);
	input logic clk, reset, enable;
	input logic [7:0][7:0] green_array;
	output logic out;
	output logic [3:0] hex;
	logic [3:0] counter;

	// Output logic
	assign hex = counter;
	assign out = (enable & (counter == 4'b1001) & 	(green_array[7][6] | green_array[6][6] | 
																	 green_array[5][6] | green_array[4][6] | 
																	 green_array[3][6] | green_array[2][6] | 
																	 green_array[1][6] | green_array[0][6]));
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset | (enable & (counter == 4'b1001) & (green_array[7][6] | green_array[6][6] |
																	 green_array[5][6] | green_array[4][6] | 
																	 green_array[3][6] | green_array[2][6] | 
																	 green_array[1][6] | green_array[0][6])))
			counter <= 4'b0000;
		else if (enable & 									(green_array[7][6] | green_array[6][6] | 
																	 green_array[5][6] | green_array[4][6] | 
																	 green_array[3][6] | green_array[2][6] | 
																	 green_array[1][6] | green_array[0][6]))
			counter <= counter + 4'b0001; 
		else
			counter <= counter; 
	end
	
endmodule 

// Test the score module
module score_testbench();
	logic clk, reset, enable;
	logic [7:0][7:0] green_array;
	logic out;
	logic [3:0] hex;
	
	score dut (.clk, .reset, .green_array, .enable, .hex, .out);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																																											@(posedge clk);
		reset <= 1;					    			 																													@(posedge clk);
		reset <= 0; enable <= 0;
		green_array <= { 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000 }; @(posedge clk);
						enable <= 1; green_array[6][6] <= 1;																					 repeat(20) @(posedge clk);
		
		$stop;
	end

endmodule 