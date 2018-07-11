# Gmail Notifier
__DISCLAIMER:__ I cannot made responsible for any damage caused to your Arduino, yourself or any other of your possessions. I have tested this program myself, however, I cannot guarantee that it will work with you and I also cannot guarantee that it will not break. __Use at your own risk!__

## What is this?
Gmail Notifier is a simple little program that you can use with your Arduino, an LCD and an active buzzer that will notify you of a new email and will display the email's subject on the LCD connected to the Arduino.

## Prerequisites and Installation
The very first thing you should do is downloading this repository which you can simply do by clicking the _Download_ button at the top of this repository's page. Save and extract it into a folder of your liking.

### Software
In this section I will be talking about what software components you will be needing and how to install them properly.
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

#### IDE
Thirdly, you need an IDE that is capable of uploading code to your Arduino. The most commonly used one being the official Arduino IDE that can be downloaded [from their website](https://www.arduino.cc/en/Main/Software). 

#### Arduino Library
Fourthly and lastly, you also need to download the LiquidCrystal library from [here](https://github.com/arduino-libraries/LiquidCrystal). The main purpose of this library is to be able to easily control LCDs.
For further information on how to install libraries for your Arduino, please visit refer to the [official guide](https://www.arduino.cc/en/Guide/Libraries).

#### Uploading to the Arduino
After having downloaded and installed the library and the IDE, first you need to connect the Arduino to your computer. After having done so, please open the Arduino IDE. Afterwards, click the _Tools_ tab. A small window should open in which there are two options you need to be concerned about: _Board_ and _Port_. In the _Board_ section, please select the board that you are using and in the _Port_ section you need to select the port that the Arduino is connected to (usually it tell you which one that is).
Thereafter you need to upload the sketch (the program) located in `src/main.cpp` to your Arduino. To do so, press `Ctrl-O` and find the folder you extracted the repository into and open it. Once the sketch can be seen in the IDE's window, press `Ctrl-U` to upload it to your Arduino.


-----

### Hardware
As mentioned previously, you also require some hardware to be able to run this program properly. In the following section I will explain what hardware you need, what specific hardware I use and how to connect said hardware correctly to your Arduino.

#### Arduino
The most important hardware component you will be needing is obviously an Arduino. I believe that most Arduinos should work with this program, but I cannot be entirely sure. Therefore, the only _officially_ supported Arduino for this is the Arduino Uno. If you tried this program on any other Arduino and it worked, please contact me and I will add it to the list of supported devices.

#### LCD
Another important component is obviously the LCD. In order for this program to function properly, please use an LCD with 16 columns and 2 rows. Using an LCD with fewer or more columns and rows will most likely result in weird glitches or it might not work at all.
These generally have 14 or 16 pins — The latter is back-lit, the former is not. I am using the `LCD 1602 Module`.
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

## Setting up the software to work with your Gmail account
Having done everything mentioned in the previous sections, it is now time to set up the program to work with your Gmail account. To do so, open the `src/gmail.rb` file and find the line that you can plug your gmail username and password into

