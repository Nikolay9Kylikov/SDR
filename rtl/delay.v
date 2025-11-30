`timescale 1ns/1ps

module delay(
	input	wire		clk_i,
	input	wire [47:0] data_i,
	output	reg  [47:0] data_o
);

	reg [47:0] d0;
	reg [47:0] d1;
	reg [47:0] d2;
	reg [47:0] d3;
	reg [47:0] d4;
	reg [47:0] d5;
	reg [47:0] d6;
	reg [47:0] d7;
	reg [47:0] d8;
	reg [47:0] d9;
	reg [47:0] d10;
	reg [47:0] d11;
	reg [47:0] d12;
	reg [47:0] d13;

	always @(posedge clk_i) begin
		d0	<= data_i;
		d1	<= d0;
		d2	<= d1;
		d3	<= d2;
		d4	<= d3;
		d5	<= d4;
		d6	<= d5;
		d7	<= d6;
		d8	<= d7;
		d9	<= d8;
		d10	<= d9;
		d11	<= d10;
		d12	<= d11;
		d13	<= d12;

		data_o <= d13;
	end

endmodule
