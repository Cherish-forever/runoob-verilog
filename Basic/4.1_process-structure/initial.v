`timescale 1ns/1ns

module test;

   reg ai, bi;

   // assign one by one
   initial begin
      ai = 0;
      #25; ai = 1;
      #35; ai = 0; // absolute 60ns
      #40; ai = 1; // absolute 100ns
      #10; ai = 0; // absolute 110ns
   end

   // each initial not affect each other
   initial begin
      bi = 1;
      #70; bi = 0; // absolute 70ns
      #20; bi = 1; // absolute 90ns
   end

   // end condition
   initial begin
      forever begin
	 #100;
	 if ($time >= 1000) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("initial.vcd");
      $dumpvars(0, test);
   end

endmodule
