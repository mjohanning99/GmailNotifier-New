# Gmail Notifier
__DISCLAIMER:__ I cannot made responsible for any damage caused to your Arduino, yourself or any other of your possessions. I have tested this program myself, however, I cannot guarantee that it will work with you and I also cannot guarantee that it will not break. __Use at your own risk!__

## What is this?
Gmail Notifier is a simple little program that you can use with your Arduino, an LCD and an active buzzer that will notify you of a new email and will display the email's subject on the LCD connected to the Arduino.

## Prerequisites and Installation
### Software
__NOTE__: The only supported operating systems are those based on Linux and trying to run it on a different operating system will almost definitely _not_ work.

#### Ruby
Firstly, you need to install Ruby. Ruby is an easy to use programming language that might already be installed on your computer. To check whether it is installed, type `ruby -v` into your Terminal upon which you should get information about the version of your current Ruby installation.
<br>
If, however, you get an error, please install Ruby — preferably the version that I am using myself, `2.5.1`. For further information on how to install Ruby on your operating system, please refer to the official website: https://www.ruby-lang.org/en/documentation/installation/

#### Ruby gems
Secondly, running this program requires you to install a few so-called _gems_. These are basically the extensions of Ruby and add a lot of functionality. In this case, the gems that you need to install are the following:
* serialport (for sending data to the serial port in order for the Arduino to read it)
* gmail (for receiving email from your Gmail account)
* colorize (for displaying coloured text in the terminal — used only for error messages)
* socket (for testing your internet connection)

Installing gems is fairly easy and straightforward. Simply type `(sudo) gem install gem_name_here` into your terminal and the gem should start installing. Please note that some Ruby installations require you to be root to install gems. If that is the case, please add the `sudo` before the command.

#### Uploading and IDE
Thirdly, you need an IDE that is capable of uploading code to your Arduino. The most commonly used one being the official Arduino IDE that can be downloaded [from their website](https://www.arduino.cc/en/Main/Software)

#### Arduino Library
Fourthly and lastly, you also need to download the LiquidCrystal library from [here](https://github.com/arduino-libraries/LiquidCrystal). The main purpose of this library is to be able to easily control LCDs.
For further information on how to install libraries for your Arduino, please visit refer to the [official guide](https://www.arduino.cc/en/Guide/Libraries).

### Hardware
As mentioned previously, you also require some hardware to be able to run this program properly.

#### Arduino
The most important hardware component you will be needing is obviously an Arduino. I am using an Elegoo Uno, however, most other Arduinos should work fine as well

#### LCD
Another important component is obviously the LCD. In order for this program to function properly, please use an LCD with 16 columns and 2 rows. These generally have 14 or 16 pins — The latter is back-lit, the former is not. I am using the `LCD 1602 Module`.
Please connect the pins as follows:

|LCD|Arduino|
|------|-------|
VSS    |GND
VDD    |5V
V0     |Potentiometer
RS     |Pin 7
RW     |GND
E      |Pin 8
D4 - D7|Pin 9 - 12

If you have a back-lit screen, you might also have to connect two more pins to GND and 5V. Your LCDs pins might be named differently. In that case, please refer to your LCDs data sheet.

#### Active buzzer
Another component is the active buzzer. It will make a sound whenever you receive an emails to notify you. The one I am using is the `TMB12A05`. Connected the negative side of the buzzer to GND and the postive side (which is usually marked by having a longer lead) to your Arduino's Pin 2.
