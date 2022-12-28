# some maths

namespace path {::tcl::mathop ::tcl::mathfunc}

proc fmod {x y} {
    return [- $x [* [floor [/ $x $y]] $y]]
}

proc compass {a} {
    set tab [list N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW N]
    return [lindex $tab [round [/ [fmod $a 360] 22.5]]]
}

package provide trig 1.0
