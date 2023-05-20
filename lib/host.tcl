# host screen

package require dns

oo::object create host

oo::objdefine host {
    variable scr 

    method definescreen {} {
        set scr [namespace tail [self]]
	lcd defscr $scr
    }

    method updatescreen {} {
        set host [info host]
        set ip [ dns::address [dns::resolve $host]] 
	lcd putlines $scr [list {} "hostname = $host" "ip = $ip" {}]
    }
}

package provide host 1.0
