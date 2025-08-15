if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name nangate_libset_fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_fast_ccs.lib]
create_library_set -name nangate_libset_worst\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_worst_low_ccs.lib]
create_library_set -name nangate_libset_typical\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_typical_ccs.lib]
create_timing_condition -name nangate_tc_fast\
   -library_sets [list nangate_libset_fast]
create_timing_condition -name nangate_tc_worst\
   -library_sets [list nangate_libset_worst]
create_timing_condition -name nangate_tc_typical\
   -library_sets [list nangate_libset_typical]
create_rc_corner -name nangate_rc_typical\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0
create_delay_corner -name nangate_delay_corner_typical\
   -timing_condition {nangate_tc_typical}\
   -rc_corner nangate_rc_typical
create_delay_corner -name nangate_delay_corner_fast\
   -timing_condition {nangate_tc_fast}\
   -rc_corner nangate_rc_typical
create_delay_corner -name nangate_delay_corner_worst\
   -timing_condition {nangate_tc_worst}\
   -rc_corner nangate_rc_typical
create_constraint_mode -name nangate_constraint_mode\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/top.sdc]
create_analysis_view -name nangate_view_setup -constraint_mode nangate_constraint_mode -delay_corner nangate_delay_corner_worst
create_analysis_view -name nangate_view_hold -constraint_mode nangate_constraint_mode -delay_corner nangate_delay_corner_fast
set_analysis_view -setup [list nangate_view_setup] -hold [list nangate_view_hold]
