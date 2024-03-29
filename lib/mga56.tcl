# gps position

package require gpsd
package require trig

package require proj

oo::object create mga56

oo::objdefine mga56 {
    variable scr GPS P

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd defscr $scr
        set GPS [gpsd new]
        set P [proj_create_crs_to_crs  epsg:4326  epsg:7856 ]
    }

    method updatescreen {} {
        set data [$GPS poll]
        set tpv [lindex [dict get $data tpv] end]
        set sky [lindex [dict get $data sky] end]
        dict with tpv {}
        dict with sky {}
        if {![info exists mode]} {
            set l1 "NO GPS?" 
            lcd putlines $scr [list $l1 {} {} {}]
            return
        }
        if {$mode < 2} {
            set l1 "NO FIX"
            lcd putlines $scr [list $l1 {} {} {}]
            return
        }
        if {![info exists track]} { set track 0.0 }
        lassign [proj_fwd $P [list $lat $lon]] east north
        set l1 [format "E%9.1f" $east]
        set l2 [format "N%9.1f" $north]
        set l3 "hdop: $hdop"
        set l4 "$speed m/s [compass $track]"
        lcd putlines $scr [list $l1 $l2 $l3 $l4]
    }
}

package provide mga56 1.0

# vim: set sts=4 sw=4 tw=80 et ft=tcl:
