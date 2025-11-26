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
		.sin_o		(sin0_o),
		.cos_o		(cos0_o),
		.valid_o	(valid_o[0])
	);

	cordic cordic1(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[63:32]),
		.sin_o		(sin1_o),
		.cos_o		(cos1_o),
		.valid_o	(valid_o[1])
	);

	cordic cordic2(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[95:64]),
		.sin_o		(sin2_o),
		.cos_o		(cos2_o),
		.valid_o	(valid_o[2])
	);

	cordic cordic3(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid),
		.phase_i	(phase[127:96]),
		.sin_o		(sin3_o),
		.cos_o		(cos3_o),
		.valid_o	(valid_o[3])
	);


endmodule