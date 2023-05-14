# armbian odroid c4 bullseye  

## armbian-config  

* change kernel to 5.10 because of i2c support
* recompile dtb removing references to vrtc
* freeze

## rtc

* armbian-add pcf8563.dts  
* todo - hwclock timedatectl details
* edit /lib/udev/hwclock-set comment first if
* uninstall/disable fake-hwclock

## infrared remote

* apt install ir-keytable 
* check with ir-keytable -t

## lcdproc

* git clone from github
* install build-essential autoconf etc etc including libusb and dev
* sh autogen.sh
* ./configure --enable-drivers=curses,hd44780,linux_input
* todo - document lcd wiring to i2c1

## leds
