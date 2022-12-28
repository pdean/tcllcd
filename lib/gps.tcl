# gps position

package require gpsd
package require trig

oo::object create gps

oo::objdefine gps {
    variable scr GPS

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd puts "screen_add $scr"
        lcd puts "screen_set $scr -heartbeat off"
        lcd puts "widget_add $scr ${scr}1 string"
        lcd puts "widget_add $scr ${scr}2 string"
        lcd puts "widget_add $scr ${scr}3 string"
        lcd puts "widget_add $scr ${scr}4 string"

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
                lcd puts "widget_set $scr ${scr}1 1 1 {[format "lat: %.6f" $lat]}"
                lcd puts "widget_set $scr ${scr}2 1 2 {[format "lon: %.6f" $lon]}"
                lcd puts "widget_set $scr ${scr}3 1 3 {hdop: $hdop}"
                lcd puts "widget_set $scr ${scr}4 1 4 {$speed m/s [compass $track]}"
            } else {
                lcd puts "widget_set $scr ${scr}1 1 1 {no fix}"
                lcd puts "widget_set $scr ${scr}2 1 2 {no fix}"
                lcd puts "widget_set $scr ${scr}3 1 3 {no fix}"
                lcd puts "widget_set $scr ${scr}4 1 4 {no fix}"
            }
        } else {
            lcd puts "widget_set $scr ${scr}1 1 1 {no gps}"
            lcd puts "widget_set $scr ${scr}2 1 2 {no gps}"
            lcd puts "widget_set $scr ${scr}3 1 3 {no gps}"
            lcd puts "widget_set $scr ${scr}4 1 4 {no gps}"
        }
    }
}

package provide gps 1.0
