class SoundEffects {
  Minim minim;

  AudioPlayer shootSound;
  AudioPlayer theAIshootSound;
  AudioPlayer mainMenuMusic;
  AudioPlayer pvpMusic;
  AudioPlayer pveMusic;
  AudioPlayer pvpWinMusic;
  AudioPlayer winMusic;
  AudioPlayer loseMusic;
  AudioPlayer theEndMusic;
  AudioPlayer hoverMusic;

  SoundEffects(PApplet p) {
    minim = new Minim(p);
    shootSound = minim.loadFile("sounds/shoot.wav");
    theAIshootSound = minim.loadFile("sounds/aiShoot.wav");
    mainMenuMusic = minim.loadFile("sounds/menu.mp3");
    pvpMusic = minim.loadFile("sounds/pvp.wav");
    pveMusic = minim.loadFile("sounds/pve.mp3");
    pvpWinMusic = minim.loadFile("sounds/pvpWin.mp3");
    winMusic = minim.loadFile("sounds/win.wav");
    loseMusic = minim.loadFile("sounds/lose.mp3");
    theEndMusic = minim.loadFile("sounds/theEnd.mp3");
    hoverMusic = minim.loadFile("sounds/click.mp3");
  }

  void shoot() {
    shootSound.play(0);
  }

  void theAIshoot() {
    theAIshootSound.play(0);
  }

  void hovered() {
    if (!hoverMusic.isPlaying() ) {
      hoverMusic.play(0);
    }
  }

  void mainMenuMusicPlay() {
    if (!mainMenuMusic.isPlaying()) {
      mainMenuMusic.play(0);
      mainMenuMusic.loop();
    }
  }

  void mainMenuMusicStop() {
    mainMenuMusic.pause();
  }

  void pvpMusicPlay() {
    if (!pvpMusic.isPlaying()) {
      pvpMusic.play(0);
      pvpMusic.loop();
    }
  }

  void pvpMusicStop() {
    pvpMusic.pause();
  }

  void pveMusicPlay() {
    if (!pveMusic.isPlaying()) {
      pveMusic.play(0);
      pveMusic.loop();
    }
  }

  void pveMusicStop() {
    pveMusic.pause();
  }

  void pvpWinMusicPlay() {
    pvpWinMusic.play(0);
  }


  void winMusicPlay() {
    winMusic.play(0);
  }

  void loseMusicPlay() {

    loseMusic.play(0);
  }

  void theEndMusicPlay() {
    if (!theEndMusic.isPlaying()) {
      theEndMusic.play(0);
    }
  }

  void theEndMusicStop() {
    theEndMusic.pause();
  }
}