`timescale 1ns/1ns

module test;

   initial begin: runoob // block named runoob, do not forget ':'
      integer i;
      i = 0;
      forever begin
	 #10 i = i+10;
      end
   end

   reg stop_flag;
   initial stop_flag = 1'b0;

   always begin: detect_stop // block named detect_stop
      if (test.runoob.i == 100) begin
	 $display("Now you can stop the simulation!!!");
	 stop_flag = 1'b1;
      end
      #10;
   end

   initial begin
      forever begin
	 #100;
	 if ($time >= 200) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
