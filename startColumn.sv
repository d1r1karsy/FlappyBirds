// Module defining the new barriers for the game
module startColumn (clk, reset, enable3, light8, light7, light6, light5, light4, light3, light2, light1);
	input logic clk, reset, enable3;
	output logic light8, light7, light6, light5, light4, light3, light2, light1;
	
	// Generate different barrier designs
	logic [15:0][7:0] barrier;
	assign barrier[0] [7:0] = 8'b00000000; 
	assign barrier[1] [7:0] = 8'b00011111; 
	assign barrier[2] [7:0] = 8'b10001111; 
	assign barrier[3] [7:0] = 8'b11000111; 
	assign barrier[4] [7:0] = 8'b11100011; 
	assign barrier[5] [7:0] = 8'b11110001; 
	assign barrier[6] [7:0] = 8'b11111000; 
	assign barrier[7] [7:0] = 8'b11100111;
	assign barrier[8] [7:0] = 8'b11110011;	
	assign barrier[9] [7:0] = 8'b11001111;
	assign barrier[10][7:0] = 8'b10001111; 
	assign barrier[11][7:0] = 8'b11000111; 
	assign barrier[12][7:0] = 8'b11100011; 
	assign barrier[13][7:0] = 8'b11110001;
	assign barrier[14][7:0] = 8'b00001111; 
	assign barrier[15][7:0] = 8'b00000111; 
	
	// Pick a random number between 0 and 15
	logic [3:0] any;
	random num 	  (.clk, .reset, .number(any));
	
	logic local_enab;
	useInput enab (.clk, .reset, .keyin(enable3), .keyout(local_enab));
	
	// Pick a random barrier and send it through
	always_comb begin
		if (local_enab) begin 
			light8 = barrier[any][7]; 
			light7 = barrier[any][6]; 
			light6 = barrier[any][5]; 
			light5 = barrier[any][4]; 
			light4 = barrier[any][3]; 
			light3 = barrier[any][2]; 
			light2 = barrier[any][1]; 
			light1 = barrier[any][0]; 
		end
		else begin 
			light8 = barrier[0][7]; 
			light7 = barrier[0][6]; 
			light6 = barrier[0][5]; 
			light5 = barrier[0][4]; 
			light4 = barrier[0][3]; 
			light3 = barrier[0][2]; 
			light2 = barrier[0][1]; 
			light1 = barrier[0][0]; 
		end
	end
	
endmodule 


// Test the startColumn module
module startColumn_testbench();
	logic clk, reset, enable3;
	logic light8, light7, light6, light5, light4, light3, light2, light1;

	startColumn dut (.clk, .reset, .enable3, .light8, .light7, .light6, .light5, .light4, .light3, .light2, .light1);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
														@(posedge clk);
		reset <= 1;					    			@(posedge clk);
		reset <= 0; enable3 <= 0; repeat(5) @(posedge clk);
						enable3 <= 1; repeat(5) @(posedge clk);
						enable3 <= 0; repeat(5) @(posedge clk);
						enable3 <= 1; repeat(5) @(posedge clk);
						enable3 <= 0; repeat(5) @(posedge clk);
						enable3 <= 1; repeat(5) @(posedge clk);
						enable3 <= 0; repeat(5) @(posedge clk);
						enable3 <= 1; repeat(5) @(posedge clk);
		$stop;
	end

endmodule 