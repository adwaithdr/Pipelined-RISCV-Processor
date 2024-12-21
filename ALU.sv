
module ALU(A,B,control,result,zero);

    input logic [31:0]A,B;
    input logic[2:0]control;
    output logic zero;
    output logic[31:0]result;
  logic [31:0]Sum;
    logic Cout;

    assign Sum = (control[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign {Cout,result} = (control == 3'b000) ? Sum :
                           (control == 3'b001) ? Sum :
                           (control == 3'b010) ? A & B :
                           (control == 3'b011) ? A | B :
                           (control == 3'b101) ? {{32{1'b0}},(Sum[31])} :
                           {33{1'b0}};
  
    assign zero = &(~result);
 

endmodule
		