#!/usr/bin/env tclsh
# tcllcd

lappend auto_path lib
package require task
package require lcd
package require led
Led create led1
Led create led2
Led create led3

# database
package require tdbc::postgres
set conninfo [list -host localhost -db gis -user gis]
tdbc::postgres::connection create db {*}$conninfo

# define screens
# set screens [list datetime host uptime gps mga56 tmr nav]
package require fileutil
set datadir /mnt/usb
set screens [fileutil::cat [file join $datadir screens.txt]]
puts $screens
proc definescreens {} {
    foreach scr $::screens {
        puts $scr
        package require $scr
        $scr definescreen
    }
}

# event loop
proc listen {} {
    task start
}
proc ignore {} {
    task stop
    led1 off
    led2 off
    led3 off
}
proc updatescreen {} {
      catch { [lcd screen] updatescreen } 
}
proc init {} {
    lcd connect
    task init
    task repeat 200
    #task repeat 2000
    definescreens
    task action updatescreen
    lcd onlisten listen
    lcd onignore ignore
}
after 0 init
vwait forever

# vim: set ft=tcl et sts=4 sw=4 tw=80:
