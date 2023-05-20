# date/time screen

oo::object create datetime

oo::objdefine datetime {
    variable scr 

    method definescreen {} {
        set scr [namespace tail [self]]
        lcd defscr $scr
    }

    method updatescreen {} {
        set time [clock format [clock seconds] -format %X -locale en_au]
        set date [clock format [clock seconds] -format %x -locale en_au]
        lcd putlines $scr [list {} $time $date {}]
    }
}

package provide datetime 1.0
