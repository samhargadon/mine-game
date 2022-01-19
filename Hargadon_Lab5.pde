//define variables

Mine mymine;

PImage flag;
PImage mine;

int gameScreen = 0;

int N =10;

void setup() {
  size(400, 400);

  //initalize flag image
  flag = loadImage("Flag.png");
  //resize flag
  flag.resize(40, 40);

  //initalize mine image
  mine = loadImage("Mine.png");
  //resize mine
  mine.resize(40, 40);

  mymine = new Mine(N, N);
  mymine.addMines();
}

void draw () {
  //0 = instruction screen
  //1 = play game with N = 10
  //2 = play game with N = 20
  //3 = play game with N = 30

  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen==1) {
    gameScreen1();
  } else if (gameScreen==2) {
    gameScreen2();
  } else if (gameScreen == 3) {
    gameScreen3();
  }
}


void gameScreen1() {
  //10x10 grid
  N = 10;

  background(220);
  mymine.displayBoard();
}

void gameScreen2() {
  //20x20 grid
  N = 20;

  background(220);
  mymine.displayBoard();
}

void gameScreen3() {
  //30x30 grid
  N = 30;

  background(220);
  mymine.displayBoard();
}

void mousePressed() {
  if (gameScreen == 1 || gameScreen == 2 || gameScreen == 3) {
    if (mouseButton == LEFT) {
      // reveals cell
      mymine.revealCell(mouseX, mouseY);
    }
    if (mouseButton == RIGHT) {
      //flags cell
      mymine.flagCell(mouseX, mouseY);
    }
  }
}
