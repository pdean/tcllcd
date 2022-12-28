# date/time screen

oo::object create date

oo::objdefine date {
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
        set time [clock format [clock seconds] -format %X -locale current]
        set date [clock format [clock seconds] -format %x -locale current]
        lcd puts "widget_set $scr ${scr}2 1 2 {time = $time}"
        lcd puts "widget_set $scr ${scr}3 1 3 {date = $date}"
    }
}

package provide date 1.0
