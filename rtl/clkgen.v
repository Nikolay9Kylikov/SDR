`timescale 1ns / 1ps

module clk_gen(
	input sysclk_p,
	input sysclk_n,
	input clk_ads_ap,
	input clk_ads_an,
	input clk_ads_bp,
	input clk_ads_bn,
	output adc_clk_a_o,
	output adc_clk_b_o,
	output clk250_o
);

	wire clk250_in;
// 250 MHz system clock from AD9520
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_sys (
		.I	(sysclk_p),
		.IB	(sysclk_n),
		.O	(clk250_in)
	);
	BUFG bufg_sys (
		.I	(clk250_in),
		.O	(clk250_o)
	);

// ADC Data Clock (DCO / CLK_OUT) from ADS5400 A 250 MHz
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adcclk_a (
		.I	(clk_ads_ap),
		.IB	(clk_ads_an),
		.O	(adc_clk_a_o)
);

// ADC Data Clock (DCO / CLK_OUT) from ADS5400 B 250 MHz
	IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adcclk_b (
		.I	(clk_ads_bp),
		.IB	(clk_ads_bn),
		.O	(adc_clk_b_o)
);

endmodule