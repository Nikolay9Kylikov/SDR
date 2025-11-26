`timescale 1ns / 1ps

module mixer(
	input wire clk_i,
	input wire [3:0] valid_i,
	input wire signed [11:0] sample0,
	input wire signed [11:0] sample1,
	input wire signed [11:0] sample2,
	input wire signed [11:0] sample3,
	input wire signed [15:0] cos0,
	input wire signed [15:0] cos1,
	input wire signed [15:0] cos2,
	input wire signed [15:0] cos3,
	input wire signed [15:0] sin0,
	input wire signed [15:0] sin1,
	input wire signed [15:0] sin2,
	input wire signed [15:0] sin3,
	output reg signed [27:0] inphase0,
	output reg signed [27:0] inphase1,
	output reg signed [27:0] inphase2,
	output reg signed [27:0] inphase3,
	output reg signed [27:0] quadrature0,
	output reg signed [27:0] quadrature1,
	output reg signed [27:0] quadrature2,
	output reg signed [27:0] quadrature3
);

	// Behavioral multiplies — synthesis will map to DSP48E1 in Vivado (if constraints allow)
	wire signed [27:0] product_inphase0 = sample0 * cos0;
	wire signed [27:0] product_inphase1 = sample1 * cos1;
	wire signed [27:0] product_inphase2 = sample2 * cos2;
	wire signed [27:0] product_inphase3 = sample3 * cos3;

	wire signed [27:0] pproduct_quadtature0 = sample0 * sin0;
	wire signed [27:0] pproduct_quadtature1 = sample1 * sin1;
	wire signed [27:0] pproduct_quadtature2 = sample2 * sin2;
	wire signed [27:0] pproduct_quadtature3 = sample3 * sin3;

	// Register outputs (pipeline stage)
	always @(posedge clk) begin // if valid_i = 0, then registers = 0 or last value
		if (valid_i[0]) begin
			inphase0 <= product_inphase0;
			quadrature0 <= pproduct_quadtature0;
		end
		if (valid_i[1]) begin
			inphase1 <= product_inphase1;
			quadrature1 <= pproduct_quadtature1;
		end
		if (valid_i[2]) begin
			inphase2 <= product_inphase2;
			quadrature2 <= pproduct_quadtature2;
		end
		if (valid_i[3]) begin
			inphase3 <= product_inphase3;
			quadrature3 <= pproduct_quadtature3;
		end
	end

endmodule