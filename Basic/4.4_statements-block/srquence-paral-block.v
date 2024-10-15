`timescale 1ns/1ns

module test;

   reg [3:0] ai_sequen, bi_sequen;
   reg [3:0] ai_paral, bi_paral;
   reg [3:0] ai_nonblk, bi_nonblk;

   // execute step by step
   initial begin
      #5 ai_sequen = 4'd5; // at 5ns
      #5 bi_sequen = 4'd8; // at 10ns
   end

   // execute paral
   initial fork
      #5 ai_paral = 4'd5; // at 5ns
      #5 bi_paral = 4'd8; // at 5ns
   join

   initial fork
      #5 ai_nonblk <= 4'd5; // at 5ns
      #5 bi_nonblk <= 4'd8; // at 5ns
   join

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
