import processing.serial.*;

Serial ArduinoSeriePort;

float[] tempHistory = new float[101];

float temp = 50;
int duree = 0;
boolean NouvelleMesure = false;

// coordonnées thermo
int x1 = 75;
int y1 = 375;
int x2 = 80;
int y2 = 375;

// coordonnées graph
int x3 = 240;
int y3 = 120;
int x4 = x3 + 700;
int y4 = y3 + 300;

PImage temp_serre;

PFont font12;
PFont font18;
PFont font50;

void setup() {
  size(1000, 500);
  
  temp_serre = loadImage("InterfaceTh1000x500.gif");
  
  font12 = loadFont("Verdana-12.vlw");
  font18 = loadFont("Verdana-18.vlw");
  font50 = loadFont("Verdana-50.vlw");
  
  printArray(Serial.list());
  if (Serial.list().length > 1) {
    String NomPort = Serial.list()[1];
    println("Connexion avec " + NomPort);
    ArduinoSeriePort = new Serial(this, NomPort, 9600);
  } else {
    println("Utilisation de données d'exemples");
  }
}

void draw() {
  if (NouvelleMesure == true) {
    NouvelleMesure = false;
    background(temp_serre);
    
    thermometre(temp);
    graphique();
  }
  
  if (Serial.list().length <= 1) {
    donnees_serie();
  }
}

void serialEvent(Serial ArduinoSeriePort) {
  String SerialDataStr = ArduinoSeriePort.readStringUntil('\n');
  if (SerialDataStr != null) {
    temp = float(SerialDataStr);
    NouvelleMesure = true;
  }
}
