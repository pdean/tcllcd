package require fileutil

set screens [split [fileutil::cat /mnt/usb/screens.txt]]

puts [join $screens \n]
