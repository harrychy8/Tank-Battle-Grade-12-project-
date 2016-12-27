class PVEgame {
  //data
  Map PVEmap;
  Tank player;
  TankAI computer;
  ArrayList<TankAI> theAI = new ArrayList <TankAI>();
  int currentMapLevel;
  int numberOfAI;
  int currentTanksAlive;
  int speed;
  int score;
  int timeBetweenSummon;
  int differentAI;
  boolean summoned;

  //constructors
  PVEgame(PApplet p) {
    currentMapLevel = 1;
    PVEmap = new Map(currentMapLevel);
    pveMapRef = PVEmap;
    player = new Tank(1, width/2+20, height-40, 1, p);
    score = 0;
    numberOfAI = 10 * currentMapLevel;
    numberOfAI = constrain(numberOfAI, 0, 50);
    summoned = false;
    currentTanksAlive = 0;
  }



  //behaviors
  void mapDisplay() {
    PVEmap.display();
  }

  void theTankDisplay(SoundEffects theAIshoot) {
    player.display();
    player.moveBullets(theAI);
    player.die();

    if (!summoned) {
      summonAI(theAIshoot);
    }

    displayAI();
  }


  void thePlayerMove() {
    player.collidingWithAI(theAI) ;
    player.collidingWithWall(map, realMap);
    player.move();
    player.shoot();
  }

  //void summonAI(int level) {
  //  for ( int i =0; i < numberOfAI; i++) {

  //    theAI.add(new TankAI( width/2+20, 0, round(random(1, 4))));
  //  }
  //}

  void summonAI(SoundEffects theAIshoot) {
    if (score + currentTanksAlive < numberOfAI) {
      if (currentTanksAlive < 4 || millis() - timeBetweenSummon > 8000) {
        randomAIPlace(theAIshoot);
        timeBetweenSummon = millis();
      }
    }
    if (theAI.size() == numberOfAI) {
      summoned = true;
    }
  }

  TankAI randomAIPlace(SoundEffects theAIshoot) {
    int testX, testY;
    testX = round(random(0, 24)) * 40;
    testY = round(random(0, 14)) * 40;
    if (placeToSummon(testX, testY, map, realMap) && !onTopOfTank(testX, testY)) {
      theAI.add(new TankAI(testX, testY, round(random(1, 4)), speed, theAIshoot));
      currentTanksAlive ++;
      return theAI.get(theAI.size() - 1);
    } else {
      return randomAIPlace(theAIshoot);
    }
  }

  boolean placeToSummon(int x, int y, char[][] map, Block[][] realMap) {
    for (int i = 0; i < 25; ++i) {
      for (int a = 0; a < 15; ++a) {
        if (map[i][a] == 'S' ) {
          if (x== realMap[i][a].x && y == realMap[i][a].y) 
            return true;
        }
      }
    }
    return false;
  }

  boolean onTopOfTank(int x, int y) {
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      if (thisAI.tankX == x && thisAI.tankY ==y) {
        return true;
      }
    }
    if (x == player.tankX && y == player.tankY) {
      return true;
    }
    return false;
  }


  void displayAI() {
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      thisAI.display();
      thisAI.moveBullets(player);
      thisAI.die();
    }
  }

  void moveAI() {
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      differentAI = round(random(1, 4));
      thisAI.collidingWithPlayer(player);
      thisAI.collidingWithWall(map, realMap);
      thisAI.collidingWithAI(theAI);
      thisAI.move(player.tankX,player.tankY);
      //thisAI.chase(player.tankX, player.tankY);



      if (thisAI.hp <= 0) {
        theAI.remove(i);
        currentTanksAlive --;
        score += 1;
      }
    }
  }


  void reset(PApplet p) {
    PVEmap = new Map(currentMapLevel);
    pveMapRef = PVEmap;
    player = new Tank(1, width/2+20, height-40, 1, p);
    player.removeAllBullets();
    for (int i= theAI.size()-1; i >=0; i-- ) {
      TankAI thisAI = theAI.get(i);
      thisAI.removeAllBullets();
      theAI.remove(i);
    }
    score = 0;
    numberOfAI = 10* currentMapLevel;
    numberOfAI = constrain(numberOfAI, 0, 50);
    summoned = false;
    currentTanksAlive = 0;
  }

  void nextLevel(PApplet p) {
    currentMapLevel += 1;
    PVEmap = new Map(currentMapLevel);
    pveMapRef = PVEmap;
    player = new Tank(1, width/2+20, height-40, 1, p);
    score = 0;
    numberOfAI = 10* currentMapLevel;
    numberOfAI = constrain(numberOfAI, 0, 50);
    summoned = false;
    currentTanksAlive = 0;
  }

  boolean levelPassed() {
    if (score == numberOfAI) {
      return true;
    } else {
      return false;
    }
  }
}