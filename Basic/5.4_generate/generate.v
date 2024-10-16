module full_adder1(
		   input Ai, Bi, Ci,
		   output So, Co
		   );

   assign {Co, So} = Ai + Bi + Ci;

endmodule // full_adder1

module full_adder4(
		   input [3:0] a,
		   input [3:0] b,
		   input c,
		   output [3:0] so,
		   output co
		   );

   wire [3:0] 		  co_temp;

   genvar 		  i;
   generate
      for (i=0; i<4; i=i+1) begin: adder_gen
	 full_adder1 u_adder(
			     .Ai(a[i]),
			     .Bi(b[i]),
			     .Ci((i==0) ? c : co_temp[i-1]),
			     .So(so[i]),
			     .Co(co_temp[i])
			     );
      end
   endgenerate

   assign co = co_temp[3];

endmodule

`timescale 1ns/1ns

module test;

   reg  [3:0] a;
   reg  [3:0] b;
   wire [3:0] so;
   wire       co;

   initial begin
      a = 4'd5;
      b = 4'd2;
      #10;
      a = 4'd10;
      b = 4'd8;
   end

   full_adder4 u_adder4(
			.a(a),
			.b(b),
			.c(1'b0),
			.so(so),
			.co(co)
			);

   initial begin
      forever begin
	 #100;
	 if ($time >= 1000) $finish;
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
