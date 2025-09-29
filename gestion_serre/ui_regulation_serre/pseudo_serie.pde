void donnees_serie() {
  if (millis() - duree >= 1000) {
    println("donnees");
    
    temp = random(18.9,34.6);
    
    for(int i = 0; i < 100; i++) { 
       tempHistory[i] = tempHistory[i +1];
    }
    
    tempHistory[100] = temp;

    NouvelleMesure = true;
    duree = millis();
  }
}
