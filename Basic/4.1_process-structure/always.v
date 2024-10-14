`timescale 1ns/1ns

module test;

   parameter CLK_FREQ = 100; // 100MHZ
   parameter CLK_CYCLE = 1e9 / (CLK_FREQ * 1e6); // Switch to ns

   reg clk;
   initial clk = 1'b0;
   always #(CLK_CYCLE/2) clk = ~clk;

   always begin
      #10
	if ($time >= 1000) begin
	   $finish;
	end
   end

   initial begin
      $dumpfile("always.vcd");
      $dumpvars(0, test);
   end

endmodule
