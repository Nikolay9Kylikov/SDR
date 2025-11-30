clear
echo "Compiling..."

xmvlog -64 -nocopyright		../../rtl/*.v
xmvlog -64 -nocopyright		../../rtl/oscillator/*.v
xmvlog -64 -nocopyright		../../rtl/fifo/*.v
xmvlog -64 -nocopyright		../../xilinx/*.v

xmvlog -64 -nocopyright	-sv	../tb_top.sv

xmelab -64 -access rw tb_top glbl
xmsim -64 -gui tb_top