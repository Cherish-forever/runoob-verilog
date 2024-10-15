`timescale 1ns/1ns

module test;

   integer i;
   reg [3:0] counter;
   initial begin
      counter = 4'b0;
      for(i=0; i<=10; i++) begin
	 #10;
	 counter = counter + 1'b1;
      end
   end

   always begin
      #10; if ($time >= 200) $finish;
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
