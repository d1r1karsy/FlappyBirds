module bird (clk, reset, col, key, died, light);
	input  logic clk, reset, key, col;
	output logic died;
	output logic [7:0] light;
	
	enum { Stopped, Eight, Seven, Six, Five, Four, Three, Two, One } ps, ns;
	
	always_comb begin
		case (ps)
			Stopped: if 	  (key & ~col)  begin ns = Six; 		light = 8'b00100000; end
						else 						 begin ns = Stopped; light = 8'b00100000; end
			Eight: 	if      (key  & ~col) begin ns = Stopped; light = 8'b00100000; end
						else if (~key & ~col) begin ns = Seven;   light = 8'b01000000; end
						else if (col)      	 begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = Eight;   light = 8'b10000000; end
			Seven: 	if  	  (key & ~col)  begin ns = Eight; 	light = 8'b10000000; end
						else if (~key & ~col) begin ns = Six; 		light = 8'b00100000; end
						else if (col)         begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = Seven;   light = 8'b01000000; end
			Six:		if  	  (key  & ~col) begin ns = Seven; 	light = 8'b01000000; end
						else if (~key & ~col) begin ns = Five; 	light = 8'b00010000; end
						else if (col) 		    begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = Six;     light = 8'b00100000; end
			Five:		if      (key  & ~col) begin ns = Six; 		light = 8'b00100000; end
						else if (~key & ~col) begin ns = Four; 	light = 8'b00001000; end
						else if (col) 	    	 begin ns = Stopped; light = 8'b00100000; end
						else 					    begin ns = Five;    light = 8'b00010000; end
			Four:		if      (key  & ~col) begin ns = Five; 	light = 8'b00010000; end
						else if (~key & ~col) begin ns = Three; 	light = 8'b00000100; end
						else if (col) 	       begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = Four;    light = 8'b00001000; end
			Three:	if      (key & ~col)  begin ns = Four; 	light = 8'b00001000; end
						else if (~key & ~col) begin ns = Two; 		light = 8'b00000010; end
						else if (col) 	       begin ns = Stopped; light = 8'b00100000; end
						else 					    begin ns = Three;   light = 8'b00000100; end
			Two:		if      (key & ~col)  begin ns = Three; 	light = 8'b00000100; end
						else if (~key & ~col) begin ns = One; 		light = 8'b00000001; end
						else if (col) 		    begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = Two;     light = 8'b00000010; end
			One:		if  	  (key & ~col)  begin ns = Two; 		light = 8'b00000010; end
						else if (~key & ~col) begin ns = Stopped; light = 8'b00100000; end
						else if (col) 		    begin ns = Stopped; light = 8'b00100000; end
						else 						 begin ns = One;     light = 8'b00000001; end
		endcase
	end
		
	assign died = (((ps == Eight) & (ns == Stopped)) | ((ps == One) & (ns == Stopped)));
		
	always_ff @(posedge clk) begin
		if (reset)
			ps <= Stopped;
		else
			ps <= ns;
	end
endmodule
	
// Test the bird module
module bird_testbench();
	logic clk, reset, key, enable, col;
	logic died;
	logic [7:0] light;
	
	bird dut (.clk, .reset, .enable, .col, .key, .died, .light);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
										@(posedge clk);
		reset <= 1;	col <= 0;	@(posedge clk);
										@(posedge clk);
		reset <= 0; key <= 0;	repeat(2) @(posedge clk);
						key <= 1;	@(posedge clk);
						key <= 0;	repeat(3) @(posedge clk);
						key <= 1;	repeat(5) @(posedge clk);
						key <= 0;	repeat(10)@(posedge clk);
		$stop;
	end
	
endmodule 