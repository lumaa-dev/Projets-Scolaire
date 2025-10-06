void donnees_serie(float temp) {
  if (millis() - duree >= 1000) {
    println("donnees");
    
    for(int i = 0; i < 100; i++) { 
       tempHistory[i] = tempHistory[i +1];
    }
    
    tempHistory[100] = temp;

    NouvelleMesure = true;
    duree = millis();
  }
}