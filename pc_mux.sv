module pc_mux #(parameter n =32)(i1,i0,s0,o);
  input logic [n-1:0]i1,i0;
  output logic [n-1:0]o;
  input logic s0;
   always_comb begin
	  if (s0 == 0)
	        o=i0;
	  else
	       o=i1;
	end
endmodule