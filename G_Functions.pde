void playerUpdate() {

  // L/R
  spdTar = 0;
  if (pressed[leftKey] || pressed[altLeftKey]) {
    spdTar = -spdMag;
  }
  if (pressed[rightKey] || pressed[altRightKey]) {
    spdTar = spdMag;
  }
  player.setVelocity(lerp(player.getVelocityX(), spdTar, spdSmoothing), player.getVelocityY());
  spdSmoothing = SPD_SMOOTHING;

  // Jumping
  if ((pressed[upKey] || pressed[altUpKey]) && jumpsRemaining > 0 && jumpCd > jumpThreshold) {
    jumpsRemaining--;
    jumpCd = 0;
    player.setVelocity(player.getVelocityX(), -jumpMag);
  }
  jumpCd++;

  playerFeet.setPosition(player.getX(), player.getY() + gridScl/2);
}

void cameraUpdate() {
  camPos.lerp(new PVector(-player.getX() + width/2, -player.getY() + height/2), camSmoothing); // lerp camPos to playerPos
}

void drawGridLines() {
  stroke(0);
  for (int x=-100; x<width*2+1; x+=50)
    line(x, -100, x, 300);
  for (int y=-100; y<301; y+=50)
    line(-100, y, width*2, y);
}

void updateSigns() {
  for (Sign s : signs) {
    s.update();
  }
}
