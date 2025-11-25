onerror {resume}
quietly virtual signal -install /tb_top/top/phase_gen { /tb_top/top/phase_gen/phase_o[31:0]} phase0
quietly virtual signal -install /tb_top/top/phase_gen { /tb_top/top/phase_gen/phase_o[63:32]} phase1
quietly virtual signal -install /tb_top/top/phase_gen { /tb_top/top/phase_gen/phase_o[95:64]} phase2
quietly virtual signal -install /tb_top/top/phase_gen { /tb_top/top/phase_gen/phase_o[127:96]} phase3
quietly virtual function -install /tb_top/top/cordic0 -env /tb_top/top/cordic0 { &{/tb_top/top/cordic0/quadrant[31], /tb_top/top/cordic0/quadrant[30] }} quadr
quietly virtual signal -install /tb_top/top/cordic0 { /tb_top/top/cordic0/phase_i[31:30]} PHASE_Q
quietly virtual signal -install /tb_top/top/cordic0 { /tb_top/top/cordic0/phase_i[29:0]} phase
quietly virtual function -install /tb_top/top/cordic0 -env /tb_top/top/cordic0 { &{/tb_top/top/cordic0/quadrant[33], /tb_top/top/cordic0/quadrant[32] }} quasr_last
quietly virtual function -install /tb_top/top/cordic0 -env /tb_top/top/cordic0 { &{/tb_top/top/cordic0/quadrant[1], /tb_top/top/cordic0/quadrant[0] }} q_f
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/rst
add wave -noupdate /tb_top/top/cordic0/rst_i
add wave -noupdate /tb_top/top/cordic0/valid_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_top/top/phase_gen/phase0
add wave -noupdate /tb_top/top/phase_gen/phase1
add wave -noupdate /tb_top/top/phase_gen/phase2
add wave -noupdate /tb_top/top/phase_gen/phase3
add wave -noupdate -divider CORDIC0
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_top/top/cordic0/valid_i
add wave -noupdate /tb_top/top/cordic0/valid_o
add wave -noupdate /tb_top/top/cordic0/sin_o
add wave -noupdate /tb_top/top/cordic0/cos_o
add wave -noupdate -expand /tb_top/top/cordic0/valid_stage
add wave -noupdate /tb_top/top/cordic0/phase
add wave -noupdate -divider THETA
add wave -noupdate {/tb_top/top/cordic0/theta[0]}
add wave -noupdate {/tb_top/top/cordic0/theta[1]}
add wave -noupdate {/tb_top/top/cordic0/theta[2]}
add wave -noupdate {/tb_top/top/cordic0/theta[3]}
add wave -noupdate {/tb_top/top/cordic0/theta[4]}
add wave -noupdate {/tb_top/top/cordic0/theta[5]}
add wave -noupdate {/tb_top/top/cordic0/theta[6]}
add wave -noupdate {/tb_top/top/cordic0/theta[7]}
add wave -noupdate {/tb_top/top/cordic0/theta[8]}
add wave -noupdate {/tb_top/top/cordic0/theta[9]}
add wave -noupdate {/tb_top/top/cordic0/theta[10]}
add wave -noupdate {/tb_top/top/cordic0/theta[11]}
add wave -noupdate {/tb_top/top/cordic0/theta[12]}
add wave -noupdate {/tb_top/top/cordic0/theta[13]}
add wave -noupdate {/tb_top/top/cordic0/theta[14]}
add wave -noupdate {/tb_top/top/cordic0/theta[15]}
add wave -noupdate {/tb_top/top/cordic0/theta[16]}
add wave -noupdate -divider X
add wave -noupdate /tb_top/top/cordic0/PHASE_Q
add wave -noupdate /tb_top/top/cordic0/quadr
add wave -noupdate /tb_top/top/cordic0/quasr_last
add wave -noupdate /tb_top/top/cordic0/q_f
add wave -noupdate {/tb_top/top/cordic0/x[0]}
add wave -noupdate {/tb_top/top/cordic0/x[1]}
add wave -noupdate {/tb_top/top/cordic0/x[2]}
add wave -noupdate {/tb_top/top/cordic0/x[3]}
add wave -noupdate {/tb_top/top/cordic0/x[4]}
add wave -noupdate {/tb_top/top/cordic0/x[5]}
add wave -noupdate {/tb_top/top/cordic0/x[6]}
add wave -noupdate {/tb_top/top/cordic0/x[7]}
add wave -noupdate {/tb_top/top/cordic0/x[8]}
add wave -noupdate {/tb_top/top/cordic0/x[9]}
add wave -noupdate {/tb_top/top/cordic0/x[10]}
add wave -noupdate {/tb_top/top/cordic0/x[11]}
add wave -noupdate {/tb_top/top/cordic0/x[12]}
add wave -noupdate {/tb_top/top/cordic0/x[13]}
add wave -noupdate {/tb_top/top/cordic0/x[14]}
add wave -noupdate {/tb_top/top/cordic0/x[15]}
add wave -noupdate {/tb_top/top/cordic0/x[16]}
add wave -noupdate -divider y
add wave -noupdate {/tb_top/top/cordic0/y[0]}
add wave -noupdate {/tb_top/top/cordic0/y[1]}
add wave -noupdate {/tb_top/top/cordic0/y[2]}
add wave -noupdate {/tb_top/top/cordic0/y[3]}
add wave -noupdate {/tb_top/top/cordic0/y[4]}
add wave -noupdate {/tb_top/top/cordic0/y[5]}
add wave -noupdate {/tb_top/top/cordic0/y[6]}
add wave -noupdate {/tb_top/top/cordic0/y[7]}
add wave -noupdate {/tb_top/top/cordic0/y[8]}
add wave -noupdate {/tb_top/top/cordic0/y[9]}
add wave -noupdate {/tb_top/top/cordic0/y[10]}
add wave -noupdate {/tb_top/top/cordic0/y[12]}
add wave -noupdate {/tb_top/top/cordic0/y[11]}
add wave -noupdate {/tb_top/top/cordic0/y[13]}
add wave -noupdate {/tb_top/top/cordic0/y[14]}
add wave -noupdate {/tb_top/top/cordic0/y[15]}
add wave -noupdate {/tb_top/top/cordic0/y[16]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {108077 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 249
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
WaveRestoreZoom {74215 ps} {157027 ps}
