clear
echo "Compiling..."

xmvlog -64 -nocopyright		../../../phase_acc.v
xmvlog -64 -nocopyright		../../../cordic.v
xmvlog -64 -nocopyright		../../../top.v
xmvlog -64 -nocopyright	-sv	../tb_top.sv

xmelab -64 -access rw tb_top
xmsim -64 -gui tb_top