# armbian odroid c4 bullseye  

## armbian-config  

* change kernel to 5.10 because of i2c support
* recompile dtb removing references to vrtc
* freeze

## rtc

* armbian-add-overlay pcf8563.dts  
* **todo** - hwclock timedatectl details
* edit /lib/udev/hwclock-set comment first if
* uninstall/disable fake-hwclock


## lcdproc

* git clone from github
* install build-essential autoconf etc etc including libusb and dev
* sh autogen.sh
* ./configure --enable-drivers=curses,hd44780,linux_input
* **todo** - document lcd wiring to i2c1

## infrared remote

* apt install ir-keytable 
* check with ir-keytable -t
* update LCDd.conf

## leds

### for testing without sudo  
* sudo groupadd leds
* sudo usermod -aG leds peter
* sudo cp 60-leds.rules /etc/udev/rules.d/

### definition for traffic light on GPIOX_14,_15,_6  

* sudo armbian-add-overlay gpio-leds.dts

### add module for timer trigger (blinking)

* sudo modprobe ledtrig-timer
* **todo** load automatically?

 



