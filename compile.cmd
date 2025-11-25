@echo off
cls
echo Compile and simulate
if exist logs rmdir /q /s logs
if exist lib rmdir /q /s lib
if exist "./compile.log" del "./compile.log"

mkdir logs
mkdir lib
vlib lib\top											>> compile.log
vlib lib\tb												>> compile.log

vmap top lib\top										>> compile.log
vmap tb lib\tb											>> compile.log

vlog	-work top ./top.v								>> compile.log
vlog	-work top ./phase_acc.v							>> compile.log
vlog	-work top ./cordic.v							>> compile.log

vlog	-sv	-work tb ./tb_top.sv						>> compile.log

vsim -gui -do "do run.do"