`timescale 1ns / 1ps

module adc_channel(
	input adc_clk_a_i,
	input adc_clk_b_i,
	input	[11:0] data_ap,
	input	[11:0] data_an,
	input	[11:0] data_bp,
	input	[11:0] data_bn,
	output	[23:0] data_a_o,
	output	[23:0] data_b_o
);

	wire [11:0] double_data_a;
	wire [11:0] double_data_b;

	genvar i;
	generate
		for (i = 0; i < 12; i = i + 1) begin : adc_inputs_a
			IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adc_data (
				.I	(data_ap[i]),
				.IB	(data_an[i]),
				.O	(double_data_a[i])
			);
		end
	endgenerate
	generate
		for (i = 0; i < 12; i = i + 1) begin : adc_inputs_b
			IBUFDS #(.DIFF_TERM("TRUE")) ibufds_adc_data (
				.I	(data_bp[i]),
				.IB	(data_bn[i]),
				.O	(double_data_b[i])
			);
		end
	endgenerate

	wire [11:0] data_a_rise_o;
	wire [11:0] data_a_fall_o;
	wire [11:0] data_b_rise_o;
	wire [11:0] data_b_fall_o;
	assign data_a_o = {data_a_rise_o, data_a_fall_o}; // b_r, b_f, a_r, a_f
	assign data_b_o = {data_b_rise_o, data_b_fall_o}; // b_r, b_f, a_r, a_f

	genvar j;
	generate
		for (j = 0; j < 12; j = j + 1) begin : iddr_a
			IDDR #(
				.DDR_CLK_EDGE("OPPOSITE_EDGE"), // Q1 – на фронте, Q2 – на спаде
				.SRTYPE("SYNC")
			) iddr_a_inst (
				.D	(double_data_a[j]),
				.C	(adc_clk_a_i),
				.CE	(1'b1),
				.S	(1'b0),
				.R	(1'b0),
				.Q1	(data_a_rise_o[j]),
				.Q2	(data_a_fall_o[j])
			);
		end
	endgenerate


	generate
		for (j = 0; j < 12; j = j + 1) begin : iddr_b
			IDDR #(
				.DDR_CLK_EDGE("OPPOSITE_EDGE"),
				.SRTYPE("SYNC")
			) iddr_b_inst (
				.D	(double_data_b[j]),
				.C	(adc_clk_b_i),
				.CE	(1'b1),
				.S	(1'b0),
				.R	(1'b0),
				.Q1	(data_b_rise_o[j]),
				.Q2	(data_b_fall_o[j])
			);
		end
	endgenerate

endmodule