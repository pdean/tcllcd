lappend auto_path .
package require led

proc wait {ms} {
    after $ms [list set ::_wait_flag 1]
    vwait ::_wait_flag
}

Led create led1 
Led create led2 
Led create led3 

led1 blink
wait 5000
led1 blink
led1 blink
wait 2000
led2 blink
wait 2000
led2 on
led3 blink
wait 5123

foreach led [info class instances Led] {
    puts "$led off"
    $led off
}
