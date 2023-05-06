#!/usr/bin/env tclsh
# tcllcd

lappend auto_path lib
package require task
package require lcd

# define screens
set screens [list date  uptime gps]
#set screens [list date host uptime gps]
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
