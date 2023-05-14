# armbian odroid c4 bullseye  

## armbian-config  

* change kernel to 5.10 because of i2c support
* recompile dtb removing references to vrtc
* freeze

## rtc

* armbian-add pcf8563.dts  
* do some hwclock stuff
* edit /lib/udev/hwclock-set
* uninstall/disable fake-hwclock

## lcdproc

* git clone from github
* need build-essential etc etc including libusb and dev
* sh autogen.sh
* ./configure --enable-drivers=curses,hd44780,linux_input
