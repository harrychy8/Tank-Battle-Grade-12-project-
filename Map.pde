class Map {
  // data
  int currentLevel;
  int size; 
  PImage ironIMG, grassIMG, wallIMG, waterIMG;
  boolean newLevel;
  // constructors

  Map(int _currentLevel) {
    size = 40;
    currentLevel = _currentLevel;
    wallIMG = loadImage("images/wall.png");
    wallIMG.resize(size, size);
    grassIMG = loadImage("images/grass.png");
    grassIMG.resize(size, size);
    ironIMG = loadImage("images/iron.png");
    ironIMG.resize(size, size);
    waterIMG = loadImage("images/water.png");
    waterIMG.resize(size, size);
    newLevel = true;
  }

  //behaviors
  void display() {
    if (newLevel) {
      createNewLevel(currentLevel);
      newLevel = false;
    }

    for (int i = 0; i < 25; ++i) {
      for (int a = 0; a < 15; ++a) {
        realMap[i][a].update();
      }
    }
  }

  void createNewLevel(int currentLevel) {

    mapTemplate = loadStrings("maps/level" + Integer.toString(currentLevel) + ".txt");

    for (int i = 0; i < 25; i++) {
      for (int a = 0; a < 15; a++) {

        map[i][a] = mapTemplate[a].charAt(i);
      }
    }

    for (int i = 0; i < 25; ++i) {
      for (int a = 0; a < 15; ++a) {
        if (map[i][a] == 'W') {
          realMap[i][a] = new Wall(i * size, a * size, wallIMG, 3);
        }
        if (map[i][a] == 'G' || map[i][a] == 'S') {
          realMap[i][a] = new Grass(i * size, a * size, grassIMG);
        }
        if (map[i][a] == 'R' ) {
          realMap[i][a] = new River(i * size, a * size, waterIMG);
        }
        if (map[i][a] == 'I') {
          realMap[i][a] = new Iron(i * size, a * size, ironIMG, -1);
        }
      }
    }
  }

  void die(int i, int a) {
    realMap[i][a] = new Grass(i * size, a * size, grassIMG);
    map[i][a] = 'G';
  }
}