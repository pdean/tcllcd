# date/time screen


oo::object create uptime

oo::objdefine uptime {
    variable scr 

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd defscr $scr
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
        lcd putlines $scr [list {} {} $uptime {}]
    }
}

package provide uptime 1.0
