`timescale 1ns / 1ps
module sdr(
	input sysclk_p,
	input sysclk_n,
	input clk_ads_ap,
	input clk_ads_an,
	input clk_ads_bp,
	input clk_ads_bn,
	input [11:0] data_ap,
	input [11:0] data_an,
	input [11:0] data_bp,
	input [11:0] data_bn
);

// 250 MHz system clock from AD9520
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_sys (
		.I  (sysclk_p),
		.IB (sysclk_n),
		.O  (clk250_in)
	);
	BUFG bufg_sys (
		.I  (clk250_in),
		.O  (clk250)
	);

// ADC Data Clock (DCO / CLK_OUT) from ADS5400 A 250 MHz
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adcclk_a (
		.I  (clk_ads_ap),
		.IB (clk_ads_an),
		.O  (adc_clk_in_a)
);

// ADC Data Clock (DCO / CLK_OUT) from ADS5400 B 250 MHz
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adcclk_b (
		.I  (clk_ads_bp),
		.IB (clk_ads_bn),
		.O  (adc_clk_in_b)
);

	wire [11:0] double_data_a_in;
	wire [11:0] double_data_b_in;
	genvar i;
	generate
		for (i = 0; i < 12; i = i + 1) begin : adc_inputs_a
			IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adc_data (
				.I  (data_ap[i]),
				.IB (data_an[i]),
				.O  (double_data_a_in[i])
			);
		end
	endgenerate
	generate
		for (i = 0; i < 12; i = i + 1) begin : adc_inputs_b
			IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adc_data (
				.I  (data_bp[i]),
				.IB (data_bn[i]),
				.O  (double_data_b_in[i])
			);
		end
	endgenerate

	wire [1:0] data_a_in [11:0];
	wire [1:0] data_b_in [11:0];
// ISERDES / IDDR use adc_clk_in as capture clock, clk250 as clk_div
	genvar j;
	generate
		for (j = 0; j < 12; j = j + 1) begin : ser_a
			ISERDESE2 #(
				.DATA_RATE("DDR"),
				.DATA_WIDTH(2)
			) iserdes_a (
				.D			(double_data_a_in[j]),
				.CLK		(adc_clk_in_a),
				.CLKB		(~adc_clk_in_a),
				.CLKDIV		(clk250),
				.Q1			(data_a_in[j][0]),
				.Q2			(data_a_in[j][1]),
				.CE1		(1'b1),
				.RST		(1'b0),
				.BITSLIP	(1'b0)
			);
		end
	endgenerate
// ISERDES / IDDR use adc_clk_in as capture clock, clk250 as clk_div
	generate
		for (j = 0; j < 12; j = j + 1) begin : ser_b
			ISERDESE2 #(
				.DATA_RATE("DDR"),
				.DATA_WIDTH(2)
			) iserdes_b (
				.D			(double_data_b_in[j]),
				.CLK		(adc_clk_in_b),
				.CLKB		(~adc_clk_in_b),
				.CLKDIV		(clk250),
				.Q1			(data_b_in[j][0]),
				.Q2			(data_b_in[j][1]),
				.CE1		(1'b1),
				.RST		(1'b0),
				.BITSLIP	(1'b0)
			);
		end
	endgenerate

endmodule