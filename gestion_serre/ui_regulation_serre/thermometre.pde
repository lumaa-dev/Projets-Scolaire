void thermometre(float temperature) {
  noStroke();
  fill(192, 0, 0);
  rect(97, y1, 20, 25); // base du thermo (cercle vers 0°C)
  
  rect(97, y1 - 3 * temperature, 20, 3 * temperature); // température dans le thermomètre
  
  stroke(0);
  strokeWeight(1);
  
  fill(70);
  textFont(font50);
  textAlign(LEFT, BOTTOM);
  text(temp, 240, 70);
  
  // graduations thermomètre
  textFont(font12);
  textAlign(RIGHT, CENTER);
  for (byte i = 0; i <= 100; i++) {
    if (i % 10 == 0) {
      text(i, x1 - 7, y2 - i * 3);
      line(x1 - 5, y1 - i * 3, x2, y2 - i * 3);
    } else {
      line(x1, y1 - i * 3, x2, y2 - i * 3);
    }
  }
}
