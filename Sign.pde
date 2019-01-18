class Sign extends FBox {
  String message;
  int timer;
  Sign(String message) {
    super(gridScl, gridScl);
    this.message = message;
    timer = 0;
  }

  void update() {
    fill(255, 255, 255, timer);
    textAlign(CENTER, CENTER);
    if (getTouching().contains(player)) 
      timer = 255;
    if (timer>0) 
      text(message, getX(), getY()-gridScl*2);
    timer-=10;
  }
}
