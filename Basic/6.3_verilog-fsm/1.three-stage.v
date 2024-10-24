module vending_machine_p3 (
			   input 	clk,
			   input 	rstn,
			   input [1:0] 	coin,
			   output [1:0] change,
			   output 	sell
			   );

   parameter IDLE  = 3'd0;
   parameter GET05 = 3'd1;
   parameter GET10 = 3'd2;
   parameter GET15 = 3'd3;

   reg [2:0] 				st_next;
   reg [2:0] 				st_cur;

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
	 st_cur <= 0'b0;
      end
      else begin
	 st_cur <= st_next;
      end
   end

   always @(*) begin
      case(st_cur)
	IDLE:
	  case(coin)
	    2'b01: st_next = GET05;
	    2'b10: st_next = GET10;
	    default: st_next = IDLE;
	  endcase
	GET05:
	  case(coin)
	    2'b01: st_next = GET10;
	    2'b10: st_next = GET15;
	    default: st_next = GET05;
	  endcase
	GET10:
	  case(coin)
	    2'b01: st_next = GET15;
	    2'b10: st_next = IDLE;
	    default: st_next = GET10;
	  endcase
	GET15:
	  case(coin)
	    2'b01: st_next = IDLE;
	    2'b10: st_next = IDLE;
	    default: st_next = GET15;
	  endcase
	default: st_next = IDLE;
   end

   reg [1:0] charge_r;
   reg 	     sell_r;

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
	 charger <= 0;
	 sell_r <= 0;
      end
      else if ((st_curr == GET15) && (coin == 2'h1)
	       || (st_cur == GET10) && (coin == 2'd2)) begin
	 charger_r <= 2'b0;
	 sell_r <= 1'b1;
      end
      else if ((st_curr == GET15) && (coin == 2'h2)) begin
	 charger_r <= 2'b1;
	 sell_r <= 1'b1;
      end
      else begin
	 charger_r <= 2'b0;
	 sell_r <= 1'b0;
      end
   end // always @ (posedge clk or negedge rstn)

   assign sell = sell_r;
   assign charge = charge_r;

endmodule