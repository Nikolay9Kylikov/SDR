onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/sysclk
add wave -noupdate /tb_top/clk_ads_a
add wave -noupdate /tb_top/clk_ads_b
add wave -noupdate /tb_top/rst
add wave -noupdate /tb_top/sdr/wr_en_fifo_a
add wave -noupdate /tb_top/sdr/wr_en_fifo_b
add wave -noupdate /tb_top/adc_data_a
add wave -noupdate /tb_top/adc_data_b
add wave -noupdate /tb_top/inphase0
add wave -noupdate /tb_top/inphase1
add wave -noupdate /tb_top/inphase2
add wave -noupdate /tb_top/inphase3
add wave -noupdate /tb_top/quadrature0
add wave -noupdate /tb_top/quadrature1
add wave -noupdate /tb_top/quadrature2
add wave -noupdate /tb_top/quadrature3
add wave -noupdate /tb_top/Fs_adc
add wave -noupdate /tb_top/Fsig
add wave -noupdate /tb_top/t
add wave -noupdate /tb_top/Ts
add wave -noupdate -divider adc_channel
add wave -noupdate /tb_top/sdr/adc_channel/double_data_a
add wave -noupdate /tb_top/sdr/adc_channel/data_a_rise_o
add wave -noupdate /tb_top/sdr/adc_channel/data_a_fall_o
add wave -noupdate /tb_top/sdr/adc_channel/double_data_b
add wave -noupdate /tb_top/sdr/adc_channel/data_a_o
add wave -noupdate /tb_top/sdr/adc_channel/data_b_o
add wave -noupdate -divider fifo
add wave -noupdate /tb_top/sdr/fifo4/wr_data_a_i
add wave -noupdate /tb_top/sdr/fifo4/wr_data_b_i
add wave -noupdate /tb_top/sdr/fifo4/data_adc_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101915 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
configure wave -valuecolwidth 109
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {93404 ps} {120898 ps}
