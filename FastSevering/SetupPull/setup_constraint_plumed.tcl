mol new ../equilibration_18mer_barbed_10cofactin_aligninner_2020/heating_equilibration/cofilactin_partial_18mer_10cofa_barbed_aligninner_ionized.equil.1.pdb waitfor all


#Tyr143, Ala144, Gly146, Thr148, Gly168, Ile341, Ile345, Leu346, Leu349, Thr351, and Met355
set tbc_string "resid 143 to 148 349 to 351"
#44-51
set dl_string "resid 44 to 52"

for {set i 1} {$i<=16} {incr i} {
    set Ai [atomselect top "segname A$i and $dl_string"]
    set ip2 [expr $i+2]
    set Aip2 [atomselect top "segname A$ip2 and $tbc_string"]
    puts "Dist $i,$ip2: [veclength [vecsub [measure center $Ai] [measure center $Aip2]]]"
}

set A1 "A9"
set A2 "A10"
set A3 "A11"
set A4 "A12"
#backbone cb, do below
set sel_A1_dl [ atomselect top "segname $A1 and protein and (backbone or name CB) and $dl_string"]
set sel_A2_dl [ atomselect top "segname $A2 and protein and (backbone or name CB) and $dl_string"]
set sel_A3_tbc [ atomselect top "segname $A3 and protein and (backbone or name CB) and $tbc_string"]
set sel_A4_tbc [ atomselect top "segname $A4 and protein and (backbone or name CB) and $tbc_string"]
set BBCB [atomselect top "segname $A1 $A2 $A3 $A4 and (backbone or name CB)"]
#
puts "plumed:"
puts "GROUP ATOMS=[ join [$sel_A1_dl get serial ] "," ] LABEL=dl1"
puts "GROUP ATOMS=[ join [$sel_A2_dl get serial ] "," ] LABEL=dl2"
puts "GROUP ATOMS=[ join [$sel_A3_tbc get serial ] "," ] LABEL=tbc1"
puts "GROUP ATOMS=[ join [$sel_A4_tbc get serial ] "," ] LABEL=tbc2"
puts "GROUP ATOMS=[ join [$BBCB get serial ] "," ] LABEL=bbcb"
exit
