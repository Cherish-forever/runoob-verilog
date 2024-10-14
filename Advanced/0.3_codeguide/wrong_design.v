module codeguide();

   reg [31:0] wdata = 32'b0; // Do not assign value to variable!

   reg [3:0]  cnt;
   reg 	      cout;

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
	 cnt <= 4'b0;       // assign value after reset
      end
      else if (cnt == 10) begin
	 cout <= 4'b0;
	 cout <= 1'b1;
      end
      else begin
	 cnt  <= cnt + 1'b1;
	 cout <= 1'b0;
      end
   end

   // try to avoid 2 always use one clock posedge and negedge
   always @(posedge clk) begin
      a <= b;
   end

   always @(negedge clk) begin
      c <= d;
   end

   // Do not use one clock both edge in one always
   // FPGA trigger only support one kind of edge.
   always @(posedge clk or negedge clk) begin
      a <= b;
   end

   // Do not assign variable in two or more always.
   always @(posedge clk) begin
      a <= b;
   end

   always @(negedge clk) begin
      a <=d;
   end

   // each always only include one thing
   always @(posedge clk) begin
      if (a == b)
	dada_t1 <= data1;

      if (a == b && c==d)
	data_t2 <=data2;
      else
	data_t2 <= 'b0;
   end

   // this is right way
   always @(posedge clk) begin
      if (a == b)
	data_t1 <= data1;
   end

   always @(posedge clk) begin
      if (a == b && c == d)
	data_t2 <= data2;
      else
	data_t2 <= 'b0;
   end

   // Do not use clock logic operation, compare.
   assign clk_gate = clk & clken;
   assign dout = (clk == 1'b1) ? din : 0;

   always @(posedge clk) begin
      if (clk == 1'b1)
	data_t1 <= data1;
   end

endmodule
