class TankAI extends Tank {
  // data
  int decidedMove;
  int wait = 1;
  int speed;
  int levelAI;
  boolean shoot;
  boolean unableToMove;


  //constuctors

  TankAI(float _tankX, float _tankY, int _state, int _speed, SoundEffects theAIshoot) {
    super(_tankX, _tankY, _state, theAIshoot);
    shoot = false;
    speed = _speed;
    sounds = theAIshoot;
    levelAI = round(random(1, 4));
  }



  //behaviors
  void display() {
    super.display();
  }


  void move(float x, float y) {
    if (hp > 0 ) {
      if (levelAI == 1) {
        chase(x, y);
      } else if (wait == speed) {
        decidedMove = round(random(1, 5));
        wait = 0;
        action();
      } else {
        wait += 1;
      }
    }
  }

  void action() {
    if (decidedMove == 1) {
      state = 1;
      if (canUp) {
        tankY = tankY - tankSize;
      }
    } else if (decidedMove == 2) {
      state = 2;
      if (canDown) {
        tankY = tankY + tankSize;
      }
    } else if (decidedMove == 3) {
      state = 3;
      if (canLeft) {
        tankX = tankX - tankSize;
      }
    } else if (decidedMove == 4) {
      state = 4;
      if (canRight) {
        tankX = tankX + tankSize;
      }
    } else if (decidedMove == 5) {
      shoot = true;
      shoot();
    }
    tankX = constrain(tankX, 0, width-tankSize);
    tankY = constrain(tankY, 0, height-tankSize);
    resetMove();
  }

  void chase(float x, float y) {
    if (hp > 0 ) {
      if (wait == speed) {
        wait = 0;
        chasePlayer(x, y);
      } else {
        wait += 1;
      }
    }
  }

  void chasePlayer(float x, float y) {

    shootPlayer(x, y);

    if (unableToMove) {
      move();
    }
    if (tankY > y) {
      state = 1;
      if (canUp) {
        tankY = tankY - tankSize;
      }
    } else if (tankY > y) {
      state = 2;
      if (canDown) {
        tankY = tankY + tankSize;
      }
    } else if (tankX > x) {
      state = 3;
      if (canLeft) {
        tankX = tankX - tankSize;
      }
    } else if (tankX < x) {
      state = 4;
      if (canRight) {
        tankX = tankX + tankSize;
      }
    } 
    tankX = constrain(tankX, 0, width-tankSize);
    tankY = constrain(tankY, 0, height-tankSize);
    resetMove();
  }

  void shootPlayer(float x, float y) {
    if (x == tankX && y < tankY) {
      state = 1;
    } else if (x == tankX && y > tankY) {
      state = 2;
    } else if (x < tankX && y == tankY) {
      state = 3;
    } else if (x > tankX && y == tankY) {
      state = 4;
    }
    shoot = true;
    shoot();
  }

  void moveBullets(Tank player) {
    for (int i=theBullets.size()-1; i >=0; i-- ) {
      Bullet thisBullet = theBullets.get(i);
      thisBullet.move();
      thisBullet.display();
      thisBullet.isCollidingWithTank(player);
      thisBullet.isCollidingWithWall(map, realMap);
      thisBullet.out();

      if (thisBullet.hit == true) {
        theBullets.remove(i);
      }
    }
  }

  void shoot() {
    if (hp > 0 ) {
      if (shoot ==true) {
        theBullets.add(new Bullet(state, tankX, tankY));
        sounds.theAIshoot();
        shoot = false;
      }
    }
  }

  void showHPbar() {
    super.showHPbar();
  }

  void resetMove() {
    super.resetMove() ;
    unableToMove = true;
  }

  void collidingWithPlayer(Tank player) {
    super.collidingWithPlayer(player);
  }

  void collidingWithAI(ArrayList<TankAI> theAI) {
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      if (this != thisAI) {
        if (rectRectIntersect(this.tankX, this.tankY, this.tankX+40, this.tankY+40, thisAI.tankX, thisAI.tankY, thisAI.tankX+40, thisAI.tankY+40) == true) {
          if (this.tankX==thisAI.tankX-40 && this.tankY-40<thisAI.tankY  && this.tankY+40>thisAI.tankY) {
            this.canRight = false;
            unableToMove = true;
          }
          if (this.tankX==thisAI.tankX+40 && this.tankY-40<thisAI.tankY  && this.tankY+40>thisAI.tankY) {
            this.canLeft = false;
            unableToMove = true;
          }
          if (this.tankY==thisAI.tankY-40 && this.tankX-40<thisAI.tankX  && this.tankX+40>thisAI.tankX) {
            this.canDown = false;
            unableToMove = true;
          }
          if (this.tankY==thisAI.tankY+40 && this.tankX-40<thisAI.tankX  && this.tankX+40>thisAI.tankX) {
            this.canUp = false;
            unableToMove = true;
          }
        }
      }
    }
  }

  void collidingWithWall(char[][] map, Block[][] realMap) {
    super.collidingWithWall(map, realMap);
    unableToMove = true;
  }
}