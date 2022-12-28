# date/time screen


oo::object create uptime

oo::objdefine uptime {
    variable scr 

    method definescreen {} {
        set scr [namespace tail [self]]

        lcd puts "screen_add $scr"
        lcd puts "screen_set $scr -heartbeat off"
        lcd puts "widget_add $scr ${scr}1 string"
        lcd puts "widget_add $scr ${scr}2 string"
        lcd puts "widget_add $scr ${scr}3 string"
        lcd puts "widget_add $scr ${scr}4 string"
        lcd puts "widget_set $scr ${scr}1 1 1 {}"
        lcd puts "widget_set $scr ${scr}3 1 3 {}"
        lcd puts "widget_set $scr ${scr}4 1 4 {}"
    }

    method updatescreen {} {

        namespace path [list ::tcl::mathop ::tcl::mathfunc]

        set fd [open /proc/uptime r]
        lassign [read $fd ] up idle
        close $fd

        set days [/ [int $up] 86400]
        set hour [/ [% [int $up] 86400] 3600]
        set min  [/ [% [int $up] 3600] 60]
        set sec     [% [int $up] 60] 

        set uptime [format "Up %d days %02d:%02d:%02d" $days $hour $min $sec]
        lcd puts "widget_set $scr ${scr}2 1 2 {$uptime}"
    }
}

package provide uptime 1.0
