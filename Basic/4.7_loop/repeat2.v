`timescale 1ns/1ns

module test;

   reg [3:0] counter;
   initial begin
      counter = 'b0;
      repeat (11) begin
	 #10;
	 counter = counter + 1'b1;
      end
   end


   reg clk;
   reg rstn;
   reg enable;
   reg [3:0] buffer [0:7] ; // array len is 8, item is 4bits
   integer   j;

   initial begin
      clk = 0;
      rstn = 1;
      enable = 0;
      #3;
      rstn = 0;
      #3;
      rstn = 1;
      enable = 1;
      forever begin
	 clk = ~clk;
	 #5;
      end
   end

   always @(posedge clk or negedge rstn) begin
      j = 0;
      if (!rstn) begin
	 repeat(8) begin
	    buffer[j] <= 'b0;
	    j = j+1;
	 end
      end
      else if (enable) begin
	 repeat(8) begin
	    @(posedge clk) buffer[j] <= counter;
	    j = j + 1 ;
	 end
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
