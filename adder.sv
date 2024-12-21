module adder(a,b,s);
   input logic [31:0]a,b;
	output logic [31:0]s;
	
	assign s=a+b;
	
endmodule