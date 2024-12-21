module main_decoder(opcode,resultsrc,immsrc,
             memwrite,
				 regwrite,alusrc,aluop,
				 branch); 
				 
	  input logic [6:0]opcode;

	  output logic memwrite,regwrite,alusrc,branch;
	   output logic [1:0]aluop,resultsrc,immsrc;
		 
		always_comb begin
		   if (opcode == 7'b0000011) begin
		
			      regwrite= 1;
					immsrc=2'b00;
					alusrc=1;
					memwrite=0;
					resultsrc=2'b01;
					branch=0;
					aluop=2'b00;
					end
			 else if (opcode == 7'b0100011) begin
		
			      regwrite= 0;
					immsrc=2'b01;
					alusrc=1;
					memwrite=1;
					resultsrc=0;
					branch=0;
					aluop=2'b00;
					end
			 else if (opcode == 7'b0110011) begin
		
			      regwrite= 1;
					immsrc=2'b00;
					alusrc=0;
					memwrite=0;
					resultsrc=0;
					branch=0;
					aluop=2'b10;
					end
			 else  begin
		
			      regwrite= 0;
					immsrc=2'b10;
					alusrc=0;
					memwrite=0;
					resultsrc=0;
					branch=1;
					aluop=2'b01;
					end
		
			 end
	endmodule
		  