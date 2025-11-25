`timescale 1ns/1ps

module cordic (
	input	clk_i,
	input	rst_i,
	input	valid_i,
	input	[31:0] phase_i,
	output	reg signed [15:0] sin_o,
	output	reg signed [15:0] cos_o,
	output	reg valid_o
);
	localparam [31:0] HALF_PI_PHASE = 32'h4000_0000; // 2^30 == π/2
	// localparam [511:0] ATAN_TABLE = {
	// 	32'h0000_517D, // i=15
	// 	32'h0000_A2FA, // i=14
	// 	32'h0001_45F3, // i=13
	// 	32'h0002_8BE6, // i=12
	// 	32'h0005_17CC, // i=11
	// 	32'h000A_2F98, // i=10
	// 	32'h0014_5F2F, // i=9
	// 	32'h0028_BE53, // i=8
	// 	32'h0051_7C55, // i=7
	// 	32'h00A2_F61E, // i=6
	// 	32'h0145_D7E1, // i=5
	// 	32'h028B_0D43, // i=4
	// 	32'h0511_11D4, // i=3
	// 	32'h09FB_385B, // i=2
	// 	32'h12E4_051E, // i=1
	// 	32'h2000_0000  // i=0
	// };
	localparam [0:15][31:0] ATAN_TABLE = {
		32'h2000_0000,  // atan(2^0)
		32'h12E4_051E,  // atan(2^-1)
		32'h09FB_385B,  // atan(2^-2)
		32'h0511_11D4,  // atan(2^-3)
		32'h028B_0D43,  // atan(2^-4)
		32'h0145_D7E1,  // atan(2^-5)
		32'h00A2_F61E,  // atan(2^-6)
		32'h0051_7C55,  // atan(2^-7)
		32'h0028_BE53,  // atan(2^-8)
		32'h0014_5F2F,  // atan(2^-9)
		32'h000A_2F98,  // atan(2^-10)
		32'h0005_17CC,  // atan(2^-11)
		32'h0002_8BE6,  // atan(2^-12)
		32'h0001_45F3,  // atan(2^-13)
		32'h0000_A2FA,  // atan(2^-14)
		32'h0000_517D   // atan(2^-15)
	};

	reg valid_in;
	reg [15:0] valid_stage;
	reg [33:0] quadrant;
	reg signed [47:0] x [16:0];		// 17iter * 48bit
	reg signed [47:0] y [16:0];
	reg signed [31:0] theta [16:0];	// 17iter * 32bit

	always @(posedge clk_i) begin
		if (rst_i) begin
			x[0] <= 0;
			y[0] <= 0;
			theta[0] <= 32'sd0;
			valid_stage <= 16'd0;
			valid_in <= 1'b0;
			quadrant <= 34'd0;
		end
		else begin
			valid_in <= valid_i;
			valid_stage <= {valid_stage[14:0], valid_in};
			quadrant <= {quadrant[31:0], phase_i[31:30]};
			if (valid_i) begin
				x[0] <= {16'b0, 32'h26DD3B6A}; // Q2.30 all numbers, because theta belongs [2pi:2pi]
				y[0] <= 0;
				case(phase_i[31:30])
					2'b00: theta[0] <= $signed({2'b0, phase_i[29:0]});
					2'b01: theta[0] <= $signed(HALF_PI_PHASE) - $signed({2'b0, phase_i[29:0]});
					2'b10: theta[0] <= $signed({2'b0, phase_i[29:0]});
					2'b11: theta[0] <= $signed(HALF_PI_PHASE) - $signed({2'b0, phase_i[29:0]});
					default: theta[0] <= 32'sd0;
				endcase
			end
			else begin
				x[0] <= 0;
				y[0] <= 0;
				theta[0] <= 32'sd0;
			end
		end
	end



	genvar i;
	generate
		for (i = 0; i < 16; i = i + 1) begin : cordic_stages
			always @(posedge clk_i) begin
				if (rst_i) begin
					x[i] <= 0;
					y[i] <= 0;
					theta[i] <= 32'sd0;
					x[i+1] <= 0;
					y[i+1] <= 0;
					theta[i+1] <= 32'sd0;
				end
				else begin
					if (valid_stage[i]) begin
						if ($signed(theta[i]) >= 32'sd0) begin
							x[i+1] <= x[i] - (y[i] >>> i);
							y[i+1] <= y[i] + (x[i] >>> i);
							theta[i+1] <= theta[i] - $signed(ATAN_TABLE[i]);
						end
						else begin
							x[i+1] <= x[i] + (y[i] >>> i);
							y[i+1] <= y[i] - (x[i] >>> i);
							theta[i+1] <= theta[i] + $signed(ATAN_TABLE[i]);
						end
					end
					else begin
						x[i+1]<= 0;
						y[i+1]<= 0;
						theta[i+1]<= 32'sd0;
					end
				end
			end
		end
	endgenerate
	
	always @(posedge clk_i) begin
		if (rst_i) begin
			valid_o <= 1'b0;
			cos_o <= 16'sd0;
			sin_o <= 16'sd0;
		end
		else begin
			valid_o <= valid_stage[15];
			case(quadrant[33:32])
				2'b00: begin
					cos_o <= $signed(x[16][30:15]);
					sin_o <= $signed(y[16][30:15]);
				end
				2'b01: begin
					cos_o <= -$signed(x[16][30:15]); 
					sin_o <= $signed(y[16][30:15]);
				end
				2'b10: begin
					cos_o <= -$signed(x[16][30:15]);
					sin_o <= -$signed(y[16][30:15]);
				end
				2'b11: begin
					cos_o <= $signed(x[16][30:15]);
					sin_o <= -$signed(y[16][30:15]);
				end
			endcase
		end
	end

endmodule