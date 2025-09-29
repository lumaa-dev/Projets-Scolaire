void graphique() {
  stroke(#c9c9a6);
  strokeWeight(2);
  fill(#fcfcba);
  
  // graphique
  rect(240, 120, 700, 300);
  
  stroke(150);
  strokeWeight(1);
  
  textFont(font12);
  textAlign(RIGHT, CENTER);
  fill(0);
  
  // graduations température
  for (byte j = 0; j <= 10; j++) {
    line(x3, y4 - j * 30, x4, y4 - j * 30);
    text(j * 10, x3 - 7, y4 - j * 30);
  }
  
  textAlign(CENTER, CENTER);
  
  // graduations temps
  for (byte k = 0; k <= 100; k++) {
    if (k % 10 == 0) {
      stroke(150);
      text(k, x3 + k * 7, y4 + 14);
    } else {
      stroke(200);
    }
    line(x3 + k * 7, y3, x3 + k * 7, y4);
  }
  
  // segments
  
  fill(0);
  stroke(0);
  
  if (tempHistory.length > 0) {
    for (byte l = 1; l < tempHistory.length; l++) {
      float t = tempHistory[l];
      float tb = tempHistory[l - 1];
      
      // on fait des segments entre t-1 et t
      line(x3 + (l - 1) * 7, y4 - tb * 3, x3 + l * 7, y4 - t * 3);
    }
  }
}