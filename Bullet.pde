class Bullet {
  //data
  float x, y;
  ArrayList<Bullet> bullets;
  int xSpeed, ySpeed;
  int direction;
  boolean hit;

  //constructors
  Bullet(int _direction, float _x, float _y) {
    direction = _direction;
    xSpeed = 10;
    ySpeed = 10;
    x = _x;
    y = _y;
    hit = false;
  }

  //behaviors
  void move() {
    if (hit == false ) {
      if (direction ==1) {
        y -= ySpeed;
      } else if (direction ==2) {
        y += ySpeed;
      } else if (direction ==3) {
        x -= xSpeed;
      } else if (direction ==4) {
        x += xSpeed;
      }
    }
  }

  void display() {
    if (hit == false) {
      pushMatrix();
      translate(x+20, y+20);
      fill(0);
      ellipse(0, 0, 5, 5);
      popMatrix();
    }
  }

  // check if the bullet hit the tank, if it does, bullet will disapear and the tank will lose hp
  void isCollidingWithTank(Tank someTank) {
    if (hit == false) {
      float distenceInBetweenTank = dist(x, y, someTank.tankX, someTank.tankY);
      if (distenceInBetweenTank < 20) {
        someTank.hp -=1;
        hit = true;
      }
    }
  }


  void isCollidingWithWall( char[][] map, Block[][] realMap) {
    if (hit == false) {
      for (int i = 0; i < 25; ++i) {
        for (int a = 0; a < 15; ++a) {
          if (map[i][a] == 'W' ||  map[i][a] == 'I' ) {
            float distenceInBetweenWall = dist(x, y, realMap[i][a].x, realMap[i][a].y);
            if (distenceInBetweenWall < 20) {
              realMap[i][a].blockhp -= 1;
              hit = true;
              if (realMap[i][a].blockhp == 0) {
                pvpMapRef.die(i, a);
              }
            }
          }
        }
      }
    }
  }




  void out() {
    if ( x <0 || x > width || y <0 || y > height ) {
      hit = true;
    }
  }
}