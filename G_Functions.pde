void playerUpdate() {


  playerCurrentSprites = toArrayList(Player_Idle);


  isRunning = false;


  if (player.getVelocityX()>1) {

    isFacingRight = true;
  } else if (player.getVelocityX()<-1) 
  {

    isFacingRight = false;
  }
  if (abs(player.getVelocityX())>1) {

    isRunning = true;

    playerCurrentSprites = toArrayList(Player_Run);
  }

  isJumping=false;
  if (player.getVelocityY()>1) {
    playerCurrentSprites = toArrayList(Player_Fall);
    isJumping = true;
  } else if (player.getVelocityY()<-1) {
    playerCurrentSprites = toArrayList(Player_Jump);
    isJumping = true;
  }
  if (abs(player.getVelocityY())>1) {
    isJumping=true;
  }

  // L/R

  spdTar = 0;
  if (pressed[leftKey] || pressed[altLeftKey]) {
    spdTar = -spdMag;
    isRunning = true;
  }
  if (pressed[rightKey] || pressed[altRightKey]) {
    spdTar = spdMag;
    isRunning = true;
  }

  //player.setVelocity(lerp(player.getVelocityX(), spdTar, spdSmoothing), player.getVelocityY());
  player.setVelocity(spdTar, player.getVelocityY());
  if (!isRunning)
    player.setVelocity(0, player.getVelocityY());
  spdSmoothing = SPD_SMOOTHING;

  // Jumping
  if ((pressed[upKey] || pressed[altUpKey]) && jumpsRemaining > 0 && jumpCd > jumpThreshold) {
    jumpsRemaining--;
    jumpCd = 0;
    player.setVelocity(player.getVelocityX(), -jumpMag);
  }
  jumpCd++;

  playerFeet.setPosition(player.getX(), player.getY() + gridScl/2);

  // Shooting
  if (pressed[shootKey] && !isShooting) {
    isShooting = true;
    shootTimer = 0;
    if (!isRunning)
      playerSpriteNum = 0;
    playerCurrentSprites = toArrayList(Player_IdleShoot);
  }

  if (isShooting) {
    shootTimer++;
  }

  if (isShooting && !pressed[shootKey]) {
    int lv = 0;
    if (shootTimer < 45) {
      lv = 0;
    }
    float vx = 20;
    if (!isFacingRight)
      vx *= -1;
    if (!isBigShot) {
      makeBullet(true, vx, new PVector(player.getX(), player.getY()), lv);
    } else {
      isBigShot = false;
    }
    isShooting = false;
    shootTimer = 0;
  }

  if (shootTimer >= 45) {
    float vx = 20;
    if (!isFacingRight)
      vx *= -1;
    makeBullet(true, vx, new PVector(player.getX(), player.getY()), 1);
    shootTimer = -40;
    isBigShot = true;
  }


  if (isShooting) {
    if (isJumping) {
      if (player.getVelocityY()<0)
        playerCurrentSprites = toArrayList(Player_JumpShoot);
      else playerCurrentSprites = toArrayList(Player_FallShoot);
    } else if (isRunning) {
      playerCurrentSprites = toArrayList(Player_RunShoot);
    } else {
      playerCurrentSprites = toArrayList(Player_IdleShoot);
    }
  }

  // Animations
  if ((isRunning && frameCount%5==0) || (!isRunning && frameCount%12==0))
    playerSpriteNum++;
  if (playerSpriteNum>=playerCurrentSprites.size()) {
    playerSpriteNum=0;
  }
  if (!isFacingRight)
    player.attachImage(reverse(playerCurrentSprites.get(playerSpriteNum)));
  else player.attachImage(playerCurrentSprites.get(playerSpriteNum));
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

void updateBullets() {
  for (int i=bullets.size()-1; i>=0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    if (b.life<0) {
      bullets.remove(i);
    }
  }
}
