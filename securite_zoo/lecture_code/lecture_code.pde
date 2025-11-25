import processing.serial.*;
import processing.video.*;
import guru.ttslib.*;

PFont font12;
PFont font18;
PFont font50;

boolean tourecu;
boolean passed;

int i;
int auth;
int[] recu=new int[11]; // tableau de 11 valeurs entières

Serial port; // lecteur RFID
Serial port2; // moteur

Capture video; // Caméra vidéo
TTS tts; // Voix de synthèse
 
void setup() 
{
  auth = 0x19;
  size(960, 540);
  
  font12 = loadFont("Verdana-12.vlw");
  font18 = loadFont("Verdana-18.vlw");
  font50 = loadFont("Verdana-50.vlw");
  
  port = new Serial(this, Serial.list()[1], 9600);
  port2 = new Serial(this, Serial.list()[2], 9600);
  printArray(Serial.list());
  
  tts = new TTS();
  
  video = new Capture(this, 640 / 2, 480 / 2);
  video.start();
}
 
void draw() {
  image(video, 50, 250);
  
  if(tourecu==true) {
   tourecu=false;
   background(10, 10, 10);
   fill(0,0,255);
   textFont(font18);
   text("code", 240, 70);
  
   for (int j = 0; j < 11; j++) {
     text(recu[j], 300 + 40 * j, 70);
     text(hex(recu[j], 2),  300 + 40 * j, 90);
   }
   
   if (recu[5] == auth) {
     fill(0, 255, 0);
     circle(520, 350, 150);
     textAlign(LEFT);
     text("Autorisé", 520, 200);
     //if (passed == false) {
       tts.speak("You can enter");
       passed = true;
       port2.write('9');
     //}
   } else {
     fill(255, 0, 0);
     circle(520, 350, 150);
     textAlign(LEFT);
     text("Interdit", 520, 200);
     //if (passed == false) {
       tts.speak("You cannot enter");
       passed = true;
     //}
   }
 }
}

void serialEvent(Serial port) {
  if ((port.available() > 0) && (tourecu == false)) {
     recu[i] = port.read();        //on stocke les données dans la variable "lecture"     
     i=i+1;                      //on incremente la variable "compteur"
     println(i);
     if(i>=11){                  //si 11 donnees sont lues (longueur du message de la carte)
       i=0;
       tourecu = true;
       passed = false;
    }
  }
}
         
void captureEvent(Capture video) {
  video.read();
}
 
 
