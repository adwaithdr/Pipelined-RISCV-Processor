module mux3_1(i0,i1,i2,s,o);

    input logic [31:0]i0,i1,i2;
	 input logic [1:0]s;
	 output logic [31:0]o;
	 
	 
	 assign o = (s== 2'b00) ? i0 : (s == 2'b01) ? i1 : (s == 2'b10) ? i2 : 32'b0;
	 
	 endmodule