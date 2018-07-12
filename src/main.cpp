/*
Copyright 2018 Marvin Johanning
This file is part of GmailNotifier.

GmailNotifier is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

GmailNotifier is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GmailNotifier.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(7, 8, 9, 10, 11, 12);
String incomingString = "";
int buzzer = 2;

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  pinMode(buzzer, OUTPUT);
}

void notifingBeep() {
  unsigned char i;
  for(i=0;i<50;i++) {
  digitalWrite(buzzer, HIGH);
  delay(10);
  digitalWrite(buzzer, LOW);
  delay(10);
  }
}

void got_email(String subject) {
  //Initial two beeps to alert user to incoming email
  notifingBeep();
  delay(200);
  notifingBeep();

  lcd.setCursor(0, 0);
  lcd.print("You've got mail!");
  lcd.setCursor(0, 1);
  lcd.print("Subject:");
  delay(5000);

  int str_len = subject.length() + 1;
  char char_array[str_len];
  subject.toCharArray(char_array, str_len);
  unsigned int i;

  lcd.clear();
  lcd.setCursor(16, 1);
  lcd.autoscroll();
  for (i = 0; i < sizeof(char_array) - 1; i++){
    lcd.print(char_array[i]);
    delay(500);
  }

  //Last beep to inform user of end of email
  notifingBeep();
}

void loop() {
  if(Serial.available() > 0) {
    incomingString = Serial.readString();
    got_email(incomingString);
  }
}
