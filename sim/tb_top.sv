`timescale 1ns / 1ps

module tb_top;


	reg rst;

	// Генерация тактового сигнала
	reg sysclk = 1'b1;
	always #2 sysclk = ~sysclk;  // 250 MHz

	reg clk_ads_a = 1'b1;
	always #2 clk_ads_a = ~clk_ads_a;  // 250 MHz

	reg clk_ads_b = 1'b1;
	always #2 clk_ads_b = ~clk_ads_b;  // 250 MHz

	reg signed [11:0] adc_data_a;
	reg signed [11:0] adc_data_b;

	wire [27:0] inphase0;
	wire [27:0] inphase1;
	wire [27:0] inphase2;
	wire [27:0] inphase3;
	wire [27:0] quadrature0;
	wire [27:0] quadrature1;
	wire [27:0] quadrature2;
	wire [27:0] quadrature3;

	sdr sdr(
		.rst_i				(rst),
		.sysclk_p			(sysclk),
		.sysclk_n			(~sysclk),
		.clk_ads_ap			(clk_ads_a),
		.clk_ads_an			(~clk_ads_a),
		.clk_ads_bp			(clk_ads_b),
		.clk_ads_bn			(~clk_ads_b),
		.data_ap			(adc_data_a),
		.data_an			(~adc_data_a),
		.data_bp			(adc_data_b),
		.data_bn			(~adc_data_b),
		.inphase0			(inphase0),
		.inphase1			(inphase1),
		.inphase2			(inphase2),
		.inphase3			(inphase3),
		.quadrature0		(quadrature0),
		.quadrature1		(quadrature1),
		.quadrature2		(quadrature2),
		.quadrature3		(quadrature3)
	);
	// ---------------------------------------------
	// Параметры сигнала
	// ---------------------------------------------
	real Fs_adc = 1_000.0;      // МГц (1 ГГц)
	real Fsig   = 200.0;        // МГц
	real t = 0.0;
	real Ts = 0.001;            // шаг 1 ps для удобства (timeunit 1ns → умножаем ниже)
	
	// Функция синуса -> 12-bit signed
	function automatic [11:0] sin12(input real phase);
		real v;
		begin
			v = $sin(phase);
			sin12 = $rtoi(v * 2047.0);   // full scale 12-bit signed
		end
	endfunction

	// ---------------------------------------------
	// Генерация DDR данных АЦП
	// ---------------------------------------------
	// Канал A
	always @(posedge clk_ads_a) begin
		adc_data_a <= sin12(2*3.1415926535 * Fsig * t);
		t <= t + 0.002;   // +2 ps (половина периода 1 GHz)
	end

	always @(negedge clk_ads_a) begin
		adc_data_a <= sin12(2*3.1415926535 * Fsig * t);
		t <= t + 0.002;
	end

	// Канал B — тот же сигнал, можно сместить фазу на 90°, если нужно
	always @(posedge clk_ads_b) begin
		adc_data_b <= sin12(2*3.1415926535 * Fsig * t);
	end

	always @(negedge clk_ads_b) begin
		adc_data_b <= sin12(2*3.1415926535 * Fsig * t);
	end

	initial begin
		rst = 1;
		adc_data_a = 0;
		adc_data_b = 0;

		#120 rst = 0;

		// Работаем 5 мкс
		#5000;

		$finish;
	end

endmodule