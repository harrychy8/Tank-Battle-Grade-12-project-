class Tank {

  // data
  PImage tankUp, tankDown, tankLeft, tankRight;

  float tankX, tankY;
  float tankSize;
  int player;
  int state;
  float fullHp;
  int hp;

  ArrayList<Bullet> theBullets = new ArrayList <Bullet>();
  boolean canUp, canDown, canLeft, canRight;

  char[] dummyChar = new char[]{'!', '@'};

  //SoundEffects shootSound;


  // constructors
  Tank(int _player, PApplet p) {
    player = _player;
    tankUp = loadImage("images/tankup.png");
    tankUp.resize(40, 40);
    tankDown = loadImage("images/tankdown.png");
    tankDown.resize(40, 40);
    tankLeft = loadImage("images/tankleft.png");
    tankLeft.resize(40, 40);
    tankRight = loadImage("images/tankright.png");
    tankRight.resize(40, 40);
    tankSize = 40;
    tankX = random(0, width-40);
    tankY = random(0, height-40);
    state = 1;
    hp = 3;
    fullHp = hp;
    canUp = true; 
    canDown = true;
    canLeft = true; 
    canRight = true;

    sounds = new SoundEffects(p);
  }

  Tank(int _player, float _tankX, float _tankY, int _state, PApplet p) {
    player = _player;
    tankX = _tankX;
    tankY = _tankY;
    state = _state;
    tankUp = loadImage("images/tankup.png");
    tankUp.resize(40, 40);
    tankDown = loadImage("images/tankdown.png");
    tankDown.resize(40, 40);
    tankLeft = loadImage("images/tankleft.png");
    tankLeft.resize(40, 40);
    tankRight = loadImage("images/tankright.png");
    tankRight.resize(40, 40);
    tankSize = 40;
    hp = 3;
    fullHp = hp;
    canUp = true; 
    canDown = true;
    canLeft = true; 
    canRight = true;

    sounds = new SoundEffects(p);
  }

  // THIS CONSTRUCTOR IS FOR THE AI
  Tank( float _tankX, float _tankY, int _state, SoundEffects theAIshoot) {
    tankX = _tankX;
    tankY = _tankY;
    state = _state;
    tankUp = loadImage("images/tankAIup.png");
    tankUp.resize(40, 40);
    tankDown = loadImage("images/tankAIdown.png");
    tankDown.resize(40, 40);
    tankLeft = loadImage("images/tankAIleft.png");
    tankLeft.resize(40, 40);
    tankRight = loadImage("images/tankAIright.png");
    tankRight.resize(40, 40);
    tankSize = 40;
    hp = 3;
    fullHp = hp;
    canUp = true; 
    canDown = true;
    canLeft = true; 
    canRight = true;
  }

  // behaviors
  boolean checkKey(char[] a, int b) {
    if (key == a[0] || key == a[1] || keyCode == b) {
      return true;
    }
    return false;
  }

  void move() {
    if (hp > 0) {
      if (player ==1) {
        char[] up = new char[]{'w', 'W'};
        char[] down = new char[]{'s', 'S'};
        char[] left = new char[]{'a', 'A'};
        char[] right = new char[]{'d', 'D'};
        
        // michael beta test my code, and he wanted the tank to turn beofre the move, so i changed it
        if (checkKey(up, -1)) {
          if (state == 1) {
            if (canUp) {
              tankY = tankY - tankSize;
            }
          } else {
            state = 1;
          }
        } else if (checkKey(down, -1)) {
          if (state == 2) {
            if (canDown) {
              tankY = tankY + tankSize;
            }
          } else {
            state = 2;
          }
        } else if (checkKey(left, -1)) {
          if (state == 3) {
            if (canLeft) {
              tankX = tankX - tankSize;
            }
          } else {
            state = 3;
          }
        } else if (checkKey(right, -1)) {
          if (state == 4) {
            if (canRight) {
              tankX = tankX + tankSize;
            }
          } else {
            state = 4;
          }
        }

        tankX = constrain(tankX, 0, width-tankSize);
        tankY = constrain(tankY, 0, height-tankSize);
      } else if (player ==2) {
        if (checkKey(dummyChar, UP)) {
          if (state == 1) {
            if (canUp) {
              tankY = tankY - tankSize;
            }
          } else {
            state = 1;
          }
        } else if (checkKey(dummyChar, DOWN)) {
          if (state == 2) {
            if (canDown) {
              tankY = tankY + tankSize;
            }
          } else {
            state = 2;
          }
        } else if (checkKey(dummyChar, LEFT)) {
          if (state == 3) {
            if (canLeft) {
              tankX = tankX - tankSize;
            }
          } else {
            state = 3;
          }
        } else if (checkKey(dummyChar, RIGHT)) {
          if (state == 4) {
            if (canRight) {
              tankX = tankX + tankSize;
            }
          } else {
            state = 4;
          }
        }

        tankX = constrain(tankX, 0, width-tankSize);
        tankY = constrain(tankY, 0, height-tankSize);
      }
    }
    resetMove();
  }

  // shoot bullets and check if it is collidiing with enemy tanks
  void moveBullets(Tank enemy) {
    for (int i=theBullets.size()-1; i >=0; i-- ) {
      Bullet thisBullet = theBullets.get(i);
      thisBullet.move();
      thisBullet.display();
      thisBullet.isCollidingWithTank(enemy);
      thisBullet.isCollidingWithWall(map, realMap);
      thisBullet.out();

      if (thisBullet.hit == true) {
        theBullets.remove(i);
      }
    }
  }

  void moveBullets(ArrayList<TankAI> theAI) {

    for (int i=theBullets.size()-1; i >=0; i-- ) {
      Bullet thisBullet = theBullets.get(i);
      thisBullet.move();
      thisBullet.display();
      for (int a= theAI.size()-1; a >=0; a-- ) {
        TankAI thisAI = theAI.get(a);
        thisBullet.isCollidingWithTank(thisAI);
      }
      thisBullet.isCollidingWithWall(map, realMap);
      thisBullet.out();

      if (thisBullet.hit == true) {
        theBullets.remove(i);
      }
    }
  }


  void display() {
    if (hp >0 ) {
      if (state ==1) {
        image(tankUp, tankX, tankY);
      } else if (state ==2) {
        image(tankDown, tankX, tankY);
      } else if (state ==3) {
        image(tankLeft, tankX, tankY);
      } else if (state ==4) {
        image(tankRight, tankX, tankY);
      }
    }
    showHPbar();
  }

  void shoot() {
    if (hp >0) {
      if (player == 1) {
        char[] shoot = new char[]{' ', ' '};
        if (checkKey(shoot, -1)) {
          theBullets.add(new Bullet(state, tankX, tankY));
          sounds.shoot();
        }
      } else if (player == 2) {
        char[] shoot = new char[]{'5', '5'};
        if (checkKey(shoot, ENTER)) {
          theBullets.add(new Bullet(state, tankX, tankY));
          sounds.shoot();
        }
      }
    }
  }

  void collidingWithPlayer(Tank player) {
    if (player != this) {
      if (rectRectIntersect(this.tankX, this.tankY, this.tankX+40, this.tankY+40, player.tankX, player.tankY, player.tankX+40, player.tankY+40) == true) {
        if (this.tankX==player.tankX-40 && this.tankY-40<player.tankY  && this.tankY+40>player.tankY) {
          this.canRight = false;
        }
        if (this.tankX==player.tankX+40 && this.tankY-40<player.tankY  && this.tankY+40>player.tankY) {
          this.canLeft = false;
        }
        if (this.tankY==player.tankY-40 && this.tankX-40<player.tankX  && this.tankX+40>player.tankX) {
          this.canDown = false;
        }
        if (this.tankY==player.tankY+40 && this.tankX-40<player.tankX  && this.tankX+40>player.tankX) {
          this.canUp = false;
        }
      }
    }
  }

  void collidingWithAI(ArrayList<TankAI> theAI) {
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      if (rectRectIntersect(this.tankX, this.tankY, this.tankX+40, this.tankY+40, thisAI.tankX, thisAI.tankY, thisAI.tankX+40, thisAI.tankY+40) == true) {
        if (this.tankX==thisAI.tankX-40 && this.tankY-40<thisAI.tankY  && this.tankY+40>thisAI.tankY) {
          this.canRight = false;
        }
        if (this.tankX==thisAI.tankX+40 && this.tankY-40<thisAI.tankY  && this.tankY+40>thisAI.tankY) {
          this.canLeft = false;
        }
        if (this.tankY==thisAI.tankY-40 && this.tankX-40<thisAI.tankX  && this.tankX+40>thisAI.tankX) {
          this.canDown = false;
        }
        if (this.tankY==thisAI.tankY+40 && this.tankX-40<thisAI.tankX  && this.tankX+40>thisAI.tankX) {
          this.canUp = false;
        }
      }
    }
  }


  void collidingWithWall(char[][] map, Block[][] realMap) {
    for (int i = 0; i < 25; ++i) {
      for (int a = 0; a < 15; ++a) {
        if (map[i][a] == 'W' || map[i][a] == 'R' || map[i][a] == 'I' ) {
          if (rectRectIntersect(tankX, tankY, tankX+40, tankY+40, realMap[i][a].x, realMap[i][a].y, realMap[i][a].x+40, realMap[i][a].y+40) == true) {
            if (tankX == realMap[i][a].x-40 && tankY-40<realMap[i][a].y  && tankY+40>realMap[i][a].y) {
              this.canRight = false;
            }
            if (tankX == realMap[i][a].x+40 && tankY-40<realMap[i][a].y  && tankY+40>realMap[i][a].y) {
              this.canLeft = false;
            }
            if (tankY==realMap[i][a].y-40 && tankX-40<realMap[i][a].x  && tankX+40>realMap[i][a].x) {
              this.canDown = false;
            }
            if (tankY==realMap[i][a].y+40 && tankX-40<realMap[i][a].x  && tankX+40>realMap[i][a].x) {
              this.canUp = false;
            }
          }
        }
      }
    }
  }

  void showHPbar() {
    if (hp > 0) {
      float hpBarLength;
      hpBarLength = hp/fullHp * tankSize;
      noFill();
      rect(tankX, tankY, tankSize, 5);
      fill(255, 0, 0);
      rect(tankX, tankY, hpBarLength, 5);
    }
  }

  void die() {
    if ( hp <= 0) {
      tankX = -100;
      tankY = -100;
    }
  }

  void resetMove() {
    canUp = true; 
    canDown = true;
    canLeft = true; 
    canRight = true;
  }

  void removeAllBullets() {
    for (int i=theBullets.size()-1; i >=0; i-- ) {
      theBullets.remove(i);
    }
  }
}