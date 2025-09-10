#include <FastLED.h>
#include <Servo.h>

int sensorPin = A5; // micro

Servo servoRoll; // servo moteur

#define LED_TYPE WS2812B
#define NUM_LEDS 64
#define LED_PIN 9
#define SPEED_MS 50

constexpr auto COLOR_ORDER = GRB;

CRGB leds[NUM_LEDS];
CRGB prevSelected;

void setup() {
  LEDS.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  FastLED.setBrightness(128);
  set_max_power_in_volts_and_milliamps(5, 500);
  FastLED.show();
  
  Serial.begin(9600);
}

void loop() {
  int roll = 0;
  int sensorValue = analogRead(sensorPin);

  CRGB green = CRGB(0, 255, 0);
  CRGB orange = CRGB(255, 100, 0);
  CRGB red = CRGB(255, 0, 0);

  CRGB selected;

  if (sensorValue >= 200 && sensorValue < 250) {
    for(auto i = 0; i < 16; i++ ) {
      leds[i] = orange;
    }
  } else if (sensorValue >= 400 & sensorValue < 450){
    for(auto i = 0; i < 16; i++ ) {
      leds[i] = red;
    }
  } else if (sensorValue < 200) {
    for(auto i = 0; i < 16; i++ ) {
      leds[i] = green;
    }
  }

  if (sensorValue >= 250 & sensorValue < 450) {
    selected = orange;
    roll = 45;
  } else if (sensorValue >= 450) {
    selected = red;
    roll = 0;
  } else {
    selected = green;
    roll = 90;
  }

  show_at_max_brightness_for_power();

  if (prevSelected != selected) {
    Serial.println("new color");
    prevSelected = selected;
    
    for(auto i = 0; i < NUM_LEDS; i++ ) {
      leds[i] = selected;
    }

    delay(500);
    
    servoRoll.attach(11);
    servoRoll.write(roll);
    delay(500);
    
    if (selected == green) {
      servoRoll.detach();  
    }
  }

  delay(500);
  Serial.println(sensorValue);
}
