#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Jun  8 20:01:29 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v20.10-p004_1 (64bit) 05/07/2020 20:02 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.10-p004_1 NR200413-0234/20_10-UB (database version 18.20.505) {superthreading v1.69}
#@(#)CDS: AAE 20.10-p005 (64bit) 05/07/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.10-p005_1 () Apr 14 2020 09:14:28 ( )
#@(#)CDS: SYNTECH 20.10-b004_1 () Mar 12 2020 22:18:21 ( )
#@(#)CDS: CPE v20.10-p006
#@(#)CDS: IQuantus/TQuantus 19.1.3-s155 (64bit) Sun Nov 3 18:26:52 PST 2019 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_verilog tile_pe.vg
set init_mmmc_file tile_pe.view
set init_gnd_net VSS
set init_pwr_net VDD
set init_lef_file /synopsys/Nangate_FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Back_End/lef/NangateOpenCellLibrary.lef
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set enc_enable_print_mode_command_reset_options 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set report_inactive_arcs_format {from to when arc_type sense reason}
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
set timing_enable_default_delay_arc 1
set init_verilog tile_pe.vg
set init_mmmc_file tile_pe.view
set init_gnd_net VSS
set init_pwr_net VDD
set init_lef_file /synopsys/Nangate_FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Back_End/lef/NangateOpenCellLibrary.lef
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set enc_enable_print_mode_command_reset_options 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set report_inactive_arcs_format {from to when arc_type sense reason}
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
set timing_enable_default_delay_arc 1
init_design
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.958904109589 0.699968 10.0 10 10 10
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.885627530364 0.699231 1 1 1 1
uiSetTool select
getIoFlowFlag
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename *
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename *
globalNetConnect VSS -type tielo -pin VSS -instanceBasename *
globalNetConnect VDD -type tiehi -pin VDD -instanceBasename *
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 10 -stop_offset 10 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None
undo
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.81494057725 0.698157 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.746580106654 0.696418 10 10 10 10
uiSetTool select
getIoFlowFlag
fit
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None
undo
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 5 -stop_offset 5 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None
fit
setSrouteMode -viaConnectToShape { stripe }
sroute -connect { corePin } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VSS VDD } -allowLayerChange 1 -targetViaLayerRange { metal1(1) metal10(10) }
saveFPlan tile_pe.fp
setDesignMode -process 45
timeDesign -prePlace
timeDesign -prePlace -hold
place_opt_design
timeDesign -preCTS
timeDesign -preCTS -hold
create_ccopt_clock_tree_spec
ctd_win -side none -id ctd_window
ccopt_design
timeDesign -postCTS
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS
timeDesign -postCTS -hold
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -hold
zoomBox -8.68200 5.18050 79.35950 40.55200
zoomBox -0.95000 6.88450 73.88600 36.95050
zoomBox -29.31050 0.49500 92.54800 49.45300
zoomBox -0.95200 6.90950 73.88650 36.97650
zoomBox 13.80400 12.11950 52.87100 27.81500
zoomBox 16.29550 12.87550 49.50300 26.21700
zoomBox 23.10650 14.87700 40.44150 21.84150
zoomBox 16.18600 12.90600 49.39600 26.24850
zoomBox 7.06800 10.31550 61.14500 32.04150
selectInst {acc_reg_out_reg[14]}
fit
deselectAll
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -timingEngine {}
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {CLKBUF_X3 CLKBUF_X2 CLKBUF_X1 BUF_X32 BUF_X16 BUF_X8 BUF_X4 BUF_X2 BUF_X1 INV_X32 INV_X16 INV_X8 INV_X4 INV_X2 INV_X1} -maxAllowedDelay 1
setOptMode -effort high -powerEffort none -leakageToDynamicRatio 1 -reclaimArea true -simplifyNetlist true -allEndPoints false -setupTargetSlack 0 -holdTargetSlack -0.2 -maxDensity 0.85 -drcMargin 0 -usefulSkew true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -hold
getCTSMode -engine -quiet
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postCTS -hold -incr
optDesign -postCTS -hold
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell tile_pe -pin {acc_in[0]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[1]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[2]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[3]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[4]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[5]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[6]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[7]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[8]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[9]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[10]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[11]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[12]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[13]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[14]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[15]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[16]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[17]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[18]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[19]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[20]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[21]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[22]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[23]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[24]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[25]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[26]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[27]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[28]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[29]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[30]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {acc_in[31]} -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 1 -spreadType center -spacing 1.4 -pin {{acc_in[0]} {acc_in[1]} {acc_in[2]} {acc_in[3]} {acc_in[4]} {acc_in[5]} {acc_in[6]} {acc_in[7]} {acc_in[8]} {acc_in[9]} {acc_in[10]} {acc_in[11]} {acc_in[12]} {acc_in[13]} {acc_in[14]} {acc_in[15]} {acc_in[16]} {acc_in[17]} {acc_in[18]} {acc_in[19]} {acc_in[20]} {acc_in[21]} {acc_in[22]} {acc_in[23]} {acc_in[24]} {acc_in[25]} {acc_in[26]} {acc_in[27]} {acc_in[28]} {acc_in[29]} {acc_in[30]} {acc_in[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 1 -spreadType center -spacing 1 -pin {{acc_in[0]} {acc_in[1]} {acc_in[2]} {acc_in[3]} {acc_in[4]} {acc_in[5]} {acc_in[6]} {acc_in[7]} {acc_in[8]} {acc_in[9]} {acc_in[10]} {acc_in[11]} {acc_in[12]} {acc_in[13]} {acc_in[14]} {acc_in[15]} {acc_in[16]} {acc_in[17]} {acc_in[18]} {acc_in[19]} {acc_in[20]} {acc_in[21]} {acc_in[22]} {acc_in[23]} {acc_in[24]} {acc_in[25]} {acc_in[26]} {acc_in[27]} {acc_in[28]} {acc_in[29]} {acc_in[30]} {acc_in[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Right -layer 1 -spreadType center -spacing 1.12 -pin {{acc_reg_out[0]} {acc_reg_out[1]} {acc_reg_out[2]} {acc_reg_out[3]} {acc_reg_out[4]} {acc_reg_out[5]} {acc_reg_out[6]} {acc_reg_out[7]} {acc_reg_out[8]} {acc_reg_out[9]} {acc_reg_out[10]} {acc_reg_out[11]} {acc_reg_out[12]} {acc_reg_out[13]} {acc_reg_out[14]} {acc_reg_out[15]} {acc_reg_out[16]} {acc_reg_out[17]} {acc_reg_out[18]} {acc_reg_out[19]} {acc_reg_out[20]} {acc_reg_out[21]} {acc_reg_out[22]} {acc_reg_out[23]} {acc_reg_out[24]} {acc_reg_out[25]} {acc_reg_out[26]} {acc_reg_out[27]} {acc_reg_out[28]} {acc_reg_out[29]} {acc_reg_out[30]} {acc_reg_out[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing -1.12 -pin {{cfg_addr[0]} {cfg_addr[1]} {cfg_addr[2]} {cfg_addr[3]} {cfg_addr[4]} {cfg_addr[5]} {cfg_addr[6]} {cfg_addr[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing -1.12 -pin {{cfg_addr[0]} {cfg_addr[1]} {cfg_addr[2]} {cfg_addr[3]} {cfg_addr[4]} {cfg_addr[5]} {cfg_addr[6]} {cfg_addr[7]}}
setPinAssignMode -pinEditInBatch false
fit
zoomBox -47.93400 -6.25350 120.72450 61.50650
zoomBox -57.50600 -10.12350 140.91600 69.59450
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin {{cfg_addr[0]} {cfg_addr[1]} {cfg_addr[2]} {cfg_addr[3]} {cfg_addr[4]} {cfg_addr[5]} {cfg_addr[6]} {cfg_addr[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin {{cfg_data[0]} {cfg_data[1]} {cfg_data[2]} {cfg_data[3]} {cfg_data[4]} {cfg_data[5]} {cfg_data[6]} {cfg_data[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin cfg_valid
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin clk
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin clk
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin {{core_col[0]} {core_col[1]} {core_col[2]} {core_col[3]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin {{core_row[0]} {core_row[1]} {core_row[2]} {core_row[3]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Bottom -layer 1 -spreadType range -start 34.675 0.0 -end 28.975 0.0 -pin {{core_row[0]} {core_row[1]} {core_row[2]} {core_row[3]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing 1.0 -start 0.0 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell tile_pe -pin {global_state[0]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {global_state[1]} -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell tile_pe -pin {global_state[0]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {global_state[1]} -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell tile_pe -pin {global_state[0]} -status unplaced -silent
setPtnPinStatus -cell tile_pe -pin {global_state[1]} -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Bottom -layer 1 -spreadType range -start 0.0 0.0 -end 0.0 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing -63.08 -start 63.175 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing -63.08 -start 63.175 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing -63.08 -start 63.175 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing -63.08 -start 63.175 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing -63.08 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 1 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing 1 -start 33.345 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Bottom -layer 1 -spreadType range -start 33.345 0.0 -end 31.635 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Bottom -layer 1 -spreadType side -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType start -spacing -63.08 -start 63.175 0.0 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing -63.08 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing -63.08 -pin {{global_state[0]} {global_state[1]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin rst_n
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType center -spacing 0.14 -pin {{x_in[0]} {x_in[1]} {x_in[2]} {x_in[3]} {x_in[4]} {x_in[5]} {x_in[6]} {x_in[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.19 -pin {{x_reg_out[0]} {x_reg_out[1]} {x_reg_out[2]} {x_reg_out[3]} {x_reg_out[4]} {x_reg_out[5]} {x_reg_out[6]} {x_reg_out[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.19 -pin {{x_reg_out[0]} {x_reg_out[1]} {x_reg_out[2]} {x_reg_out[3]} {x_reg_out[4]} {x_reg_out[5]} {x_reg_out[6]} {x_reg_out[7]}}
setPinAssignMode -pinEditInBatch false
place_opt_design
timeDesign -preCTS -hold
ccopt_design
zoomBox -13.94950 -8.82600 89.62850 32.78750
zoomBox 4.37350 -8.27950 67.98400 17.27650
zoomBox 12.50050 -5.95050 58.45950 12.51400
zoomBox 22.61400 -3.13800 46.60600 6.50100
zoomBox 28.65400 -1.75150 39.29950 2.52550
zoomBox 29.37650 -1.58600 38.42550 2.04950
zoomBox 25.71500 -2.44500 43.05050 4.51950
zoomBox 18.70150 -4.09000 51.91100 9.25200
zoomBox 9.48100 -6.25300 63.55800 15.47300
zoomBox -5.53300 -9.77400 82.52400 25.60350
zoomBox 5.26350 -7.26650 68.88500 18.29400
zoomBox -12.39950 -11.37000 91.19800 30.25150
zoomBox -20.47750 -13.24650 101.40250 35.72000
zoomBox -41.16050 -18.05100 127.53100 49.72250
fit
zoomBox -28.09550 13.17150 59.94600 48.54300
zoomBox -18.10000 24.25000 27.85950 42.71450
zoomBox -14.12300 27.05450 19.08300 40.39550
zoomBox -9.97800 29.84750 10.41500 38.04050
fit
set_ccopt_property buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_ccopt_property inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32}
ccopt_design
getCTSMode -engine -quiet
getCTSMode -engine -quiet
ctd_win -side none -id ctd_window
timeDesign -preCTS -hold
timeDesign -postCTS -hold
optDesign -postCTS -hold
