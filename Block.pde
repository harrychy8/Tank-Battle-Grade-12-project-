class Block {
  //data
  int x, y;
  PImage img;
  int blockhp;

  // constuctors
  Block(int x, int y, PImage imageToUse) {
    this.x = x;
    this.y = y;
    this.img = imageToUse;
  }

  // behaviors
  void update() {
    image(img, x, y);
  }
}


// child classes


class Grass extends Block {
  Grass(int x, int y, PImage imageToUse) {
    super(x, y, imageToUse);
  }
}

class River extends Block {
  River(int x, int y, PImage imageToUse) {
    super(x, y, imageToUse);
  }
}

class Wall extends Block {
  Wall(int x, int y, PImage imageToUse, int wallhp) {
    super(x, y, imageToUse);
    this.blockhp = wallhp;
  }
}

class Iron extends Block {
  Iron(int x, int y, PImage imageToUse, int ironhp ) {
    super(x, y, imageToUse);
    this.blockhp = ironhp;
  }
}