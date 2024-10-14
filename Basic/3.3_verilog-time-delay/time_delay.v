`timescale 1ns/1ns

module time_delay_module(
			 input ai, bi,
			 output so_lose, so_get, so_normal
			 );

   assign #20 so_lose   = ai & bi;
   assign #5  so_get    = ai & bi;
   assign     so_normal = ai & bi;

endmodule

module testbench;
   reg ai, bi;
   wire so_lose, so_get, so_normal;

   initial begin
      ai = 0;
      #25; ai = 1;
      #35; ai = 0;
      #40; ai = 1;
      #10; ai = 0;
   end

   initial begin
      bi = 1;
      #70; bi = 0;
      #20; bi = 1;
   end

   time_delay_module u_wire_delay(
				  .ai(ai),
				  .bi(bi),
				  .so_lose(so_lose),
				  .so_get(so_get),
				  .so_normal(so_normal)
				  );

   initial begin
      forever begin
	 #100;    /* error here */
	 if ($time >= 1000) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, u_wire_delay);
   end

endmodule
