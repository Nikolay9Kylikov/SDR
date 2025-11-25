`timescale 1ns / 1ps
module tb_top ();
	reg clk;
	reg rst;
	reg valid;
	wire valid_i = valid;
	wire [3:0] valid_o;

	wire [15:0] sin0_o;
	wire [15:0] cos0_o;
	wire [15:0] sin1_o;
	wire [15:0] cos1_o;
	wire [15:0] sin2_o;
	wire [15:0] cos2_o;
	wire [15:0] sin3_o;
	wire [15:0] cos3_o;

	top top(
		.clk_i		(clk),
		.rst_i		(rst),
		.valid_i	(valid_i),
		.valid_o	(valid_o),
		.sin0_o		(sin0_o),
		.cos0_o		(cos0_o),
		.sin1_o		(sin1_o),
		.cos1_o		(cos1_o),
		.sin2_o		(sin2_o),
		.cos2_o		(cos2_o),
		.sin3_o		(sin3_o),
		.cos3_o		(cos3_o)
	);


	// Генерация тактового сигнала
	initial clk = 0;
	always #5 clk = ~clk;  // 100 MHz

	initial begin
		rst = 1;
		valid = 0;
		#100;
		rst = 0;
		valid = 1;
		#10_000;
		$finish;

	end

endmodule