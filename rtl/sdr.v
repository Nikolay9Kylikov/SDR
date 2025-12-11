`timescale 1ns / 1ps
module sdr(
	input rst_i,
	input sysclk_p,
	input sysclk_n,
	input clk_ads_ap,
	input clk_ads_an,
	input clk_ads_bp,
	input clk_ads_bn,
	input [11:0] data_ap,
	input [11:0] data_an,
	input [11:0] data_bp,
	input [11:0] data_bn,
	output [15:0] f_inphase0_o,
	output [15:0] f_inphase1_o,
	output [15:0] f_inphase2_o,
	output [15:0] f_inphase3_o,
	output [15:0] f_quadrature0_o,
	output [15:0] f_quadrature1_o,
	output [15:0] f_quadrature2_o,
	output [15:0] f_quadrature3_o
);

	wire clk250;
	wire adc_clk_a;
	wire adc_clk_b;

	wire wr_en_fifo_a = ~rst_i;
	wire wr_en_fifo_b = ~rst_i;
	wire valid = ~rst_i;

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

	delay delay14(						// формирование задержки для выравнивания с CORDIC
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
		.valid_i				(valid),
		.valid_o				(valid_os),
		.sin_o					(sin),
		.cos_o					(cos)
	);

	wire [27:0] inphase0;
	wire [27:0] inphase1;
	wire [27:0] inphase2;
	wire [27:0] inphase3;
	wire [27:0] quadrature0;
	wire [27:0] quadrature1;
	wire [27:0] quadrature2;
	wire [27:0] quadrature3;

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

	wire [13:0] f_inphase0;
	wire [13:0] f_inphase1;
	wire [13:0] f_inphase2;
	wire [13:0] f_inphase3;
	wire [13:0] f_quadrature0;
	wire [13:0] f_quadrature1;
	wire [13:0] f_quadrature2;
	wire [13:0] f_quadrature3;

	assign f_inphase0_o = {f_inphase0, 2'b0};
	assign f_inphase1_o = {f_inphase1, 2'b0};
	assign f_inphase2_o = {f_inphase2, 2'b0};
	assign f_inphase3_o = {f_inphase3, 2'b0};
	assign f_quadrature0_o = {f_quadrature0, 2'b0};
	assign f_quadrature1_o = {f_quadrature1, 2'b0};
	assign f_quadrature2_o = {f_quadrature2, 2'b0};
	assign f_quadrature3_o = {f_quadrature3, 2'b0};


	fir_compiler_0 F_In0(
		.aclk(clk250),																								// input wire aclk
		.s_axis_data_tvalid(1'b1),																					// input wire s_axis_data_tvalid
		.s_axis_data_tready(), 																						// output wire s_axis_data_tready
		.s_axis_data_tdata({{inphase3, 4'b0}, {inphase2, 4'b0}, {inphase1, 4'b0}, {inphase0, 4'b0}}),				// input wire [27 : 0] s_axis_data_tdata
		.m_axis_data_tvalid(f_inp_tvalid),																			// output wire m_axis_data_tvalid
		.m_axis_data_tdata({f_inphase3, f_inphase2, f_inphase1, f_inphase0})										// output wire [15 : 0] m_axis_data_tdata
	);


	//Quadrature
	fir_compiler_0 F_Q0(
		.aclk(clk250),																								// input wire aclk
		.s_axis_data_tvalid(1'b1),																					// input wire s_axis_data_tvalid
		.s_axis_data_tready(), 																						// output wire s_axis_data_tready
		.s_axis_data_tdata({{quadrature3, 4'b0}, {quadrature2, 4'b0}, {quadrature1, 4'b0}, {quadrature0, 4'b0}}),	// input wire [27 : 0] s_axis_data_tdata
		.m_axis_data_tvalid(f_q_tvalid),																			// output wire m_axis_data_tvalid
		.m_axis_data_tdata({f_quadrature3, f_quadrature2, f_quadrature1, f_quadrature0})							// output wire [15 : 0] m_axis_data_tdata
	);


endmodule