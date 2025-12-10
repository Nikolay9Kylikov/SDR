set_property PACKAGE_PIN AB11 [get_ports sysclk_p]
set_property PACKAGE_PIN AC11 [get_ports sysclk_n]

create_clock -period 4.0 -name sysclk [get_ports sysclk_p]

set_property PACKAGE_PIN AA10 [get_ports clk_ads_ap]
set_property PACKAGE_PIN AB10 [get_ports clk_ads_an]

create_clock -period 4.0 -name clk_ads_a [get_ports clk_ads_ap]

set_property PACKAGE_PIN AA17 [get_ports clk_ads_bp]
set_property PACKAGE_PIN AA18 [get_ports clk_ads_bn]

create_clock -period 4.0 -name clk_ads_b [get_ports clk_ads_bp]

set_clock_groups -asynchronous \
   -group {clk_ads_a clk_ads_b} \
   -group {sysclk}


set_property -dict {PACKAGE_PIN Y8 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[0]]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[0]]

set_property -dict {PACKAGE_PIN Y11 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[1]]
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[1]]

set_property -dict {PACKAGE_PIN AE7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[2]]
set_property -dict {PACKAGE_PIN AF7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[2]]

set_property -dict {PACKAGE_PIN AA8 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[3]]
set_property -dict {PACKAGE_PIN AA7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[3]]

set_property -dict {PACKAGE_PIN AB7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[4]]
set_property -dict {PACKAGE_PIN AC7 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[4]]

set_property -dict {PACKAGE_PIN AA13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[5]]
set_property -dict {PACKAGE_PIN AA12 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[5]]

set_property -dict {PACKAGE_PIN AC13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[6]]
set_property -dict {PACKAGE_PIN AD13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[6]]

set_property -dict {PACKAGE_PIN Y13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[7]]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[7]]

set_property -dict {PACKAGE_PIN AD10 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[8]]
set_property -dict {PACKAGE_PIN AE10 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[8]]

set_property -dict {PACKAGE_PIN AE8 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[9]]
set_property -dict {PACKAGE_PIN AF8 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[9]]

set_property -dict {PACKAGE_PIN AE13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[10]]
set_property -dict {PACKAGE_PIN AF13 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[10]]

set_property -dict {PACKAGE_PIN AF10 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_ap[11]]
set_property -dict {PACKAGE_PIN AF9 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_an[11]]


set_property -dict {PACKAGE_PIN AE17 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[0]]
set_property -dict {PACKAGE_PIN AF17 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[0]]

set_property -dict {PACKAGE_PIN AF14 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[1]]
set_property -dict {PACKAGE_PIN AF15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[1]]

set_property -dict {PACKAGE_PIN AD15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[2]]
set_property -dict {PACKAGE_PIN AE15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[2]]

set_property -dict {PACKAGE_PIN AF19 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[3]]
set_property -dict {PACKAGE_PIN AF20 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[3]]

set_property -dict {PACKAGE_PIN AA14 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[4]]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[4]]

set_property -dict {PACKAGE_PIN AC14 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[5]]
set_property -dict {PACKAGE_PIN AD14 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[5]]

set_property -dict {PACKAGE_PIN AB14 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[6]]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[6]]

set_property -dict {PACKAGE_PIN AA19 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[7]]
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[7]]

set_property -dict {PACKAGE_PIN AC19 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[8]]
set_property -dict {PACKAGE_PIN AD19 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[8]]

set_property -dict {PACKAGE_PIN AB19 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[9]]
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[9]]

set_property -dict {PACKAGE_PIN V16 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[10]]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[10]]

set_property -dict {PACKAGE_PIN W15 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bp[11]]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD DIFF_HSTL_I_18} [get_ports data_bn[11]]