# gps position

package require gpsd
package require trig

oo::object create gps

oo::objdefine gps {
    variable scr GPS

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd defscr $scr
        set GPS [gpsd new]
    }

    method updatescreen {} {

        set data [$GPS poll]
        set tpv [lindex [dict get $data tpv] end]
        set sky [lindex [dict get $data sky] end]
        dict with tpv {}
        dict with sky {}
        if {[info exists mode]} {
            if {$mode >=2} {
                if {![info exists track]} { set track 0.0 }
                set l1 [format "lat: %.6f" $lat]
                set l2 [format "lon: %.6f" $lon]
                set l3 "hdop: $hdop"
                set l4 "$speed m/s [compass $track]"
                lcd putlines $scr [list $l1 $l2 $l3 $l4]
            } else {
                set l1 "no fix"
                lcd putlines $scr [list $l1 $l1 $l1 $l1]
            }
        } else {
            set l1 "no gps" 
            lcd putlines $scr [list $l1 $l1 $l1 $l1]
        }
    }
}

package provide gps 1.0

# vim: set sts=4 sw=4 tw=80 et ft=tcl:
