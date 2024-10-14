`timescale 1ns/1ns

module test;
   reg [3:0] ai, bi;
   reg [3:0] ai2, bi2;
   reg [3:0] value_blk;
   reg [3:0] value_non;
   reg [3:0] value_non2;

   initial begin

      ai  = 4'd1;
      bi  = 4'd2;
      ai2 = 4'd7;
      bi2 = 4'd8;
      # 20;

      // non-block-assigment with block-assignment
      ai = 4'd3;
      bi = 4'd4;
      value_blk = ai + bi;
      value_non <= ai + bi;

      // non-block-assignment itself
      ai2 <= 4'd5;
      bi2 <= 4'd6;
      value_non2 <= ai2 + bi2;

   end

   always begin
      #10;
      if ($time >= 1000) $finish;
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
