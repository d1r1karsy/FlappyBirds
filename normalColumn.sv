// Module defining the led columns and moving barriers across the game
module normalColumn (clk, reset, pause, enable2, ol8, ol7, ol6, ol5, ol4, ol3, ol2, ol1, light8, light7, light6, light5, light4, light3, light2, light1);
	input logic clk, reset, pause, enable2, ol8, ol7, ol6, ol5, ol4, ol3, ol2, ol1;
	output logic light8, light7, light6, light5, light4, light3, light2, light1;
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset) begin
			light8 <= 1'b0; 
			light7 <= 1'b0; 
			light6 <= 1'b0; 
			light5 <= 1'b0; 
			light4 <= 1'b0; 
			light3 <= 1'b0; 
			light2 <= 1'b0; 
			light1 <= 1'b0;
		end
		else if (enable2 & ~pause) begin
			light8 <= ol8; 
			light7 <= ol7; 
			light6 <= ol6; 
			light5 <= ol5; 
			light4 <= ol4; 
			light3 <= ol3; 
			light2 <= ol2; 
			light1 <= ol1;
		end
		else begin
			light8 <= light8; 
			light7 <= light7; 
			light6 <= light6; 
			light5 <= light5; 
			light4 <= light4; 
			light3 <= light3; 
			light2 <= light2; 
			light1 <= light1;
		end
	end
	
endmodule 

// Test the normalColumn module
module normalColumn_testbench();
	logic clk, reset, pause, enable2, ol8, ol7, ol6, ol5, ol4, ol3, ol2, ol1;
	logic light8, light7, light6, light5, light4, light3, light2, light1;

	normalColumn dut (.clk, .reset, .pause, .enable2, .ol8, .ol7, .ol6, .ol5, .ol4, .ol3, .ol2, .ol1, .light8, .light7, .light6, .light5, .light4, .light3, .light2, .light1);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																																												@(posedge clk);
		reset <= 1;					    																																	@(posedge clk);
		reset <= 0; enable2 <= 0; ol8 <= 0; ol8 <= 0; ol7 <= 0; ol6 <= 0; ol5 <= 0; ol4 <= 0; ol3 <= 0; ol2 <= 0; ol1 <= 0; repeat(5) @(posedge clk);
						enable2 <= 1; 																														  repeat(5) @(posedge clk);
						enable2 <= 0; ol8 <= 0; ol8 <= 1; ol7 <= 1; ol6 <= 0; ol5 <= 1; ol4 <= 1; ol3 <= 0; ol2 <= 1; ol1 <= 1; repeat(5) @(posedge clk);
						enable2 <= 1; 																														  repeat(5) @(posedge clk);
						enable2 <= 0; ol8 <= 0; ol8 <= 0; ol7 <= 0; ol6 <= 0; ol5 <= 0; ol4 <= 0; ol3 <= 0; ol2 <= 0; ol1 <= 0; repeat(5) @(posedge clk);
						enable2 <= 1; 																														  repeat(5) @(posedge clk);
						enable2 <= 0; ol8 <= 0; ol8 <= 1; ol7 <= 1; ol6 <= 1; ol5 <= 1; ol4 <= 1; ol3 <= 1; ol2 <= 1; ol1 <= 1; repeat(5) @(posedge clk);
						enable2 <= 1; 																														  repeat(5) @(posedge clk);
		$stop;
	end

endmodule 