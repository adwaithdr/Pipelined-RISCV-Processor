module sign_extend(Instrd,Immsrc,Immextd);
       input logic [31:0]Instrd;
		 output logic [31:0]Immextd;
		 input logic [1:0]Immsrc;
		 always_comb begin
		    if (Immsrc == 2'b00 ) begin
			      Immextd ={{20{Instrd[31]}},Instrd[31:20]};
					end
			 else if (Immsrc == 2'b01) begin
			       Immextd ={{20{Instrd[31]}},Instrd[31:25],Instrd[11:7]};
					 end
			  else begin
			        Immextd = 32'b0;
					  end
			end
endmodule