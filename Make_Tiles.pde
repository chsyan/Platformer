void makePlatform() { // Temp make platform
  FPoly p = new FPoly();
  p.vertex(-100, 100);
  p.vertex(width*2, 100);
  p.vertex(width*2, 200);
  p.vertex(-100, 200);
  p.setStatic(true);
  p.setRestitution(0);
  p.setFriction(1);
  p.setFillColor(color(255, 0, 0));
  p.setName("Ground");
  p.setGrabbable(false);
  world.add(p);
}

void makeElevator() { // Temp make elevator
  FBox b = new FBox(gridScl*3, gridScl*10);
  b.setStatic(true);
  b.setSensor(true);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(200, 0);
  b.setFillColor(color(0, 255, 0));
  b.setName("Elevator");
  b.setGrabbable(false);
  world.add(b);
}


void makeSpring() { // Temp make spring
  FBox b = new FBox(gridScl*3, gridScl);
  b.setStatic(true);
  b.setSensor(true);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(400, 60);
  b.setFillColor(color(0, 0, 255));
  b.setName("Spring");
  b.setGrabbable(false);
  world.add(b);
}

void makeSlippery() { // Temp make slippery
  FBox b = new FBox(gridScl*20, gridScl);
  b.setStatic(true);
  b.setSensor(true);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(700, 60);
  b.setFillColor(color(255, 0, 255));
  b.setName("Slippery");
  b.setGrabbable(false);
  world.add(b);
}

void makeCrate() { // Temp make crate/box
  FBox b = new FBox(gridScl*3, gridScl*3);
  b.setStatic(false);
  b.setSensor(false);
  b.setRestitution(0);
  b.setFriction(0.01);
  b.setPosition(100, 0);
  b.setFillColor(color(0, 255, 255));
  b.setName("Ground");
  b.setGrabbable(false);
  world.add(b);
}

void makeFalling() { // Temp make falling
  FBox b = new FBox(gridScl*3, gridScl*3);
  b.setStatic(true);
  b.setSensor(false);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(1000, 0);
  b.setFillColor(color(255, 0, 255));
  b.setName("Falling");
  b.setGrabbable(false);
  fallingBlocks.add(b);
  world.add(b);
}

void makeSign() { // Temp make sign
  Sign s = new Sign("USE WASD OR ARROW KEYS TO MOVE");
  s.setStatic(true);
  s.setSensor(true);
  s.setRestitution(0);
  s.setFriction(0.01);
  s.setPosition(50, 38);
  s.setFillColor(color(150, 10, 255));
  s.setName("Sign");
  s.setGrabbable(false);
  signs.add(s);
  world.add(s);
}

void makeBullet(boolean good, float vx, PVector position, int lv) {
  Bullet b = new Bullet(good, vx, position.copy(), lv);
  b.setStatic(true);
  b.setSensor(true);
  b.setBullet(true);
  b.setSize(gridScl/2);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(position.copy().x, position.copy().y);
  if (lv==0)
    b.attachImage(playerSprites.get(76));
  else if (lv == 1)
    b.attachImage(playerSprites.get(79));
  b.setName("Bullet");
  b.setGrabbable(false);
  bullets.add(b);
  world.add(b);
}
