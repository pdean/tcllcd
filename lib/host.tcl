# host screen

package require dns

oo::object create host

oo::objdefine host {
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
        lcd puts "widget_set $scr ${scr}4 1 4 {}"
    }

    method updatescreen {} {
        set host [info host]
        set ip [ dns::address [dns::resolve $host]] 
        lcd puts "widget_set $scr ${scr}2 1 2 {hostname = $host}"
        lcd puts "widget_set $scr ${scr}3 1 3 {ip = $ip}"
    }
}

package provide host 1.0
