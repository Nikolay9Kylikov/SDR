`timescale 1ns/1ps

module phase_acc( // phase_gen
	input	clk_i,
	input	rst_i,
	input	valid_i, // valid will be 1 when the signal appears at the input, in top
	input	[31:0] p_inc_i,  // input signal of initial sign phase 32'b0011_0011_0011_0011_0011_0011_0011_0011 for freq fall to 0 Hz
	output	[127:0] phase_o,
	output	reg		valid_o
);

	reg	[31:0] phase_acc = 0;

	wire [31:0] p_inc = p_inc_i;

	assign phase_o[31:0] = phase_acc;
	assign phase_o[63:32] = phase_acc + p_inc;
	assign phase_o[95:64] = phase_acc + (p_inc << 1);     // p_inc * 2
	assign phase_o[127:96] = phase_acc + (p_inc << 1) + p_inc; // p_inc * 3

	always @(posedge clk_i) begin
		if (rst_i) begin
			phase_acc <= 1'b0;
			valid_o <= 1'b0;
		end
		else begin
			phase_acc <= phase_acc + (p_inc << 2);
			valid_o <= 1'b1;
		end
	end

endmodule