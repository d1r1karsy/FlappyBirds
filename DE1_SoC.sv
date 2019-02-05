// Top-level module defining I/Os for the DE1_SoC board
module  DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);   
   input  logic         CLOCK_50; // 50MHz clock.   
   output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;     
   output logic  [9:0]  LEDR; 
	output logic  [35:0] GPIO_0;
   input  logic  [3:0]  KEY; 
   input  logic  [9:0]  SW;  
	
	// Create the local variables used in the module
	logic key0, key0_1, sw0, sw0_0, pause, pause_0, reset, input1, input2, enable2, enable3, out_of_bounds, dead, init8, init7, init6, init5, init4, init3, init2, init1, out0, out1, out2, out3;
	logic [7:0][7:0] green_array, red_array, green_array1, red_array1;
	logic [3:0] hex0, hex1, hex2, hex3;
	
	// Default values for unused outputs
	assign LEDR[9:0] = 10'b0000000000;
	assign GPIO_0[11:0] = 12'b000000000000;
	assign red_array[0][7] 	 = 1'b0;
	assign red_array[0][5:0] = 6'b000000;
	assign red_array[1][7] 	 = 1'b0;
	assign red_array[1][5:0] = 6'b000000;
	assign red_array[2][7] 	 = 1'b0;
	assign red_array[2][5:0] = 6'b000000;
	assign red_array[3][7] 	 = 1'b0;
	assign red_array[3][5:0] = 6'b000000;
	assign red_array[4][7] 	 = 1'b0;
	assign red_array[4][5:0] = 6'b000000;
	assign red_array[5][7] 	 = 1'b0;
	assign red_array[5][5:0] = 6'b000000;
	assign red_array[6][7] 	 = 1'b0;
	assign red_array[6][5:0] = 6'b000000;
	assign red_array[7][7] 	 = 1'b0;
	assign red_array[7][5:0] = 6'b000000;
	
	// Generate clk off of CLOCK_50, whichClock picks rate. 
   logic [31:0] clk;  
   parameter whichClock = 14;  
   clock_divider cdiv (CLOCK_50, clk); 
		
	// Define the reset switch
	assign reset = SW[9];

	// Put the user inputs through 2 DFFs.
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			key0 <= 1'b1;
			sw0  <= 1'b0;
			pause <= 1'b0;
		end
		else begin
			key0_1 <= KEY[0];
			key0   <= key0_1;
			sw0_0  <= SW[0];
			sw0    <= sw0_0;
			pause_0 <= SW[1];
			pause  <= pause_0;
		end
	end
		
	// User input only true for 1 clock cycle when a key is pressed and generate computer input
	useInput player 	  (.clk(clk[whichClock]), .reset, .keyin(~key0), .keyout(input1));
	
	// Slow down circuit clock
	counter1 countone   (.clk(clk[whichClock]), .reset, .pause, .enable(input2));
	counter2 counttwo   (.clk(clk[whichClock]), .reset, .pause, .enable(enable2));
	counter3 countthree (.clk(clk[whichClock]), .reset, .pause, .enable(enable3));
	
	// Generate the location of the bird on the LED display
	normalLight bird8 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(1'b0), 			  .bottom(red_array[6][6]), .light(red_array[7][6]));
	normalLight bird7 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[7][6]), .bottom(red_array[5][6]), .light(red_array[6][6]));
	normalLight bird6 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[6][6]), .bottom(red_array[4][6]), .light(red_array[5][6]));
	centerLight bird5 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[5][6]), .bottom(red_array[3][6]), .light(red_array[4][6]));
	normalLight bird4 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[4][6]), .bottom(red_array[2][6]), .light(red_array[3][6]));
	normalLight bird3 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[3][6]), .bottom(red_array[1][6]), .light(red_array[2][6]));
	normalLight bird2 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[2][6]), .bottom(red_array[0][6]), .light(red_array[1][6]));
	normalLight bird1 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .key(input1), .gravity(input2), .top(red_array[1][6]), .bottom(1'b0), 			    .light(red_array[0][6]));
	
	// Check if the bird has gone out of bounds
	bounds dead1 (.clk(clk[whichClock]), .reset, .key(input1), .gravity(input2), .top(red_array[7][6]), .bottom(red_array[0][6]), .out_of_bounds);
	
	// Generae barriers and move them accross the LED display
	startColumn initialcol  (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .enable3, .light8(init8), .light7(init7), .light6(init6), .light5(init5), .light4(init4), .light3(init3), .light2(init2), .light1(init1));
	normalColumn col1 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(init8), .ol7(init7), .ol6(init6), .ol5(init5), .ol4(init4), .ol3(init3), .ol2(init2), .ol1(init1), 
							 .light8(green_array[7][0]), .light7(green_array[6][0]), .light6(green_array[5][0]), .light5(green_array[4][0]), .light4(green_array[3][0]), .light3(green_array[2][0]), .light2(green_array[1][0]), .light1(green_array[0][0]));	
	normalColumn col2 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][0]), .ol7(green_array[6][0]), .ol6(green_array[5][0]), .ol5(green_array[4][0]), .ol4(green_array[3][0]), .ol3(green_array[2][0]), .ol2(green_array[1][0]), .ol1(green_array[0][0]), 
							 .light8(green_array[7][1]), .light7(green_array[6][1]), .light6(green_array[5][1]), .light5(green_array[4][1]), .light4(green_array[3][1]), .light3(green_array[2][1]), .light2(green_array[1][1]), .light1(green_array[0][1]));
	normalColumn col3 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][1]), .ol7(green_array[6][1]), .ol6(green_array[5][1]), .ol5(green_array[4][1]), .ol4(green_array[3][1]), .ol3(green_array[2][1]), .ol2(green_array[1][1]), .ol1(green_array[0][1]), 
							 .light8(green_array[7][2]), .light7(green_array[6][2]), .light6(green_array[5][2]), .light5(green_array[4][2]), .light4(green_array[3][2]), .light3(green_array[2][2]), .light2(green_array[1][2]), .light1(green_array[0][2]));
	normalColumn col4 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][2]), .ol7(green_array[6][2]), .ol6(green_array[5][2]), .ol5(green_array[4][2]), .ol4(green_array[3][2]), .ol3(green_array[2][2]), .ol2(green_array[1][2]), .ol1(green_array[0][2]), 
							 .light8(green_array[7][3]), .light7(green_array[6][3]), .light6(green_array[5][3]), .light5(green_array[4][3]), .light4(green_array[3][3]), .light3(green_array[2][3]), .light2(green_array[1][3]), .light1(green_array[0][3]));
	normalColumn col5 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][3]), .ol7(green_array[6][3]), .ol6(green_array[5][3]), .ol5(green_array[4][3]), .ol4(green_array[3][3]), .ol3(green_array[2][3]), .ol2(green_array[1][3]), .ol1(green_array[0][3]), 
							 .light8(green_array[7][4]), .light7(green_array[6][4]), .light6(green_array[5][4]), .light5(green_array[4][4]), .light4(green_array[3][4]), .light3(green_array[2][4]), .light2(green_array[1][4]), .light1(green_array[0][4]));
	normalColumn col6 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][4]), .ol7(green_array[6][4]), .ol6(green_array[5][4]), .ol5(green_array[4][4]), .ol4(green_array[3][4]), .ol3(green_array[2][4]), .ol2(green_array[1][4]), .ol1(green_array[0][4]), 
							 .light8(green_array[7][5]), .light7(green_array[6][5]), .light6(green_array[5][5]), .light5(green_array[4][5]), .light4(green_array[3][5]), .light3(green_array[2][5]), .light2(green_array[1][5]), .light1(green_array[0][5]));
	normalColumn col7 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][5]), .ol7(green_array[6][5]), .ol6(green_array[5][5]), .ol5(green_array[4][5]), .ol4(green_array[3][5]), .ol3(green_array[2][5]), .ol2(green_array[1][5]), .ol1(green_array[0][5]), 
						    .light8(green_array[7][6]), .light7(green_array[6][6]), .light6(green_array[5][6]), .light5(green_array[4][6]), .light4(green_array[3][6]), .light3(green_array[2][6]), .light2(green_array[1][6]), .light1(green_array[0][6]));
	normalColumn col8 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .pause, .enable2, .ol8(green_array[7][6]), .ol7(green_array[6][6]), .ol6(green_array[5][6]), .ol5(green_array[4][6]), .ol4(green_array[3][6]), .ol3(green_array[2][6]), .ol2(green_array[1][6]), .ol1(green_array[0][6]), 
							 .light8(green_array[7][7]), .light7(green_array[6][7]), .light6(green_array[5][7]), .light5(green_array[4][7]), .light4(green_array[3][7]), .light3(green_array[2][7]), .light2(green_array[1][7]), .light1(green_array[0][7]));
	
	// Check if the bird has ran into a barrier
	collision dead2 (.red_array, .green_array, .dead);
	
	// Keep track of the current game's score on the HEX display
	score     s0 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .green_array, .enable(enable2), .hex(hex0), .out(out0));
	increment s1 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .in(out0), 	  .hex(hex1), .out(out1));
	increment s2 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .in(out1), 	  .hex(hex2), .out(out2));
	increment s3 (.clk(clk[whichClock]), .reset(reset | out_of_bounds | dead), .in(out2), 	  .hex(hex3), .out(out3));
	
	// Display the high score when SW0 is on
	highscore hi (.reset, .on(sw0), .hex0, .hex1, .hex2, .hex3, .out0(HEX0), .out1(HEX1), .out2(HEX2), .out3(HEX3), .out4(HEX4), .out5(HEX5));
		
	// Display a pause symbol in the display
	pauseGame stop (.pause, .red_array, .green_array, .red_array1, .green_array1);	
		
	// Output which LEDs are supposed to be on	
	matrix_driver out (.clk(clk[whichClock]), .red_array(red_array1), .green_array(green_array1), .red_driver(GPIO_0[27:20]), .green_driver(GPIO_0[35:28]), .row_sink(GPIO_0[19:12]));
	
