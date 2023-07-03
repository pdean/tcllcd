#!/usr/bin/env tclsh
# tcllcd

set datadir /mnt/usb

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
#set screens [list date  uptime gps]
#set screens [list datetime uptime gps tmr]
#set screens [list datetime host uptime gps mga56 tmr]
set screens [list datetime host uptime gps mga56 tmr nav]
proc definescreens {} {
    foreach scr $::screens {
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
}
proc updatescreen {} {
      catch { [lcd screen] updatescreen } 
}

proc init {} {
    lcd connect
    task init
    task repeat 500
    definescreens
    task action updatescreen
    lcd onlisten listen
    lcd onignore ignore
}
after 0 init
vwait forever

# vim: set ft=tcl et sts=4 sw=4 tw=80:
