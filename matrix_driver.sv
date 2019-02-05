// Module displaying the LEDs on the 8x8 board row by row
module matrix_driver (clk, red_array, green_array, red_driver, green_driver, row_sink); 
	input logic             clk; 
	input logic  [7:0][7:0] red_array, green_array; 
	output logic [7:0]      red_driver, green_driver, row_sink; 
	logic        [2:0]      count; 

	always_ff @(posedge clk) 
		count <= count + 3'b001; 

	// Display 1 row at a time
	always_comb begin	
		case (count) 
			3'b000: row_sink = 8'b11111110; 
			3'b001: row_sink = 8'b11111101; 
			3'b010: row_sink = 8'b11111011; 
			3'b011: row_sink = 8'b11110111; 
			3'b100: row_sink = 8'b11101111; 
			3'b101: row_sink = 8'b11011111; 
			3'b110: row_sink = 8'b10111111; 
			3'b111: row_sink = 8'b01111111; 
		endcase 
	end
	
	assign red_driver = red_array[count]; 
	assign green_driver = green_array[count]; 
endmodule 

// Test the matrix_driver module
module matrix_driver_testbench();
	logic             clk; 
	logic [7:0][7:0] red_array, green_array; 
	logic [7:0]      red_driver, green_driver, row_sink;
	
   matrix_driver dut (.clk, .red_array, .green_array, .red_driver, .green_driver, .row_sink); 	
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																																														   @(posedge clk);
		red_array   <= { 8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000, 8'b00010000, 8'b00010000, 8'b00100000, 8'b01000000 };
		green_array <= { 8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000, 8'b00010000, 8'b00010000, 8'b00100000, 8'b01000000 }; repeat(100) @(posedge clk);
		$stop;
	end
	
endmodule