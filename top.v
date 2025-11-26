`timescale 1ns / 1ps

module top(
	input clk_i,
	input rst_i,
	output [3:0] valid_o,
	output [15:0] sin0_o,
	output [15:0] cos0_o,
	output [15:0] sin1_o,
	output [15:0] cos1_o,
	output [15:0] sin2_o,
	output [15:0] cos2_o,
	output [15:0] sin3_o,
	output [15:0] cos3_o
);
	// reg [31:0] inc = 32'b0011_0011_0011_0011_0011_0011_0011_0011;
	reg [31:0] inc = 32'h15555555; // right work
	// reg [31:0] inc = 32'h0800_0000; // right work
	wire [31:0] p_inc  = inc;

	wire [127:0] phase;
	wire valid;

	wire [15:0] sin0;
	wire [15:0] cos0;
	wire [15:0] sin1;
	wire [15:0] cos1;
	wire [15:0] sin2;
	wire [15:0] cos2;
	wire [15:0] sin3;
	wire [15:0] cos3;

	assign [15:0] sin0_0 = sin0;
	assign [15:0] cos0_0 = cos0;
	assign [15:0] sin1_0 = sin1;
	assign [15:0] cos1_0 = cos1;
	assign [15:0] sin2_0 = sin2;
	assign [15:0] cos2_0 = cos2;
	assign [15:0] sin3_0 = sin3;
	assign [15:0] cos3_0 = cos3;

	phase_acc phase_gen(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.p_inc_i	(p_inc),
		.phase_o	(phase),
		.valid_o	(valid)
	);

	cordic cordic0(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[31:0]),
		.sin_o		(sin0),
		.cos_o		(cos0),
		.valid_o	(valid_o[0])
	);

	cordic cordic1(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[63:32]),
		.sin_o		(sin1),
		.cos_o		(cos1),
		.valid_o	(valid_o[1])
	);

	cordic cordic2(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[95:64]),
		.sin_o		(sin2),
		.cos_o		(cos2),
		.valid_o	(valid_o[2])
	);

	cordic cordic3(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[127:96]),
		.sin_o		(sin3),
		.cos_o		(cos3),
		.valid_o	(valid_o[3])
	);

	mixer mixer(
	.clk_i			(clk_i),
	.valid_i		(valid_o),
	.sample0		(),
	.sample1		(),
	.sample2		(),
	.sample3		(),
	.cos0			(cos0),
	.cos1			(cos1),
	.cos2			(cos2),
	.cos3			(cos3),
	.sin0			(sin0),
	.sin1			(sin1),
	.sin2			(sin2),
	.sin3			(sin3),
	.inphase0		(inphase0),
	.inphase1		(inphase1),
	.inphase2		(inphase2),
	.inphase3		(inphase3),
	.quadrature0	(quadrature0),
	.quadrature1	(quadrature1),
	.quadrature2	(quadrature2),
	.quadrature3	(quadrature3)
	);

endmodule