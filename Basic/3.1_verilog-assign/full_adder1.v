module full_adder1(
		   input Ai, Bi, Ci,
		   output So, Co
		   );

   assign {Co, So} = Ai + Bi + Ci;

endmodule // full_adder1

`timescale 1ns/1ns

module testbench;
   reg Ai, Bi, Ci;
   wire So, Co;

   initial begin
      {Ai, Bi, Ci} = 3'b0;
      forever begin
	 #10;
	 {Ai, Bi, Ci} = {Ai, Bi, Ci} + 1'b1;
      end
   end

   full_adder1 u_adder(
		       .Ai(Ai),
		       .Bi(Bi),
		       .Ci(Ci),
		       .So(So),
		       .Co(Co)
		       );

   initial begin
      forever begin
	 #100;
	 if ($time >= 1000) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, u_adder);
   end

endmodule
