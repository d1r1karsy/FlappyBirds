// Module defining input to be true for only one clock cycle when the key is pressed
module useInput (clk, reset, keyin, keyout);
	input logic clk, reset, keyin;
	output logic keyout;
	
	// State variables
	enum { ZeroZero, ZeroOne } ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
 			ZeroZero: if (keyin)  ns = ZeroOne;
						 else		    ns = ZeroZero;
			ZeroOne:  if (~keyin) ns = ZeroZero;
						 else		    ns = ZeroOne;
		endcase
	end

	// Output logic
	assign keyout = (ps == ZeroZero) & (ns == ZeroOne);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= ZeroZero;
		else
			ps <= ns;
	end
	
endmodule 

// Test the useInput module
module useInput_testbench();
	logic clk, reset, keyin;
	logic keyout;
	
	useInput dut (.clk, .reset, .keyin, .keyout);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
										@(posedge clk);
		reset <= 1;					@(posedge clk);
										@(posedge clk);
		reset <= 0; keyin <= 0;	@(posedge clk);
						keyin <= 1;	@(posedge clk);
						keyin <= 0;	@(posedge clk);
						keyin <= 1;	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
						keyin <= 0;	@(posedge clk);
										@(posedge clk);
		$stop;
	end
	
endmodule 