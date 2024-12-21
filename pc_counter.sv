module pc_counter(clk,rst,pc,pc_next);
    input logic clk,rst;
	 output logic [31:0]pc;
	 input logic [31:0]pc_next;
	 always_ff@(posedge clk) begin
	 
	     if(rst==1'b0)
		       pc<=32'b0;
				 
		  else
		       pc<=pc_next;
		end
endmodule