module mux4to1(
	       input  [3:0] sel,
	       input  [1:0] p0,
	       input  [1:0] p1,
	       input  [1:0] p2,
	       input  [1:0] p3,
	       output [1:0] sout
	       );

   reg [1:0] 		   sout_t;

   always @(*) begin // x: indeterminacy, ?: any value, 0 or 1.
      casez(sel)     // x or ? could not be synthesis, only for simulation.
	4'b???1: sout_t = p0;
	4'b??1?: sout_t = p1;
	4'b?1??: sout_t = p2;
	4'b1???: sout_t = p3;
	default: sout_t = 0;
      endcase
   end

   assign sout = sout_t;

endmodule

`timescale 1ns/1ns

module test;
   reg [3:0] sel;
   wire [1:0] sout;

   initial begin
      sel = 0;
      #10 sel = 8;
      #10 sel = 4;
      #10 sel = 2;
      #10 sel = 1;
   end

   mux4to1 u_mux4to1(
		     .sel(sel),
		     .p0(2'b00),
		     .p1(2'b01),
		     .p2(2'b10),
		     .p3(2'b11),
		     .sout(sout)
		     );

   always begin
      #100;
      if ($time >= 1000) $finish;
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
