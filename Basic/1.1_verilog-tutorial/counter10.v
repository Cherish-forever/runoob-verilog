/*
 4bit decimal counter
 */

module counter10(
		 input rstn,
		 input clk,
		 output [3:0] cnt,
		 output cout
		 );

   reg [3:0] 		cnt_temp;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
	 cnt_temp <= 4'b0;
      end
      else if (cnt_temp == 4'd9) begin
	 cnt_temp <= 4'b0;
      end
      else begin
	 cnt_temp <= cnt_temp + 1'b1;
      end
   end // always @ (posedge clk or negedge rstn)

   assign cout = (cnt_temp == 4'd9);
   assign cnt = cnt_temp;

endmodule

`timescale 1ns/1ps

module testbench;
   reg clk;
   reg rst_n;
   wire [3:0] cnt;
   wire       cout;

   initial begin
      clk = 0;
      rst_n = 0;
      #100.1 rst_n = 1;
      #1000;
      $finish;
   end

   always #10 clk = ~clk;

   counter10 cnt10(
		   .rstn(rst_n),
		   .clk(clk),
		   .cnt(cnt),
		   .cout(cout)
		   );

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, cnt10); //  0: dump all cnt10 signal with it`s submodule signal and submodule in deep stage.
                           //  1: only cnt10 signal without it`s submodule signal.
                           // >1: dump cnt10 signal and it`s submodule signal but without submodule in deep stage.
   end

endmodule
