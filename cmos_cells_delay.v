
module BUF(A, Y);
input A;
output Y;
assign Y = A;
endmodule

module NOT(A, Y);
input A;
output Y;
assign #(1:1:3, 1:1:3)  Y = ~A;
endmodule

module NAND(A, B, Y);
input A, B;
output Y;
assign #(1:2.9:5.2, 1:2.9:5.2)  Y = ~(A & B);
endmodule

module NOR(A, B, Y);
input A, B;
output Y;
assign #(1:2.9:4.2, 1:2.9:4.2) Y = ~(A | B);
endmodule

module DFF(C, D, Q);
input C, D;
output reg Q;
always @(posedge C)
	#3.1 Q <= D;
endmodule

module DFFSR(C, D, Q, S, R);
input C, D, S, R;
output reg Q;
always @(posedge C, posedge S, posedge R)
	if (S)
		#3.1 Q <= 1'b1;
	else if (R)
		#3.1 Q <= 1'b0;
	else
		#3.1 Q <= D;
endmodule

