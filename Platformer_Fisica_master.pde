import fisica.*;


// World
FWorld world;
float gridScl = 15; // Scale of grid

// Player
FCircle player; // Main body
FCircle playerFeet; // Feet for jump collisions
float spdMag = 500; // Magnitude of L/R speed/force modifier
float spdTar; // Target speed lerp
float spdSmoothing = 0.1; // Smooth speed shifts lerp
final float SPD_SMOOTHING = 0.1;
float jumpMag = 500; // Magnitude of jump speed
final float JUMPS_REMAINING = 2; // Jumps allowed (1 for single jump, 2 for double jump)
float jumpsRemaining = JUMPS_REMAINING; // Number of jumps remaining (allow for double jumping)
float jumpCd; // Cooldown for jump (can't double jump instantaneously)
float jumpThreshold = 15; // jumpCd must exceed jumpThreshold in order for player to be able to jump

// Falling blocks
ArrayList<FBox> fallingBlocks = new ArrayList<FBox>();

// Signs
ArrayList<Sign> signs = new ArrayList<Sign>();

// Game states
int state;
final int MAINMENU = 0;
final int PLAY = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int WIN = 4;

// Input
boolean[] pressed = new boolean[256];
char upKey, leftKey, downKey, rightKey, shootKey, 
  altUpKey, altLeftKey, altDownKey, altRightKey;

// Camera
PVector camPos;
float camSmoothing;

void setup() {
  size(800, 600, FX2D);

  // Initialize world
  Fisica.init(this);
  world = new FWorld(-10000, -10000, 10000, 10000);
  world.setGravity(0, 1000);

  // Starting game state
  state = PLAY;

  // Temp make platform
  FPoly p = new FPoly();
  p.vertex(-100, height*.1);
  p.vertex(width*2, height*0.1);
  p.vertex(width*2, height*0.1+100);
  p.vertex(-100, height*.1+100);
  p.setStatic(true);
  p.setRestitution(0);
  p.setFriction(1);
  p.setFillColor(color(255, 0, 0));
  p.setName("Ground");
  p.setGrabbable(false);
  world.add(p);


  // Temp make elevator
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

  // Temp make spring
  b = new FBox(gridScl*3, gridScl);
  b.setStatic(true);
  b.setSensor(true);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(400, 60);
  b.setFillColor(color(0, 0, 255));
  b.setName("Spring");
  b.setGrabbable(false);
  world.add(b);

  // Temp make slippery
  b = new FBox(gridScl*20, gridScl);
  b.setStatic(true);
  b.setSensor(true);
  b.setRestitution(0);
  b.setFriction(0);
  b.setPosition(700, 60);
  b.setFillColor(color(255, 0, 255));
  b.setName("Slippery");
  b.setGrabbable(false);
  world.add(b);

  // Temp make crate/box
  b = new FBox(gridScl*3, gridScl*3);
  b.setStatic(false);
  b.setSensor(false);
  b.setRestitution(0);
  b.setFriction(0.01);
  b.setPosition(100, 0);
  b.setFillColor(color(0, 255, 255));
  b.setName("Ground");
  b.setGrabbable(false);
  world.add(b);

  // Temp make falling
  b = new FBox(gridScl*3, gridScl*3);
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

  // Temp make sign
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

  // Add player
  player = new FCircle(gridScl); // Main bpdy
  player.setFriction(0);
  player.setDensity(1);
  player.setGrabbable(false);
  player.setName("Player");
  world.add(player);

  playerFeet = new FCircle(gridScl/2); // Feet
  playerFeet.setSensor(true);
  playerFeet.setGrabbable(false);
  playerFeet.setDrawable(false);
  playerFeet.setName("PlayerFeet");
  world.add(playerFeet);

  // Input key values
  upKey = 'W';
  leftKey = 'A';
  downKey = 'S';
  rightKey = 'D';
  shootKey = ' ';

  altUpKey = UP; // Alt keycodes
  altLeftKey = LEFT;
  altRightKey = RIGHT;
  altDownKey = DOWN;

  // Camera values
  camPos = new PVector(player.getX(), player.getY());
  camSmoothing = 0.2;
}

void draw() {
  if (state == MAINMENU) {
    mainMenu();
  } else if (state == PLAY) {
    play();
  } else if (state == PAUSE) {
    pause();
  } else if (state == GAMEOVER) {
    gameOver();
  } else if (state == WIN) {
    win();
  } else {
    println("Gamestate OOB");
  }
}

// Input
void keyPressed() {
  if (key==CODED)
    pressed[keyCode] = true;
  else pressed[key] = true;
}

void keyReleased() {
  if (key==CODED)
    pressed[keyCode] = false;
  else pressed[key] = false;
} 
