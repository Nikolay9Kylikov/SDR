// rom_sincos.v
// Simple ROM using $readmemh (synthesizes to BRAM). Dual instances allow 4 parallel reads by replication.
// This module implements one ROM (single-port synchronous). Top will instantiate 4 copies or 2 dual-port.
module rom_sincos #(
  parameter ADDR_W = 12,         // address width (4096 entries)
  parameter DATA_W = 16          // output width signed
) (
  input  wire                 clk_i,
  input  wire [ADDR_W-1:0]    addr_i,
  output reg signed [DATA_W-1:0] data_out
);
  // depth
  localparam DEPTH = (1<<ADDR_W);

  // inference of BRAM using array + $readmemh
  reg signed [DATA_W-1:0] mem [0:DEPTH-1];

  initial begin
    // Please place sin_rom.hex / cos_rom.hex next to your source or change path.
    // Fill by synthesis/simulaton step
    $readmemh("rom_data.hex", mem);
  end

  // synchronous read (1 cycle latency)
  always @(posedge clk_i) begin
    data_out <= mem[addr_i];
  end
endmodule
/* можно по 2 старшим битам фазы определить четверть приращения фазы, то есть синусоиды 
и тогда можно уменьшить количество памяти в 8 раз(в 4 по син, и в 4 по 4 кос)

case(addr[32:31])
  00:нормальная адресация
  01:max-адресация
  10:нормальная адресация только с '-'
  11:max-адресация только с '-'
*/ 