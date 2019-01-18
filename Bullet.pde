class Bullet extends FCircle {
  boolean good;
  float vx;
  int lv;
  int spriteNum;
  ArrayList<PImage> sprites = new ArrayList<PImage>();
  float life;
  Bullet(boolean good, float vx, PVector position, int lv) {
    super(gridScl/2);
    this.good = good;
    this.vx = vx;
    this.lv = lv;
    spriteNum = 0;
    setPosition(position.copy().x, position.copy().y);

    life = 500;

    if (lv==0) {
      sprites.add(playerSprites.get(76));
    }

    if (lv==1) {
      sprites.add(playerSprites.get(79));
      sprites.add(playerSprites.get(80));
      sprites.add(playerSprites.get(81));
    }
  }

  void update() {
    life --;
    setPosition(getX() + vx, getY());

    if (frameCount%3==0) {
      spriteNum++;
    }
    if (spriteNum >= sprites.size()) {
      spriteNum = 0;
    }
    attachImage(sprites.get(spriteNum));
  }
}
