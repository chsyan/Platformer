import fisica.*;


// World
FWorld world;
float gridScl = 32; // Scale of grid

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
boolean isFacingRight = true, isRunning = false, isJumping = false, isShooting; // tests of player state
float shootTimer; // Determine whether to shoot small, medium, or large bullets
boolean isBigShot; // is the bullet fired a big boi or no?

// Player animations
int numPlayerSprites = 82;
int playerSpriteNum=16;
ArrayList<PImage> playerSprites = new ArrayList<PImage>(numPlayerSprites);
ArrayList<PImage> playerCurrentSprites = new ArrayList<PImage>();
PImage[] Player_Spawn, Player_Idle, Player_IdleShoot, Player_Run, Player_RunShoot, Player_Jump, Player_Fall, 
  Player_JumpShoot, Player_FallShoot;

// Falling blocks
ArrayList<FBox> fallingBlocks = new ArrayList<FBox>();

// Bullets
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

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
  world = new FWorld(-500, -500, 10000, 10000);
  world.setGravity(0, 1000);

  // Load player sprites
  loadPlayerSprites();
  playerCurrentSprites = toArrayList(Player_Idle);

  // Starting game state
  state = PLAY;

  makePlatform();
  //makeElevator();
  //makeSpring();
  //makeSlippery();
  //makeCrate();
  //makeFalling();
  //makeSign();

  // Add player
  player = new FCircle(gridScl); // Main bpdy
  player.setFriction(0);
  player.setDensity(1);
  player.attachImage(playerSprites.get(16));
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
