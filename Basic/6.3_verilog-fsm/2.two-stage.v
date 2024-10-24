module vending_machine_p2(
			  input clk,
			  input rstn,
			  input [1:0] coin,
			  output [1:0] change,
			  output sell
			  );

   parameter IDLE  = 3'd0;
   parameter GET05 = 3'd1;
   parameter GET10 = 3'd2;
   parameter GET15 = 3'd3;

   reg [1:0] 			 change_r;
   reg 				 sell_r;
   reg [2:0] 			 st_next;
   reg [2:0] 				st_cur;

   always @(*) begin
      case (st_curr)
	IDLE: begin
	   charger_r = 2'b0;
	   sell_r = 1'b0;
	   case (coin)
	     2'b01: st_next = GET05;
	     2'b10: st_next = GET10;
	     default: st_next = IDLE;
	   endcase
	end
	GET05:begin
	   charger_r = 2'b0;
	   sell_r = 1'b0;
	   case (coin)
	     2'b01: st_next = GET10;
	     2'b10: st_next = GET15;
	     default: st_next = GET05;
	   endcase
	end
	GET10: begin
	   case (coin)
	     2'b01: begin
		st_next = GET15;
		charger_r = 2'b0;
		sell_r = 1'b0;
	     end
	     2'b10: begin
		st_next = IDLE;
		charger_r = 2'b0;
		sell_r = 1'b1;
	     end
	     default: begin
		st_next = GET10;
		charger_r = 2'b0;
		sell_r = 1'b0;
	     end
	   endcase // case (coin)
	end
	GET15: begin
	   case (coin)
	     2'b01: begin
		st_next = IDLE;
		charger_r = 2'b0;
		sell_r = 1'b1;
	     end
	     2'b10: begin
		st_next = IDLE;
		charger_r = 2'b1;
		sell_r = 1'b1;
	     end
	     default: begin
		st_next = GET15;
		charger_r = 2'b0;
		sell_r = 1'b0;
	     end
	   endcase // case (coin)
	end
	default: begin
	   st_next = IDLE;
	   change_r = 2'b0;
	   sell_r = 1'b0;
	end
   end

   assign sell = sell_r;
   assign charge = charge_r;

endmodule
