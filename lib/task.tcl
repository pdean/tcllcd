# tasks

oo::object create task

oo::objdefine task {
    variable Action Timer Repeat

    method init {} {
        set Action [list ::puts]
        set Repeat 1000
        set Timer {}
    }

    method  start {} {
        uplevel 0 $Action
        set Timer [after $Repeat [list [self] start]]
    }

    method stop {} { 
        after cancel $Timer 
    }

    method repeat {repeat} { set Repeat $repeat }
    method action {action} { set Action $action }
}

package provide task 1.0

# vim: set ft=tcl et sts=4 sw=4 tw=80:
