`timescale 1ns/1ns

module test;

   initial begin: runoob_d
      integer i_d;
      i_d = 0;
      while (i_d <= 100) begin: runoob_d2 // block named runoob_d2
	 #10;
	 if (i_d >=50) begin
	    disable runoob_d3.clk_gen; // break clk_gen loop
	    disable runoob_d2;         // break it self loop
	 end
	 i_d = i_d + 10;
      end
   end

   reg clk;

   initial begin: runoob_d3          // block named runoob_d3
      while (1) begin: clk_gen       // block named runoob_d3.clk_gen
	 clk = 1; #10;
	 clk = 0; #10;
      end
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
