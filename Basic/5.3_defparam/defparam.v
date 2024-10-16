module ram_4x4 (
		input CLK,
		input [4-1:0] A,                    // mem array idx
		input [4-1:0] D,                    // mem write data
		input EN,
		input WR,
		output reg [4-1:0] Q               // mem read data
		);

   parameter MASK = 3;

   reg [4-1:0] 			   mem [0:(1<<4)-1]; // mem array len is 16, item is 4bits.
   always @(posedge CLK) begin
      if (EN && WR) begin
	 mem[A] <= D & MASK;
      end
      else if (EN && !WR) begin
	 Q <= mem[A] & MASK;
      end
   end

endmodule

`timescale 1ns/1ns

module test;

   parameter AW = 4;
   parameter DW = 4;

   reg clk;
   reg [AW:0]     a;
   reg [DW-1:0]   d;
   reg 		  en;
   reg 		  wr;
   wire [DW-1:0]  q;

   always begin
      #15; clk = 0;
      #15; clk = 1;
   end

   initial begin
      a  = 10;
      d  = 2;
      en = 'b0;
      wr = 'b0;
      repeat(10) begin
	 @(negedge clk);
	 en = 1'b1;  // enable
	 a  = a + 1; // address: B, C, D, E, F, 0, 1, 2, 3, 5
	 wr = 1'b1;  // write command
	 d = d + 1;  // data:    3, 4, 5, 6, 7, 0, 1, 2, 3, 4
      end
      a = 10;
      repeat(10) begin
	 @(negedge clk);
	 a = a + 1; // B, C, D, E, F, 0, 1, 2, 3, 4
	 wr = 1'b0; // read
	            // 3, 4, 5, 6, 7, 0, 1, 2, 3, 4
      end
   end // initial begin

   defparam u_ram_4x4.MASK = 7; // change u_ram_4x4 MASK;
   ram_4x4  u_ram_4x4 (
		       .CLK(clk),
		       .A(a[AW-1:0]),
		       .D(d),
		       .EN(en),
		       .WR(wr),
		       .Q(q)
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
