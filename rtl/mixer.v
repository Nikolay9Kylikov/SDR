`timescale 1ns / 1ps

module mixer(
	input wire clk_i,
	input wire [3:0] valid_i,
	input wire signed [11:0] sample0_i,
	input wire signed [11:0] sample1_i,
	input wire signed [11:0] sample2_i,
	input wire signed [11:0] sample3_i,
	input wire signed [15:0] cos0_i,
	input wire signed [15:0] cos1_i,
	input wire signed [15:0] cos2_i,
	input wire signed [15:0] cos3_i,
	input wire signed [15:0] sin0_i,
	input wire signed [15:0] sin1_i,
	input wire signed [15:0] sin2_i,
	input wire signed [15:0] sin3_i,
	output reg signed [27:0] inphase0_o,
	output reg signed [27:0] inphase1_o,
	output reg signed [27:0] inphase2_o,
	output reg signed [27:0] inphase3_o,
	output reg signed [27:0] quadrature0_o,
	output reg signed [27:0] quadrature1_o,
	output reg signed [27:0] quadrature2_o,
	output reg signed [27:0] quadrature3_o
);

	// Behavioral multiplies — synthesis will map to DSP48E1 in Vivado (if constraints allow)
	wire signed [27:0] product_inphase0 = sample0_i * cos0_i;
	wire signed [27:0] product_inphase1 = sample1_i * cos1_i;
	wire signed [27:0] product_inphase2 = sample2_i * cos2_i;
	wire signed [27:0] product_inphase3 = sample3_i * cos3_i;

	wire signed [27:0] pproduct_quadtature0 = sample0_i * sin0_i;
	wire signed [27:0] pproduct_quadtature1 = sample1_i * sin1_i;
	wire signed [27:0] pproduct_quadtature2 = sample2_i * sin2_i;
	wire signed [27:0] pproduct_quadtature3 = sample3_i * sin3_i;

	// Register outputs (pipeline stage)
	always @(posedge clk_i) begin // if valid_i = 0, then registers = 0 or last value
		if (valid_i[0]) begin
			inphase0_o <= product_inphase0;
			quadrature0_o <= pproduct_quadtature0;
		end
		if (valid_i[1]) begin
			inphase1_o <= product_inphase1;
			quadrature1_o <= pproduct_quadtature1;
		end
		if (valid_i[2]) begin
			inphase2_o <= product_inphase2;
			quadrature2_o <= pproduct_quadtature2;
		end
		if (valid_i[3]) begin
			inphase3_o <= product_inphase3;
			quadrature3_o <= pproduct_quadtature3;
		end
	end

endmodule