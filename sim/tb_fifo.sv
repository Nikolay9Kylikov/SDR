`timescale 1ns / 1ps
module tb_fifo ();
	reg rx_clk;
	reg tx_clk;
	reg rst;
	reg wr_en;

	reg [11:0] wr_data;
	reg [11:0] tx_data;

	fifo fifo(
		.rx_clk_i		(rx_clk),
		.tx_clk_i		(tx_clk),
		.rst_i			(rst),
		.wr_en_i		(wr_en),
		.wr_data_i		(wr_data),
		.rd_data_o		(tx_data)
	);


	// Генерация тактового сигнала
	initial rx_clk = 0;
	always #5 rx_clk = ~rx_clk;  // 100 MHz

	// Генерация тактового сигнала
	initial tx_clk = 0;
	always #5 tx_clk = ~tx_clk;  // 100 MHz
	initial begin
	integer i;
	integer j;
	integer k;
		rst <= 1;
		wr_en <= 0;
		wr_data <= 0;
		#96;
		rst <= 0;
		#10;
		wr_en <= 1;
		wr_data <= 12'hACD;
		#1;
		#10;
		wr_data <= 12'hFFF;
		#10;
		wr_data <= 12'hEBE;
		#10;
		wr_data <= 12'hFDC;
		#10;
		for (i = 0; i < 259; i = i + 1) begin
			for (j = 0; j < 4; j = j + 1) begin
				wr_data <= 12'hABC;
				#10;
				wr_data <= 12'hFFF;
				#10;
				wr_data <= 12'hDDD;
				#10;
				wr_data <= 12'hCCC;
				#10;
			end
		end
		wr_en <= 0;
		#100;
		wr_en <= 1;
		for (k = 0; k < 4; k = k + 1) begin
				wr_data <= 12'hAAA;
				#10;
				wr_data <= 12'hFFF;
				#10;
				wr_data <= 12'hDDD;
				#10;
				wr_data <= 12'hCCC;
				#10;
		end
		rst <= 0;
		#100;
		rst <= 1;
		for (k = 0; k < 4; k = k + 1) begin
				wr_data <= 12'hAAA;
				#10;
				wr_data <= 12'hFFF;
				#10;
				wr_data <= 12'hDDD;
				#10;
				wr_data <= 12'hCCC;
				#10;
		end
		$finish;

	end

endmodule