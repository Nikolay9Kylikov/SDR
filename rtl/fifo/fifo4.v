`timescale 1ns / 1ps

module fifo4(
	input	rst_i,
	input	clk_i,
	input	adc_clk_a_i,
	input	adc_clk_b_i,
	input	wr_en_a_i,
	input	wr_en_b_i,
	input	[23:0] wr_data_a_i,
	input	[23:0] wr_data_b_i,
	output	[47:0] data_adc_o
);

	wire [23:0] data_a;
	wire [23:0] data_b;
	assign data_adc_o = {data_a, data_b}; // if a comes before b

	genvar i;
	generate
		for (i = 0; i < 2; i = i + 1) begin : fifo_a
			fifo fifo_a(
				.rst_i				(rst_i),
				.rx_clk_i			(adc_clk_a_i),
				.wr_en_i			(wr_en_a_i),
				.wr_data_i			(wr_data_a_i[12*i+:12]),
				.tx_clk_i			(clk_i),
				.rd_data_o			(data_a[12*i+:12])
			);
		end
	endgenerate

	genvar j;
	generate
		for (j = 0; j < 2; j = j + 1) begin : fifo_b
			fifo fifo_b(
				.rst_i				(rst_i),
				.rx_clk_i			(adc_clk_b_i),
				.wr_en_i			(wr_en_b_i),
				.wr_data_i			(wr_data_b_i[12*j+:12]),
				.tx_clk_i			(clk_i),
				.rd_data_o			(data_b[12*j+:12])
			);
		end
	endgenerate


endmodule

