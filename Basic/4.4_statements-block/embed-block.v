`timescale 1ns/1ns

module test;

   reg [3:0] ai_sequen2, bi_sequen2;
   reg [3:0] ai_paral2, bi_paral2;

   initial begin
      ai_sequen2 = 4'd5; // at 0ns
      fork
	 #10 ai_paral2 = 4'd5; // at 10ns
	 #15 bi_paral2 = 4'd8; // at 15ns
      join
      #20 bi_sequen2 = 4'd8;   // at 35ns
   end

   initial begin
      forever begin
	 #100;
	 if ($time >= 100) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
