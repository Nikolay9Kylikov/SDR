// rom_sincos.v
// Simple ROM using $readmemh (synthesizes to BRAM). Dual instances allow 4 parallel reads by replication.
// This module implements one ROM (single-port synchronous). Top will instantiate 4 copies or 2 dual-port.
module rom_sincos #(
  parameter ADDR_W = 12,         // address width (4096 entries)
  parameter DATA_W = 16          // output width signed
) (
  input  wire                 clk,
  input  wire [ADDR_W-1:0]    addr,
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
  always @(posedge clk) begin
    data_out <= mem[addr];
  end
endmodule
