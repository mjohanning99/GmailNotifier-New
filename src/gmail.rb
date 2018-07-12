#!/bin/env ruby

#Check if operating system being used it Linux-based
unless /linux/ =~ RUBY_PLATFORM then
  puts "ERROR: Only Linux-based operating systems are currently supported"
  exit
end

#Requiring all the different gems
gems = ['serialport', 'gmail', 'fileutils', 'colorize', 'socket', 'gmail_login_information.rb']
gems.each do |gem|
  unless gem == 'gmail_login_information.rb' then require gem else require_relative gem end
end

#Checking internet connection to google.com (pinging it)
begin
  puts "Checking internet connection ..."
  TCPSocket.new 'google.com', 443
rescue SocketError
  puts "ERROR: ".colorize(:red) + "The program was unable to find an active internet connection. " \
                                  "Please check your internet connection and try again"
  exit
else
  puts "SUCCESS: ".colorize(:green) + "Active internet connection found"
end

#Create string to hold the Arduino's serial connection
@serial_connection = String.new

#Start the bash file, read the file it creates and find out what port the Arduino is connected to
system("bash #{File.dirname(__FILE__)}/detect_serial.sh > #{File.dirname(__FILE__)}/serial")
File.open("#{File.dirname(__FILE__)}/serial").each_line do |line|
  @serial_connection = line.slice(0..(line.index(' '))).gsub(' ', '') if line.include?("Arduino")
end

#Gmail username and password
gmail = Gmail.connect($gmail_username, $gmail_password)

#count the number of unread messages
begin
  puts "Checking connection to Gmail ..."
  prev_unread = gmail.inbox.count(:unread)
rescue Net::IMAP::BadResponseError
  puts "ERROR: ".colorize(:red) + "Connecting to your Gmail account has failed (NET::IMAP::BadResponseError)\n" \
                                  "Please ensure that you have entered your correct username and password (refer to README for further details)"
  exit
else
  puts "SUCCESS: ".colorize(:green) + "Sucessfully connected to Gmail with provided login details"
end

#Serial port of the Arduino
puts "Detecting Arduino..."
unless @serial_connection.size > 0
  puts "ERROR: ".colorize(:red) + "No Arduino has been found connected to your computer\n" \
                                  "Please check if your Arduino is working and has been properly connected"
  exit
else
  puts "SUCCESS: ".colorize(:green) + "Arduino has been found"
  puts "Arduino is connected to: #{@serial_connection}"
  port_file = @serial_connection
end

#this must be same as the baud rate set on the Arduino
#with Serial.begin
baud_rate = 9600

data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

#create a SerialPort object using each of the bits of information
port = SerialPort.new(port_file, baud_rate, data_bits, stop_bits, parity)

wait_time = 4

puts "Checking emails ..."

#for an infinite amount of time
loop do
  #get the number of unread messages in the inbox
  unread = gmail.inbox.count(:unread)

  #check if the number of unread messages has increased
  if unread > prev_unread
    #Write the subject of the last unread email to the serial port
    port.write gmail.inbox.find(:unread).last.subject.upcase

    #For debugging purposes
    puts "Received email: \n" + gmail.inbox.find(:unread).last.subject

    puts "Checking emails ..."
  end

  #reset the number of unread emails
  prev_unread = unread

  #wait before we make another request to the Gmail servers
  sleep wait_time
end
