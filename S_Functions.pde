void loadPlayerSprites() {
  // Load all sprites into one large array list for easy access
  for (int i=0; i<numPlayerSprites; i++) {
    playerSprites.add(loadImage("Assets/Sprites/" + i + ".png"));
    playerSprites.get(i).resize(int(gridScl), int(gridScl));
    if (i>=76)
      playerSprites.get(i).resize(int(gridScl/2), int(gridScl/2));
  }

  // Load spawn animation (0-15)
  Player_Spawn = new PImage[16];
  for (int i=0; i<16; i++)
    Player_Spawn[i] = playerSprites.get(i);

  // Load idle animation (16-19)
  Player_Idle = new PImage[3];
  for (int i=0; i<Player_Idle.length; i++) {
    int j = i+16;
    Player_Idle[i] = playerSprites.get(j); // Right
  }

  // Load idle-shoot animation (20- 24)
  Player_IdleShoot = new PImage[1];
  Player_IdleShoot[0] = playerSprites.get(20);


  // Load run animation (25-33)
  Player_Run = new PImage[9];
  for (int i=0; i<Player_Run.length; i++) {
    int j = i+25;
    Player_Run[i] = playerSprites.get(j);
  }

  // Load run-shoot animation (34-42)
  Player_RunShoot = new PImage[9];
  for (int i=0; i<Player_RunShoot.length; i++) {
    int j = i+34;
    Player_RunShoot[i] = playerSprites.get(j);
    Player_RunShoot[i].resize(int(gridScl + 5), int(gridScl));
  }

  // Load jump animation (43-45)
  Player_Jump = new PImage[1];
  //for (int i=0; i<Player_Jump.length; i++) {
  //  int j = i+43;
  //  Player_Jump[i] = playerSprites.get(j);
  //}
  Player_Jump[0] = playerSprites.get(44);

  // Load jump-shoot animation
  Player_JumpShoot = new PImage[1];
  Player_JumpShoot[0] = playerSprites.get(51);

  // Load fall animation (46-49)
  Player_Fall = new PImage[1];
  //for (int i=0; i<Player_Fall.length; i++) {
  //  int j = i+34;
  //  Player_Fall[i] = playerSprites.get(j);
  //}
  Player_Fall[0] = playerSprites.get(46);

  // Load fall-shoot animation
  Player_FallShoot = new PImage[1];
  Player_FallShoot[0] = playerSprites.get(53);
}
