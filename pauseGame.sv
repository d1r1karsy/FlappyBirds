// Module displaying a pause symbol on the LED screen when the game is paused
module pauseGame (pause, red_array, green_array, red_array1, green_array1);
	input  logic pause;
	input  logic [7:0][7:0] red_array,  green_array;
	output logic [7:0][7:0] red_array1, green_array1;
	logic 		 [7:0][7:0] red_array2, green_array2;

	assign red_array2[0]   = 8'b00000000;
	assign red_array2[1]   = 8'b00011011;
	assign red_array2[2]   = 8'b00011011;
	assign red_array2[3]   = 8'b00011011;
	assign red_array2[4]   = 8'b00011011;
	assign red_array2[5]   = 8'b00011011;
	assign red_array2[6]   = 8'b00011011;
	assign red_array2[7]   = 8'b00000000;
	assign green_array2[0] = 8'b00000000;
	assign green_array2[1] = 8'b00011011;
	assign green_array2[2] = 8'b00011011;
	assign green_array2[3] = 8'b00011011;
	assign green_array2[4] = 8'b00011011;
	assign green_array2[5] = 8'b00011011;
	assign green_array2[6] = 8'b00011011;
	assign green_array2[7] = 8'b00000000;
	
	always_comb begin
		if (pause) begin 
			red_array1   = red_array2;
			green_array1 = green_array2;
		end
		else begin 
			red_array1   = red_array;
			green_array1 = green_array;
		end
	end
	
endmodule 

// Test the pauseGame module
module pauseGame_testbench();
   logic pause;
   logic [7:0][7:0] red_array,  green_array;
	logic [7:0][7:0] red_array1, green_array1;
	
	pauseGame (.pause, .red_array, .green_array, .red_array1, .green_array1);
	
	integer row, col;
	initial begin
		for(row = 0; row < 8; row++) begin
         for (col = 0; col < 256; col++) begin
				red_array[row] = col; green_array[row] = col; #10;
			end
      end
	end
	
endmodule 