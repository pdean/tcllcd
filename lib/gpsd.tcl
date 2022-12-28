# gpsd

package require json  

oo::class create gpsd {
    variable Sock 

    constructor {} {
        set Sock [socket localhost 2947]
        puts $Sock {?WATCH={"enable":true}}
        flush $Sock
    }

    destructor { close $Sock }

    method poll {} {
        puts $Sock {?POLL;}
        flush $Sock
        while 1 {
            gets $Sock line
            set data [::json::json2dict $line]
            set class [dict get $data class]
            if {$class eq "POLL"} { return $data } 
            puts $data
        }
    }
}

package provide gpsd 1.0
