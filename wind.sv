module wind (clk, reset, in, out);  
   input  logic  clk, reset;
	input  logic [1:0] in;
   output logic [2:0] out;
	
   // State variables.   
   enum { A, B, C, D } ps, ns; 
   
   // Next State logic (30-26)+(28-26) with the else  
   always_comb begin
      case (ps)    
         A: if (~in[1] & ~in[0]) ns = B; 
				else if (~in[1] & in[0]) ns = C;
				else if (in[1] & ~in[0]) ns = D;
				else ns = A;
         B: if (~in[1] & ~in[0]) ns = A;
				else if ((~in[1] & in[0]) | (in[1] & ~in[0])) ns = D;
				else ns = B;  
			C: if (~in[1] & in[0]) ns = D;
				else if ((~in[1] & ~in[0]) | (in[1] & ~in[0])) ns = A;
				else ns = C;
			D: if ((in[1] & ~in[0])) ns = C; 
				else if ((~in[1] & ~in[0]) | (~in[1] & in[0])) ns = A;
				else ns = D;
      endcase   
   end  
	
   // Output logic
	assign out[2] = (ps == B) | (ps == C);  
	assign out[1] = (ps == A);  
	assign out[0] = (ps == B) | (ps == D); 
	
   // DFFs   
   always_ff @(posedge clk) begin      
		if (reset)
			ps <= A;
		else
			ps <= ns;  		
   end    
endmodule

module wind_testbench();  
   logic  clk, reset;
	logic [1:0] in;
   logic [2:0] out;
	
   wind dut (.clk, .reset, .in, .out);  
	
   // Set up the clock.  
   parameter CLOCK_PERIOD = 100;  
	
   initial begin   
      clk <= 0;    
      forever #(CLOCK_PERIOD/2) clk <= ~clk;  
   end    
	
   // Set up the inputs to the design.  Each line is a clock cycle.   
   initial begin   
										             @(posedge clk);   
		reset <= 1;								    @(posedge clk);		 
		reset <= 0; in[0] <= 0; in[1] <= 0;	 @(posedge clk);     
						            repeat (7)   @(posedge clk);         
						            in[1] <= 1;  @(posedge clk);     
					               repeat (7)   @(posedge clk);      
		            in[0] <= 1; in[1] <= 0;  @(posedge clk);     
					             	repeat (7)   @(posedge clk);  
					             	in[1] <= 1;	 @(posedge clk);
					               repeat (7)   @(posedge clk);  
      $stop; // End the simulation.  
   end    
endmodule