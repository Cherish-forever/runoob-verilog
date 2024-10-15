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

endmodule // counter10

`timescale 1ns/1ns

module test;
   reg clk;
   reg rstn;
   wire [3:0] cnt;
   wire       cout;

   counter10 u_couner(
		   .rstn(rstn),
		   .clk(clk),
		   .cnt(cnt),
		   .cout(cout)
		   );

   initial begin
      clk = 0;
      rstn = 0;
      #10;
      rstn = 1'b1;
      wait (test.u_couner.cnt_temp == 4'd4);
      @(negedge clk);
      force test.u_couner.cnt_temp = 4'd6;
      force test.u_couner.cout = 1'b1;
      #40;
      release test.u_couner.cnt_temp;
      release test.u_couner.cout;
   end

   always #10 clk = ~clk;

   initial begin
      forever begin
	 #100;
	 if ($time >= 1000) begin
	    $finish;
	 end
      end
   end

   initial begin
      $dumpfile("testbench.vcd");
      $dumpvars(0, test);
   end

endmodule
