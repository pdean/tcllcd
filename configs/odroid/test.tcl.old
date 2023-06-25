lappend auto_path .
package require led

proc wait {ms} {
    after $ms [list set ::_wait_flag 1]
    vwait ::_wait_flag
}

Led create yellow 
Led create green 
Led create red 

red blink
wait 5000
red blink
red blink
wait 2000
yellow blink
wait 2000
yellow on
green blink
wait 5123

foreach led [info class instances Led] {
    puts "$led off"
    $led off
}
