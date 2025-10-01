#define BP_marche 10
#define BP_arret 11
#define Choix_temperature A1 // potentiomètre
#define Capteur_temperature A4
#define Capteur_lumiere A3
#define Chauffage 5
#define eclairage 6

boolean etatBP_marche = false; // température de consigne
boolean etatBP_arret = false; // régulation

int fader = 0; // potentiomètre pour température
int temperature = 0; // température à régler dans la serre

float capt = 0;
float tension = 0;
float temp = 0;

void setup() {
  Serial.begin(9600);
  pinMode(BP_arret, INPUT_PULLUP);
  pinMode(BP_marche, INPUT_PULLUP);
  pinMode(Choix_temperature, INPUT_PULLUP);  
  pinMode(Capteur_temperature,INPUT_PULLUP);  
  pinMode(Capteur_lumiere, INPUT_PULLUP);  
  pinMode(Chauffage, OUTPUT);  
  pinMode(eclairage, OUTPUT);  
}

void loop() {
  do {
    etatBP_marche = digitalRead(BP_marche);
    Serial.println("Régler la température de consigne");
    fader = analogRead(Choix_temperature); // fader 10-1023
    temperature = map(fader, 10, 1023, 10, 51);
    Serial.println(temperature);
  } while(etatBP_marche == 1);
  
  do {
    etatBP_arret = digitalRead(BP_arret);
    Serial.println("La température est en mode régulation");
    
    capt = analogRead(Capteur_temperature);
    tension = capt * 5 / 1024 - 0.1;
    temp = (tension - 0.5) / 0.01;
    Serial.println(temp);
  } while(etatBP_arret == 1);
}
