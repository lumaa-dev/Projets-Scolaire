char val;

void setup() {
  Serial.begin(9600);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
}

void loop() {
  while (Serial.available() > 0) {
    val = Serial.read();
    Serial.println(val);
  }

  if (val == '9') {
    digitalWrite(5, HIGH);
    delay(3000);
    digitalWrite(5, LOW);
    delay(5000);
    digitalWrite(4, HIGH);
    delay(3000);
    digitalWrite(4, LOW);
    val = 0;
  } else {
    digitalWrite(4, LOW);
    digitalWrite(5, LOW);
  }
}
