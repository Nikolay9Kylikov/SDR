`timescale 1ns/1ps

module phase_acc( // phase_gen
	input	clk_i,
	input	rst_i,
	input	[31:0] p_inc_i,  // input signal of initial sign phase 32'b0011_0011_0011_0011_0011_0011_0011_0011 for freq fall to 0 Hz
	output	[31:0] phase0_o,
	output	[31:0] phase1_o,
	output	[31:0] phase2_o,
	output	[31:0] phase3_o
);

	reg	[31:0] phase_acc = 0;

	wire	[31:0] p_inc = p_p_inc_i;

	assign phase0_o = phase_acc;
	assign phase1_o = phase_acc + p_inc;
	assign phase2_o = phase_acc + (p_inc << 1);     // p_inc * 2
	assign phase3_o = phase_acc + (p_inc << 1) + p_inc; // p_inc * 3

	always @(posedge clk_i) begin
		if (rst_i)
			phase_acc <= 0;
		else
			phase_acc <= phase_acc + (p_inc << 2);
	end

endmodule