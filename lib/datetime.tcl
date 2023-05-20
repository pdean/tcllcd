# date/time screen

oo::object create date

oo::objdefine date {
    variable scr 

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd defscr $scr
    }

    method updatescreen {} {
        set time [clock format [clock seconds] -format %X -locale current]
        set date [clock format [clock seconds] -format %x -locale current]
        lcd putlines $scr [list {} $time $date {}]
    }
}

package provide date 1.0
