class Button {
  //data
  String theLabel;
  float x, y;
  PFont theFont;
  boolean needHover;
  color fillColor;
  color hoverColor;
  boolean clicked;
  int textSize;
  float halfwidth, halfheight;
  boolean hovered;

  //constructors
  Button(String _theLabel, float _x, float _y, color _fillColor, int _textSize, boolean _needHover) {
    theLabel = _theLabel;
    x = _x;
    y = _y;
    needHover = _needHover;
    fillColor = _fillColor;
    hoverColor = 0;
    textSize = _textSize;
    clicked = false;
    theFont = loadFont("title.vlw");
  }

  Button(String _theLabel, float _x, float _y, color _fillColor, color _hoverColor, int _textSize, boolean _needHover, float _halfwidth, float _halfheight) {
    theLabel = _theLabel;
    x = _x;
    y = _y;
    needHover = _needHover;
    fillColor = _fillColor;
    hoverColor = _hoverColor;
    textSize = _textSize;
    clicked = false;
    halfwidth = _halfwidth;
    halfheight = _halfheight;
    theFont = loadFont("other.vlw");
    hovered = false;
  }

  // behaviors
  void display() {
    if (needHover ==true) {
      hovering();
    } else {
      fill(fillColor);
    }
    textAlign(CENTER, CENTER);
    textFont(theFont);
    textSize(textSize);
    text(theLabel, x, y);
  }

  void hovering() {

    if (mouseX< x+halfwidth && mouseX > x-halfwidth && mouseY < y+halfheight && mouseY > y -halfheight) {
      fill(hoverColor);
      if (hovered == false) {
        sounds.hovered();
        hovered = true;
      }
    } else {

      fill(fillColor);
      hovered = false;
    }
  }


  boolean clicked() {
    if (mouseX< x+halfwidth && mouseX > x-halfwidth && mouseY < y+halfheight && mouseY > y -halfheight && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}