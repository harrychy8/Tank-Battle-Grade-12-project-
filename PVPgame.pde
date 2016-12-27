class PVPgame { //<>//

  // data
  Map PVPmap;
  Tank player1;
  Tank player2;

  int mapLevel;
  int testX, testY;
  int player1Score = 0, player2Score = 0;


  // constructors
  PVPgame(PApplet p) {
    mapLevel = round(random(1, 15));
    PVPmap = new Map(mapLevel);
    PVPmap.createNewLevel(mapLevel);
    pvpMapRef = PVPmap;
    player1 = randomPlayerPlace(player1, 1, p);
    player2 = randomPlayerPlace(player2, 2, p);
  }

  // behavior
  void mapDisplay() {
    PVPmap.display();
  }

  void theTankDisplay() {

    player1.display();
    tint(255, 0, 0);
    player2.display();
    tint(255, 255, 255);

    player1.moveBullets(player2);
    player2.moveBullets(player1);

    if (player1.hp <=0) {
      player2Score += 1;
    }
    if (player2.hp <=0) {
      player1Score += 1;
    }
  }

  void theTankMove() {
    player1.collidingWithPlayer(player2);
    player1.collidingWithWall(map, realMap);
    player2.collidingWithPlayer(player1);
    player2.collidingWithWall(map, realMap);
    player1.move();
    player2.move();
    player1.shoot();
    player2.shoot();
  }

  Tank randomPlayerPlace(Tank player, int playerNumber, PApplet p) {
    testX = round(random(0, 24)) * 40;
    testY = round(random(0, 14)) * 40;
    if (playerNumber ==1) {
      if (!wrongPlace(map, realMap)) {
        player = new Tank(playerNumber, testX, testY, round(random(1, 4)), p);
        return player;
      } else {
        return randomPlayerPlace(player, playerNumber, p);
      }
    } else {
      if (!wrongPlace(map, realMap) && testX != player1.tankX && testY != player1.tankY) {
        player = new Tank(playerNumber, testX, testY, round(random(1, 4)), p);
        return player;
      } else {
        return randomPlayerPlace(player, playerNumber, p);
      }
    }
  }

  boolean wrongPlace(char[][] map, Block[][] realMap) {
    for (int i = 0; i < 25; ++i) {
      for (int a = 0; a < 15; ++a) {
        //println(map[i][a]);
        if (map[i][a] == 'W' || map[i][a] == 'R' || map[i][a] == 'I' ) {
          if (dist(testX, testY, realMap[i][a].x, realMap[i][a].y) < 1) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void reset(PApplet p) {
    mapLevel = round(random(1, 15));
    PVPmap = new Map(mapLevel);
    PVPmap.createNewLevel(mapLevel);
    pvpMapRef = PVPmap;

    player1 = randomPlayerPlace(player1, 1, p);
    player2 = randomPlayerPlace(player2, 2, p);

    player1.hp = 3;
    player1.removeAllBullets();

    player2.hp = 3;
    player2.removeAllBullets();
  }

  void resetScore() {
    player1Score = 0;
    player2Score = 0;
  }
}