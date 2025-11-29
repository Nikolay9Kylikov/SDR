`timescale 1ns / 1ps

module fifo (
	// wr clock domain
	input	rst_i,
	input	rx_clk_i,
	input	wr_en_i,
	input	[11:0] wr_data_i,
	// rd clock domain
	input	tx_clk_i,
	output	reg [11:0] rd_data_o
);

	integer i;

	// ------- Write -------
	reg [9:0] wr_addr;
	wire [9:0] wr_addr_incr = wr_addr + 10'd1;
	reg [9:0] wr_addr_gray;

	always @ (posedge rx_clk_i) begin
		if (rst_i) begin
			wr_addr <= 10'd0;
			wr_addr_gray <= 10'd0;
		end else begin
			if (wr_en_i) begin
				wr_addr <= wr_addr_incr;
				wr_addr_gray <= (wr_addr_incr >> 1) ^ wr_addr_incr;
			end
		end
	end


	// ------- Read -------
	reg [9:0] rd_addr;

	// generating empty signal
	(* async_reg = "TRUE" *) reg [9:0] wr_addr_gray_txclk0;
	(* async_reg = "TRUE" *) reg [9:0] wr_addr_gray_txclk1;
	always @ (posedge tx_clk_i) begin
		wr_addr_gray_txclk0 <= wr_addr_gray;
		wr_addr_gray_txclk1 <= wr_addr_gray_txclk0;
	end
	reg [9:0] wr_addr_txclk; // really a wire
	always @ * begin // conversion from gray's code
		for (i = 0; i < 10; i = i + 1)
			wr_addr_txclk [i] = ^(wr_addr_gray_txclk1 >> i);
	end
	wire rd_empty;
	assign rd_empty = wr_addr_txclk == rd_addr;


	// ------- RAM -------
	(* ram_style = "block" *) reg [11:0] bram [1023:0]; //RAMB18
	initial begin
		for (i = 0; i < 1024; i = i + 1)
			bram [i] <= 12'h0;
	end
	wire [9:0] rd_addr_incr = rd_addr + 10'd1;
	always @ (posedge tx_clk_i) begin
		if (rst_i) begin 
			rd_addr <= 0;
		end
		else begin
			if (~rd_empty) begin
				rd_addr <= rd_addr_incr;
			end
		end
	end

	always @ (posedge rx_clk_i) begin
		if (wr_en_i) begin
			bram [wr_addr] <= wr_data_i;
		end
	end

	always @ (posedge tx_clk_i) begin
		if (~rd_empty) begin
			rd_data_o <= bram [rd_addr];
		end
	end

endmodule