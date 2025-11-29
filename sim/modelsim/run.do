vsim -voptargs="+acc" -L top -L tb -t ps tb.tb_top xilinx.glbl

log * -r

do wave.do

run -all