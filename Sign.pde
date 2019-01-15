class Sign extends FBox {
  String message;
  int timer;
  Sign(String message) {
    super(gridScl, gridScl);
    this.message = message;
    timer = 0;
  }

  void update() {
    println(timer);
    if (getTouching().contains(player)) {
      this.timer = 255;
    }
    if (this.timer>0) {
      fill(255, 255, 255, this.timer);
      textAlign(CENTER, CENTER);
      text(message, this.getX(), this.getY()-gridScl*2);
    }
    this.timer-=10;
  }
}
