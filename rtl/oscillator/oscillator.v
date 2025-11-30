`timescale 1ns / 1ps

module oscillator(
	input clk_i,
	input rst_i,
	input valid_i,
	output [3:0] valid_o,
	output [63:0] sin_o,
	output [63:0] cos_o
);
	localparam [31:0] INC = 32'b0011_0011_0011_0011_0011_0011_0011_0011;
	wire [31:0] p_inc = INC;


	wire [127:0] phase;
	wire valid;

	phase_acc phase_gen(
		.clk_i		(clk_i),
		.rst_i		(rst_i),
		.valid_i	(valid_i),
		.p_inc_i	(p_inc),
		.phase_o	(phase),
		.valid_o	(valid)
	);

	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1) begin
			cordic cordic(
				.clk_i		(clk_i),
				.rst_i		(rst_i),
				.valid_i	(valid),
				.phase_i	(phase[32*i+:32]),
				.sin_o		(sin_o[16*i+:16]),
				.cos_o		(cos_o[16*i+:16]),
				.valid_o	(valid_o[i])
			);
		end
	endgenerate

endmodule