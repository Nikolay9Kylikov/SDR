vsim -voptargs="+acc" -L top -L tb -t ps tb.tb_top

log * -r

do wave.do

run -all