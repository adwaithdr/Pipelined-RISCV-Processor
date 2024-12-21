module register_file(A1,A2,A3,WD3,clk,rst,WE3,RD1,RD2);
     input logic [4:0]A1,A2,A3;
	  input logic clk,rst;
	  logic [31:0]regfile[31:0];//intializing a random memory
	  input logic WE3;
	  input logic [31:0]WD3;
	  
	  output logic [31:0]RD1,RD2;
	  
	  assign RD1 = (rst == 1) ? regfile[A1]:32'b0;
	  assign RD2 = (rst == 1) ? regfile[A2]:32'b0;
	  
	 	
	  always_ff@(posedge clk) begin
	  
			if (rst) begin
			   regfile[9]<=32'd412;
				end
			
			else if (WE3)
			    regfile[A3]<=WD3;
		end
endmodule