// Module displaying the high score user has achieved so far
module highscore (reset, on, hex0, hex1, hex2, hex3, out0, out1, out2, out3, out4, out5);
	input logic reset, on;
	input logic  [3:0] hex0, hex1, hex2, hex3;
	output logic [6:0] out0, out1, out2, out3, out4, out5;
	logic [3:0] hi0, hi1, hi2, hi3, pick0, pick1, pick2, pick3;
	
	compare com0 (.reset, .hex0, .hex1, .hex2, .hex3, .hi0, .hi1, .hi2, .hi3, .out0(hi0), .out1(hi1), .out2(hi2), .out3(hi3));
	
	always_comb begin
		if (on) begin
			pick0 = hi0;
			pick1 = hi1;
			pick2 = hi2;
			pick3 = hi3;
			out4 = 7'b1111001;
			out5 = 7'b0001001;
		end
		else begin
			pick0 = hex0;
			pick1 = hex1;
			pick2 = hex2;
			pick3 = hex3;
			out4  = 7'b1111111;
			out5  = 7'b1111111;
		end
	end
	
	// Output the score to the HEXs
	seg7 seg0 (.bcd(pick0), .leds(out0));
	seg7 seg1 (.bcd(pick1), .leds(out1));
	seg7 seg2 (.bcd(pick2), .leds(out2));
	seg7 seg3 (.bcd(pick3), .leds(out3));
	
endmodule

// Test the highscore module
module highscore_testbench();
	logic reset, on;
	logic [3:0] hex0, hex1, hex2, hex3;
	logic [6:0] out0, out1, out2, out3, out4, out5;
	
	highscore dut (.reset, .on, .hex0, .hex1, .hex2, .hex3, .out0, .out1, .out2, .out3, .out4, .out5);
	
	integer i;
	initial begin
		for(i = 0; i < 65536; i++) begin
         { hex0[3:0], hex1[3:0], hex2[3:0], hex3[3:0] } = i; on = 0; #10;
																				 on = 1; #10;							
      end
   end
endmodule 