endmodule 

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...    
module clock_divider (clock, divided_clocks); 
   input  logic          clock;  
   output logic  [31:0]  divided_clocks = 0;
	
   always_ff @(posedge clock) begin  
      divided_clocks <= divided_clocks + 1;   
   end    
	
endmodule 

// Test the DE1_SoC module
module DE1_SoC_testbench();
   logic         clk;  
   logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;     
   logic  [9:0]  LEDR;        
   logic  [3:0]  KEY; 
   logic  [9:0]  SW; 
	logic  [35:0] GPIO_0;
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .GPIO_0);
	
	// Setup the test clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Setup the inputs to the design
	initial begin
																			repeat(10)  @(posedge clk);
		SW[9] <= 1;														repeat(40)  @(posedge clk);
		SW[9] <= 0; KEY[0] <= 1; SW[0] <= 0; SW[1] <= 0;	repeat(160) @(posedge clk);
						KEY[0] <= 0;				 					repeat(10)  @(posedge clk);
						KEY[0] <= 1; 				 SW[1] <= 1;	repeat(100) @(posedge clk);
														 SW[1] <= 0;	repeat(10)  @(posedge clk);
						KEY[0] <= 0;									repeat(40)  @(posedge clk);
						KEY[0] <= 1; SW[0] <= 1;					repeat(100) @(posedge clk);
										 SW[0] <= 0;					repeat(10)  @(posedge clk);
																			repeat(250) @(posedge clk);
		$stop;
	end
	
endmodule  
     