module alu_decoder(funct3,funct7,
                 op5,aluop,
					  alucontrol);
			input logic [2:0]funct3;
		input logic [6:0]funct7;
		input logic [1:0]aluop;
		input logic op5;
		output logic [2:0]alucontrol;
	
		assign alucontrol = (aluop == 2'b00) ? 3'b000 :
		                    (aluop == 2'b01) ? 3'b001 :
								  (aluop == 2'b10 && ({op5,funct7[5]}!== 2'b11) && funct3==3'b000) ? 3'b000 :
								  (aluop == 2'b10 && funct3 ==3'b000 && {op5,funct7[5]} == 2'b11) ? 3'b001 :
								  (aluop == 2'b10 && funct3 == 3'b010) ? 3'b101 :
								  (aluop == 2'b10 && funct3 == 3'b110) ? 3'b011:
								  (aluop == 2'b10 && funct3 == 3'b111) ? 3'b010: 3'b000;
    
endmodule