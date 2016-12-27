// Comp Sci 30 Major Project //<>//
// Harry Chen
import ddf.minim.*;

PVPgame newPVPgame;
PVEgame newPVEgame;

// different button for different purposes
Button theTitleButton, thePVPbutton, PVPrestart, thePVEbutton, tryAgain, nextLevel, returnMainMenu;
Button easy, normal, hard, hell;
PImage backgroundIMG, theEndIMG;
boolean mainMenu, PVP, PVE, PVPscore, PVElose, PVEwin, PVEchooseDifficulty, theEnd;

SoundEffects sounds;
boolean needToPlay;

// since i need those three arrays everywhere, therefore i put them here as globals
String[] mapTemplate;
char[][] map = new char[25][15];
Block[][] realMap = new Block[25][15];

//global maps
Map pvpMapRef, pveMapRef;

int death;
int highScore;

void setup() {
  size(1000, 600);
  sounds = new SoundEffects(this);
  needToPlay = false;
  backgroundIMG = loadImage("images/background.png");
  backgroundIMG.resize(1000, 600);
  theEndIMG = loadImage("images/theEnd.jpg");
  theEndIMG.resize(1000, 0);
  // at the beginning, main menu should display first
  mainMenu =true;
  PVP = false;
  PVE = false;
  PVPscore = false;
  PVEwin = false; 
  PVElose = false;
  theEnd = false;
  newPVPgame = new PVPgame(this);
  newPVEgame = new PVEgame(this);

  // all kinds of buttons
  theTitleButton = new Button("WORLD OF TANKS", width/2, height/6, color(80, 200, 200), 80, false);
  thePVPbutton =  new Button("PVP MODE", width/2, height/2.5, color(240), color(0), 40, true, 100, 17.5);
  thePVEbutton =  new Button("PVE MODE", width/2, height/3*2, color(240), color(0), 40, true, 100, 17.5);
  PVPrestart = new Button("Play Again!", width/2, height/2+100, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  tryAgain = new Button("Try Again!", width/2, height/2+100, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  nextLevel= new Button("Next Level!", width/2, height/2+100, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  returnMainMenu = new Button("Main Menu", width/2, height/2 + 150, color(0), color(255, 0, 0), 40, true, 100, 17.5 );
  // difficulty buttons
  easy = new Button("Easy", width/2, height/2-150, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  normal = new Button("Normal", width/2, height/2-50, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  hard = new Button("Hard", width/2, height/2+50, color(0), color(255, 0, 0), 40, true, 100, 17.5);
  hell = new Button("Hell", width/2, height/2+150, color(0), color(255, 0, 0), 40, true, 100, 17.5);
}


void draw() {

  if (mainMenu == true) {
    sounds.mainMenuMusicPlay();
    // set everything else to be false;
    PVP = false;
    PVE = false;
    PVPscore = false;
    PVEwin = false; 
    PVElose = false;
    theEnd = false;

    image(backgroundIMG, 0, 0);
    death = 0;
    // call the different buttons (ignore the title :P)
    theTitleButton.display();
    thePVPbutton.display();
    thePVEbutton.display();
    // let player choose what to play
    if (thePVPbutton.clicked()) {
      PVP = true;
      sounds.mainMenuMusicStop();
    }
    if (thePVEbutton.clicked()) {
      PVEchooseDifficulty = true;
      sounds.mainMenuMusicStop();
    }
  }

  if (PVP == true) {
    sounds.pvpMusicPlay();
    // set evevrything else to be false
    mainMenu = false;
    PVE = false;
    PVPscore = false;
    PVEwin = false; 
    PVElose = false;
    theEnd = false;
    // run the game
    newPVPgame.mapDisplay();
    newPVPgame.theTankDisplay();
    // if any player dies in the pvp mode, the game will pause and show the current score
    if (newPVPgame.player1.hp <=0 || newPVPgame.player2.hp <= 0) {
      PVPscore =true;
      sounds.pvpMusicStop();
      needToPlay = true;
    }
  }

  if (PVPscore == true) {

    if (needToPlay) {
      sounds.pvpWinMusicPlay();
    }
    needToPlay = false;
    PVP = false;
    PVE = false;
    mainMenu = false;
    PVEwin = false; 
    PVElose = false;
    theEnd = false;
    fill(0);
    textAlign(CENTER, CENTER);
    if (newPVPgame.player1.hp <=0) {
      text("Player Two Won!", width/2, height/2-150);
    } else {
      text("Player One Won!", width/2, height/2-150);
    }
    text("Player One  " + newPVPgame.player1Score + " - " + newPVPgame.player2Score + "  Player Two ", width/2, height/2-100);
    PVPrestart.display();
    returnMainMenu.display();

    // opitions for the player(s)
    if (PVPrestart.clicked()) {
      newPVPgame.reset(this);
      PVP = true;
    }
    if (returnMainMenu.clicked()) {
      newPVPgame.reset(this);
      newPVPgame.resetScore();
      mainMenu = true;
    }
  }

  if (PVEchooseDifficulty) {
    mainMenu = false;
    background(255);
    easy.display();
    normal.display();
    hard.display();
    hell.display();

    if (easy.clicked()) {
      newPVEgame.speed = 60;
      PVE = true;
    }
    if (normal.clicked()) {
      newPVEgame.speed = 30;
      PVE = true;
    }
    if (hard.clicked()) {
      newPVEgame.speed = 15;
      PVE = true;
    }
    if (hell.clicked()) {
      newPVEgame.speed = 1;
      PVE = true;
    }
  }


  if (PVE == true) {
    sounds.pveMusicPlay();

    PVP = false;
    mainMenu = false;
    PVPscore = false;
    PVEwin = false; 
    PVElose = false;
    PVEchooseDifficulty = false;
    theEnd = false;

    // start pve game
    newPVEgame.mapDisplay();
    newPVEgame.theTankDisplay(sounds);
    newPVEgame.moveAI();
    // if player dies
    if (newPVEgame.player.hp <=0 ) {
      death += 1;
      PVElose = true;
      sounds.pveMusicStop();
      needToPlay = true;
    }
    // if player pass the level
    if (newPVEgame.levelPassed()) {

      PVEwin = true;
      sounds.pveMusicStop();
      needToPlay = true;
    }
  }

  if (PVElose == true) {

    if (needToPlay) {
      sounds.loseMusicPlay();
    }
    needToPlay = false;

    PVP = false;
    PVE = false;
    mainMenu = false;
    PVEwin = false;
    PVPscore = false;
    theEnd = false;

    fill(0);
    textAlign(CENTER, CENTER);
    text("Uh Oh, You Lost at Level " + newPVEgame.currentMapLevel + "! \nYour Score is " + newPVEgame.score + " ! Try Again!", width/2, height/2-100);
    tryAgain.display();
    returnMainMenu.display();
    // if player choose to retry, they will try that level again
    if (tryAgain.clicked()) {
      newPVEgame.reset(this);
      PVE = true;
    }
    //however, if player return to the main menu, the level is reseted
    if (returnMainMenu.clicked()) {
      newPVEgame.currentMapLevel = 1;
      newPVEgame.reset(this);
      mainMenu = true;
    }
  }

  if (PVEwin == true) {
    if (needToPlay) {
      sounds.winMusicPlay();
    }
    needToPlay = false;

    PVP = false;
    PVE = false;
    mainMenu = false;
    PVElose = false;
    PVPscore = false;
    theEnd = false;

    fill(0);
    textAlign(CENTER, CENTER);
    text("Well Done! Go For The Next Level!", width/2, height/2-100);
    nextLevel.display();
    returnMainMenu.display();
    // go to next level
    if (nextLevel.clicked()) {
      if (newPVEgame.currentMapLevel == 15) {
        theEnd = true;
      } else {
        newPVEgame.nextLevel(this);
        PVE = true;
      }
    }
    // back to main menu
    if (returnMainMenu.clicked()) {
      newPVEgame.currentMapLevel = 1;
      newPVEgame.reset(this);
      mainMenu = true;
    }
  }

  if (theEnd) {
    sounds.theEndMusicPlay();

    mainMenu = false;
    PVP = false;
    PVE = false;
    PVPscore = false;
    PVEwin = false; 
    PVElose = false;
    background(255);
    image(theEndIMG, 0, 0);

    highScore = int(loadStrings("data/highScore/highScore" + printDifficulty() + ".txt")[0]);

    textAlign(CENTER, CENTER);
    fill(0, 0, 255);
    text("Difficulty: " + printDifficulty(), width/2, height/2+ 80);
    fill(110, 215, 150);
    text("Your Score", width*0.2, height*0.7);
    text("Highest Score", width*0.8, height*0.7);
    fill(255, 0, 0);
    text(death + "  Deaths", width*0.2, height*0.85);
    text(highScore + "  Deaths", width*0.8, height*0.85);

    returnMainMenu.display();

    if (returnMainMenu.clicked()) {
      sounds.theEndMusicStop();
      resetHighScore();
      newPVEgame.currentMapLevel = 1;
      newPVEgame.reset(this);
      mainMenu = true;
    }
  }
}

String printDifficulty() {
  if (newPVEgame.speed == 60) {
    return "EASY";
  } else if (newPVEgame.speed == 30) {
    return "NORMAL";
  } else if (newPVEgame.speed == 15) {
    return "HARD";
  } else {
    return "HELL";
  }
}

void resetHighScore() {
  String[] justAlist = new String[1];

  if (death < highScore) {
    println(death, highScore);
    justAlist[0] = String.valueOf(death);
    saveStrings("data/highScore/highScore" + printDifficulty() + ".txt", justAlist);
  }
}

void keyPressed() {
  if (PVP ==true) {
    newPVPgame.theTankMove();
  }
  if (PVE ==true) {
    newPVEgame.thePlayerMove();
  }
}

// colliosn detection for everything, so i put it here
boolean rectRectIntersect(float left, float top, float right, float bottom, 
  float otherLeft, float otherTop, float otherRight, float otherBottom) {
  return !(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop);
}