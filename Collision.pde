void contactStarted(FContact contact) {
  if (contact.getBody1().getName().equals("PlayerFeet") || contact.getBody2().getName().equals("PlayerFeet")) { // yikes

    String name = "Ground";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      jumpCd = jumpThreshold;
      jumpsRemaining = JUMPS_REMAINING;
    }

    name = "Elevator";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
    }

    name = "Spring";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      jumpCd = jumpThreshold;
      jumpsRemaining = JUMPS_REMAINING;
      player.setVelocity(player.getVelocityX(), -800);
    }

    name = "Falling";
    if (contact.getBody1().getName().equals(name)) {
    } else if (contact.getBody2().getName().equals(name)) {
    }
  }
}

void contactPersisted(FContact contact) {
  if (contact.getBody1().getName().equals("PlayerFeet") || contact.getBody2().getName().equals("PlayerFeet")) {

    String name = "Elevator";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      player.addForce(0, -1000);
    }

    name = "Slippery";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      spdSmoothing = 0.01;
    }
  }
}

void contactEnded(FContact contact) {
  if (contact.getBody1().getName().equals("PlayerFeet") || contact.getBody2().getName().equals("PlayerFeet")) { // yikes

    String name = "Ground";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      jumpCd = jumpThreshold;
      jumpsRemaining = JUMPS_REMAINING-1;
      jumpCd = 0;
    }

    name = "Elevator";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
    }

    name = "Spring";
    if (contact.getBody1().getName().equals(name) || contact.getBody2().getName().equals(name)) {
      jumpCd = jumpThreshold;
      jumpsRemaining = JUMPS_REMAINING-1;
      jumpCd = 0;
    }
  }
}

void fallingBlockCollisions() {
  for (int i=fallingBlocks.size()-1; i>=0; i--) {
    FBox g = fallingBlocks.get(i);
    if (g.getTouching().contains(player)) {
      g.setStatic(false);
      g.setName("Ground");
    }
  }
}
