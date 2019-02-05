// Checks if the bird flys into a barrier
module collision (red_array, green_array, dead);
	input logic [7:0][7:0] red_array, green_array;
	output logic dead;

	assign dead = ((red_array[7][6] & green_array[7][6]) | (red_array[6][6] & green_array[6][6]) 
					 | (red_array[5][6] & green_array[5][6]) | (red_array[4][6] & green_array[4][6]) 
					 | (red_array[3][6] & green_array[3][6]) | (red_array[2][6] & green_array[2][6]) 
					 | (red_array[1][6] & green_array[1][6]) | (red_array[0][6] & green_array[0][6]));
	
endmodule 

// Test the collision module
module collision_testbench();
	logic [7:0][7:0] red_array, green_array;
	logic dead;
	
	collision dut (.red_array, .green_array, .dead);
	
	initial begin
		red_array[7][6] = 0; green_array[7][6] = 1; #10;
		red_array[7][6] = 1; 								 #10;
		red_array[6][6] = 0; green_array[6][6] = 1; #10;
		red_array[6][6] = 1; 								 #10;
		red_array[5][6] = 0; green_array[5][6] = 1; #10;
		red_array[5][6] = 1; 								 #10;
		red_array[4][6] = 0; green_array[4][6] = 1; #10;
		red_array[4][6] = 1; 								 #10;
		red_array[3][6] = 0; green_array[3][6] = 1; #10;
		red_array[3][6] = 1; 								 #10;
		red_array[2][6] = 0; green_array[2][6] = 1; #10;
		red_array[2][6] = 1; 								 #10;
		red_array[1][6] = 0; green_array[1][6] = 1; #10;
		red_array[1][6] = 1; 								 #10;
		red_array[0][6] = 0; green_array[0][6] = 1; #10;
		red_array[0][6] = 1; 								 #10;
	end

endmodule 