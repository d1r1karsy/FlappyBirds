// Compare two 4-bit inputs and output true if the first one is greater than the second one
module compare (reset, hex0, hex1, hex2, hex3, hi0, hi1, hi2, hi3, out0, out1, out2, out3); 
	input logic reset;
	input logic [3:0] hex0, hex1, hex2, hex3, hi0, hi1, hi2, hi3;
	output logic [3:0] out0, out1, out2, out3;
	
	always_comb begin
		if (reset) begin
			out3 = 1'b0000;
			out2 = 1'b0000;
			out1 = 1'b0000;
			out0 = 1'b0000;
		end
		else begin
			if((hex3 > hi3) | 
			  ((hex3 == hi3) & (hex2 > hi2)) | 
			  ((hex3 == hi3) & (hex2 == hi2) & (hex1 > hi1)) | 
			  ((hex3 == hi3) & (hex2 == hi2) & (hex1 == hi1) & (hex0 > hi0))) begin
				out3 = hex3;
				out2 = hex2;
				out1 = hex1;
				out0 = hex0;
			end
			else begin
				out3 = hi3;
				out2 = hi2;
				out1 = hi1;
				out0 = hi0;
			end
		end
	end

endmodule 

// Test the compare module.
module compare_testbench();
	logic [3:0] hex0, hex1, hex2, hex3, hi0, hi1, hi2, hi3, out0, out1, out2, out3;
	logic reset;
	
	compare dut (.reset, .hex0, .hex1, .hex2, .hex3, .hi0, .hi1, .hi2, .hi3, .out0, .out1, .out2, .out3);
	
	initial begin
		hex0 = 4'b1001; hi0 = 4'b0101; 
		hex1 = 4'b1001; hi1 = 4'b0000; 
		hex2 = 4'b0000; hi2 = 4'b0000; 
		hex3 = 4'b1111; hi3 = 4'b0000; #10;
	   hex0 = 4'b1001; hi0 = 4'b1001; 
		hex1 = 4'b1001; hi1 = 4'b0000; 
		hex2 = 4'b0000; hi2 = 4'b0000; 
		hex3 = 4'b1111; hi3 = 4'b0000; #10;
	end
endmodule
