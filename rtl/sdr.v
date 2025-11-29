`timescale 1ns / 1ps
module sdr(
	input rst_i,
	input sysclk_p,
	input sysclk_n,
	input clk_ads_ap,
	input clk_ads_an,
	input clk_ads_bp,
	input clk_ads_bn,
	input wr_en_fifo_a,
	input wr_en_fifo_b,
	input [11:0] data_ap,
	input [11:0] data_an,
	input [11:0] data_bp,
	input [11:0] data_bn,
	output [27:0] inphase0,
	output [27:0] inphase1,
	output [27:0] inphase2,
	output [27:0] inphase3,
	output [27:0] quadrature0,
	output [27:0] quadrature1,
	output [27:0] quadrature2,
	output [27:0] quadrature3
);

	wire clk250;
	wire adc_clk_a;
	wire adc_clk_b;

	clk_gen clk_gen(
		.sysclk_p		(sysclk_p),
		.sysclk_n		(sysclk_n),
		.clk_ads_ap		(clk_ads_ap),
		.clk_ads_an		(clk_ads_an),
		.clk_ads_bp		(clk_ads_bp),
		.clk_ads_bn		(clk_ads_bn),
		.adc_clk_a_o	(adc_clk_a),
		.adc_clk_b_o	(adc_clk_b),
		.clk250_o		(clk250)
	);

	wire [23:0] data_a;
	wire [23:0] data_b;

	adc_channel adc_channel(
		.adc_clk_a_i		(adc_clk_a),
		.adc_clk_b_i		(adc_clk_b),
		.data_ap			(data_ap),
		.data_an			(data_an),
		.data_bp			(data_bp),
		.data_bn			(data_bn),
		.data_a_o			(data_a),
		.data_b_o			(data_b)
	);

	wire [47:0] data_adc;

	fifo4 fifo4(
		.rst_i				(rst_i),
		.clk_i				(clk250),
		.adc_clk_a_i		(adc_clk_a),
		.adc_clk_b_i		(adc_clk_b),
		.wr_en_a_i			(wr_en_fifo_a),
		.wr_en_b_i			(wr_en_fifo_b),
		.wr_data_a_i		(data_a),
		.wr_data_b_i		(data_b),
		.data_adc_o			(data_adc)
		);

	wire [47:0] data_align;

	delay14 delay(						// формирование задержки для выравнивания с CORDIC
		.clk_i				(clk250),
		.data_i				(data_adc),
		.data_o				(data_align)
	);

	wire [3:0] valid_os;
	wire [63:0] sin;
	wire [63:0] cos;

	oscillator oscillator(
		.clk_i					(clk250),
		.rst_i					(rst_i),
		.valid_o				(valid_os),
		.sin_o					(sin),
		.cos_o					(cos)
	);


	mixer mixer(
		.clk_i					(clk250),
		.valid_i				(valid_os),
		.sample0_i				(data_align[11:0]),
		.sample1_i				(data_align[23:12]),
		.sample2_i				(data_align[35:24]),
		.sample3_i				(data_align[47:36]),
		.cos0_i					(cos[15:0]),
		.cos1_i					(cos[31:16]),
		.cos2_i					(cos[47:32]),
		.cos3_i					(cos[63:48]),
		.sin0_i					(sin[15:0]),
		.sin1_i					(sin[31:16]),
		.sin2_i					(sin[47:32]),
		.sin3_i					(sin[63:48]),
		.inphase0_o				(inphase0),
		.inphase1_o				(inphase1),
		.inphase2_o				(inphase2),
		.inphase3_o				(inphase3),
		.quadrature0_o			(quadrature0),
		.quadrature1_o			(quadrature1),
		.quadrature2_o			(quadrature2),
		.quadrature3_o			(quadrature3)
	);

endmodule