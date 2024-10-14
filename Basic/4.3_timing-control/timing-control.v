`timescale 1ns/1ns

module test;
   reg value_test;
   reg value_general, value_embed, value_single;

   initial begin
      value_test = 0;
      #25; value_test = 1; // absolute 25ns
      #35; value_test = 0; // absolute 60ns
      #40; value_test = 1; // absolute 100ns
      #10; value_test = 0; // absolute 110ns
   end

   // delay then assign
   initial begin
      value_general = 1;
      #10; value_general = value_test; // 10ns, value_test = 0
      #45; value_general = value_test; // 55ns, value_test = 1
      #30; value_general = value_test; // 85ns, value_test = 0
      #20; value_general = value_test; // 105ns, value_test = 1
   end

   // record value, delay then assign record value
   initial begin
      value_embed = 1;
      value_embed = #10 value_test; // 0ns, value_test = 0
      value_embed = #45 value_test; // 10ns, value_test = 0
      value_embed = #30 value_test; // 55ns, value_test = 1
      value_embed = #20 value_test; // 85ns, value_test = 1
   end

   initial begin
      value_single = 1;
      #10;
      value_single = value_test; // 10ns, value_test = 0
      #45;
      value_single = value_test; // 55ns, value_test = 0
      #30;
      value_single = value_test; // 85ns, value_test = 0
      #20;
      value_single = value_test; // 105ns, value_test = 0
   end // initial begin

   always begin
     #10
       if($time >= 150) begin
	  $finish;
       end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
