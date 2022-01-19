void initScreen() {

  float size = (width/20);

  //rectangle variables
  float x1 = size;
  float y1 = (size*13);
  float w1 = (size*7);
  float h1 = (size*3);

  float x2 = (size*13);
  float y2 = (size*13);
  float w2 = (size*6);
  float h2 = (size*3);

  float x3 = (size*7);
  float y3 = (size*16.5);
  float w3 = (size*6);
  float h3 = (size*3);

  //text placement variables so window can change

  float textLength1 = (size*13);
  float textLength2 = (size*19);
  float textLength3 = (size*19);
  float textLength4 = (size*16);
  float textLength5 = (size*20);
  float textLength6 = (size*16);

  float line1X = ((width-textLength1)/2);
  float line1Y = (size*2);

  float line2X = ((width-textLength2)/2);
  float line2Y = (size*4);

  float line3X = ((width-textLength3)/2);
  float line3Y = (size*6);

  float line4X = ((width-textLength4)/2);
  float line4Y = (size*8);

  float line5X = ((width-textLength5)/2);
  float line5Y = (size*10);

  float line6X = ((width-textLength6)/2);
  float line6Y = (size*12);

  //background color and text color and width
  background(255, 105, 180);
  stroke(0);

  //instructions
  textSize(size);
  fill(0, 255, 255);
  text("Welcome to Minesweeper!", line1X, line1Y);
  text("Try to find all the mines by clicking the boxes", line2X, line2Y);
  text("If there is no mine, a number will reveal how ", line3X, line3Y);
  text("many mines are surrounding it", line4X, line4Y);
  text("Right click a box to flag were you think a mine is", line5X, line5Y);
  text("Gameover if you left click on a mine", line6X, line6Y);

  //button background is white
  fill(255);

  //if the mouse is in the rectangle and is pressed
  if (mouseX>x1 && mouseX <x1+w1 && mouseY>y1 && mouseY <y1+h1) {
    if (mousePressed) {
      //10x10 grid
      gameScreen=1;
      fill(0);
    }
  }
  //button will turn black and game will begin
  rect(x1, y1, w1, h1);
  fill(50, 205, 50);
  text("10x10", x1+(width/40), y1+(width/12));

  fill(255);

  //if the mouse is in the rectangle and is pressed
  if (mouseX>x2 && mouseX <x2+w2 && mouseY>y2 && mouseY <y2+h2) {
    if (mousePressed) {

      gameScreen=2;
      N = 20;
      mymine = new Mine(N, N);
      mymine.addMines();

      fill(0);
    }
  }
  //button will turn black
  rect(x2, y2, w2, h2);
  fill(50, 205, 50);
  text("20x20", x2+(width/40), y2+(width/12));

  fill(255);

  //if the mouse is in the rectangle and is pressed
  if (mouseX>x3 && mouseX <x3+w3 && mouseY>y3 && mouseY <y3+h3) {
    if (mousePressed) {
      gameScreen=3;
      N = 30;
      mymine = new Mine(N, N);
      mymine.addMines();

      fill(0);
    }
  }
  //button will turn black
  rect(x3, y3, w3, h3);
  fill(50, 205, 50);
  text("30x30", x3+(width/40), y3+(width/12));
}
