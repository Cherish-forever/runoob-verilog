module dff_nornal(
		  input rstn,
		  input clk,
		  input D,
		  input Q
		  );

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
	 Q <= 1'b0; // Q = 0 after reset effecive
      end
      else begin
	 Q <= D;    // Q = D at posedge of clock
      end
   end

endmodule

module dff_deassign(
		  input rstn,
		  input clk,
		  input D,
		  input Q
		  );

   always @(posedge clk) begin
      Q <= D;    // Q = D at posedge of clock
   end

   always @(negedge rstn) begin
      if (!rstn) begin
	 Q <= 1'b0; // Q = 0 after reset effecive
      end
      else begin
	 deassign Q; // Q = 0 until the comming clock posedge, then Q <= D;
      end
   end

endmodule

// dff_normal eq dff_deassign
