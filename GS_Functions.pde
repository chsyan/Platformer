void mainMenu() {
}

void play() {
  background(80);

  playerUpdate();
  cameraUpdate();
  fallingBlockCollisions();

  pushMatrix();
  translate(camPos.x, camPos.y);
  drawGridLines(); //Temp



  world.step();
  world.draw();

  updateSigns(); // Must be in translate, after world.draw() to show text over objects

  popMatrix();
}

void pause() {
}

void gameOver() {
}

void win() {
}
