// Module defining and displaying the number of wins a player has on a 7 segment display 
module winner (clk, reset, this_player, other_player, this_light, number, reset_play);
	input logic clk, reset, this_player, other_player, this_light;
	output logic [6:0] number;
	output logic reset_play;
	
	// State variables
	enum logic[2:0] { ZERO=3'b000, ONE=3'b001, TWO=3'b010, THREE=3'b011, FOUR=3'b100, FIVE=3'b101, SIX=3'b110, SEVEN=3'b111 } ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
 			ZERO: if (this_light & this_player & ~other_player)	ns = ONE;
					else															ns = ZERO;
			ONE:  if (this_light & this_player & ~other_player)	ns = TWO;
					else															ns = ONE;
			TWO: 	if (this_light & this_player & ~other_player)	ns = THREE;
					else															ns = TWO;
			THREE:if (this_light & this_player & ~other_player)	ns = FOUR;
					else															ns = THREE;
			FOUR: if (this_light & this_player & ~other_player)	ns = FIVE;
					else															ns = FOUR;
			FIVE: if (this_light & this_player & ~other_player)	ns = SIX;
					else															ns = FIVE;
			SIX:  if (this_light & this_player & ~other_player)	ns = SEVEN;
					else															ns = SIX;
			SEVEN: 																ns = SEVEN;
		endcase
	end

	// Output logic
	seg7 result (.bcd(ps), .leds(number));
	assign reset_play = (~(ps == ns)) | (reset);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= ZERO;
		else
			ps <= ns;
	end
	
endmodule 

// Test the winner module
module winner_testbench();
	logic clk, reset, this_player, other_player, this_light;
	logic [6:0] number;
	logic reset_play;
	
	winner dut (.clk, .reset, .this_player, .other_player, .this_light, .number, .reset_play);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																												 @(posedge clk);
		reset <= 1;																				repeat(2) @(posedge clk);
		reset <= 0; this_player <= 0; other_player <= 0; this_light <= 0;		repeat(2) @(posedge clk);
						this_player <= 1;							 this_light <= 1; 	repeat(10)@(posedge clk);
		$stop;
	end
	
endmodule 