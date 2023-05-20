# lcd

oo::object create lcd

oo::objdefine lcd {
    variable Sock Wid Hgt Screen Onlisten Onignore last

    method connect {} {
        set Sock [socket localhost 13666]
        chan configure $Sock -blocking no
        chan event $Sock readable [list [self] read]
        set Screen {}
        set Onlisten {}
        set Onignore {}
        my puts "hello"
        my puts "client_set name {tcllcd}"
    }

    method read {} {
        if {[gets $Sock line] < 0} {return}
        set cmd [lindex $line 0]
        switch $cmd {
            connect {
                set Wid [lindex $line 7]
                set Hgt [lindex $line 9]
            }
            listen {
                set Screen [lindex $line 1]
                tailcall {*}$Onlisten
            }
            ignore {
                set Screen {}
                tailcall {*}$Onignore
            }
            success { }
            default {
                puts $line
                puts "    $last"
            }
        }
    }

    method onlisten {script} { set Onlisten $script }
    method onignore {script} { set Onignore $script }
    method screen {} {set Screen}

    method puts {str} {
        set last $str
        puts $Sock $str
        flush $Sock
    }

    method defscr {scr} {
        my puts "screen_add $scr"
        my puts "screen_set $scr -heartbeat off"
        my puts "widget_add $scr ${scr}1 string"
        my puts "widget_add $scr ${scr}2 string"
        my puts "widget_add $scr ${scr}3 string"
        my puts "widget_add $scr ${scr}4 string"
    }

    method putlines {scr lines} {
        set n 0
        foreach line $lines {
            incr n
            my puts "widget_set $scr ${scr}$n 1 $n {$line}"
        }
    }
}

package provide lcd 1.0
