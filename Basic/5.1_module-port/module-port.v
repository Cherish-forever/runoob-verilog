`timescale 1ns/1ns

module pad(
	   input       DIN, OEN,
	   input [1:0] PULL,
	   inout       PAD,  // inout port
	   output reg  DOUT
	   );

   assign PAD = OEN ? 'bz : DIN; //

   always @(*) begin
      if (OEN == 1) begin
	 DOUT = PAD;
      end
      else begin
	 DOUT = 'bz;
      end
   end

   // use tristate gate in verilog to realize pull/down function
   bufif1 puller(PAD, PULL[0], PULL[1]); // out, in, control

endmodule

module test;

   reg DIN, OEN;
   reg [1:0] PULL;
   wire      PAD;
   wire      DOUT;

   reg 	     PAD_REG;
   assign PAD = OEN ? PAD_REG : 1'bz;

   initial begin
      PAD_REG      = 1'bz;
      OEN          = 1'bz;
      #0;  PULL    = 2'b10;
      #20; PULL    = 2'b11;
      #20; PULL    = 2'b00;
      #20; PAD_REG = 1'b0;
      #20; PAD_REG = 1'b1;

      #30; OEN     = 1'b0;
           DIN     = 1'bz;
      #15; DIN     = 1'b0;
      #15; DIN     = 1'b1;
   end

   pad u_pad(
	     .DIN(DIN),
	     .OEN(OEN),
	     .PULL(PULL),
	     .PAD(PAD),
	     .DOUT(DOUT)
	     );

   initial begin
      forever begin
	 #100;
	 if ($time >= 1000) $finish;
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
