class Mine {

  // number of rows and columns
  int rows;
  int cols;

  // distance between lines
  int distx;
  int disty;

  // field used for random mine generation
  float p = .2;

  // a 2D array keeping track of the mines
  boolean[][] mines;

  // a 2D array keeping track of which cells are clicked
  boolean[][] cellClicked;

  // a 2D array keeping track of which cells are flagged
  boolean[][] cellFlagged;

  // a 2D array indicating which cells have been checked for surrounding 0's
  boolean[][] checkedForZeros;

  //constructor
  Mine(int rows, int cols) {

    // initialize variables
    this.rows = rows;
    this.cols = cols;
    this.distx = width/cols;
    this.disty = height/rows;

    // initialize the arrays
    mines = new boolean[rows][cols];
    cellClicked = new boolean[rows][cols];
    cellFlagged = new boolean[rows][cols];
    checkedForZeros = new boolean[rows][cols];
  }

  void addMines() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j <cols; j++) {

        // randomly generate a # from 0 to 1, and if that # is less
        // than 0.2, true gets assigned to the cell, indicating a mine
        mines[i][j] = (random(0, 1) < p);

        // set cells clicked to false initially
        cellClicked[i][j]= false;
      }
    }
  }

  void displayBoard() {
    // draw vertical lines
    for (int i = 0; i < width; i += distx) {
      line(i, 0, i, height);
    }

    // draw horizontal lines
    for (int i = 0; i < height; i += disty) {
      line(0, i, width, i);
    }

    // check if cell was clicked or flagged
    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {

        // cell was flagged
        if (cellFlagged[i][j]) {

          // display flag image
          image(flag, j*distx, i*disty);
        }

        // cell was clicked
        if (cellClicked[i][j]) {

          // fill cell with black
          fill(0);
          rect(j*distx, i*disty, distx, disty);

          // write the number of adjacent mines in cell
          int adj = adjacentMines(i, j);
          fill(0, 255, 0);
          text(adj, (j*distx + distx/2), (i*disty + disty/2) );
        }
      }
    }
  }

  boolean allNonMinesFound() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        // if the cell has both no mine and not been clicked
        if (cellClicked[i][j] == false && mines[i][j] == false) {
          return false;
        }
      }
    }
    return true;
  }

  int adjacentMines(int r, int c) {
    int numMines = 0;

    // check the number of mines in adjacent cells
    for (int row = r-1; row <= r+1; row++) {
      // check for out of bounds row value
      if (row < 0 || row >= rows) continue;

      for (int col = c-1; col <= c+1; col++) {
        // check for out of bounds col value
        if (col < 0 || col >= cols) continue;

        // if mine exists in the row & col, increase # of mines
        if (mines[row][col]) numMines++;
      }
    }
    return numMines;
  }

  void flagCell(int x, int y) {
    int row;
    int col;
    row = y / disty;
    col = x / distx;

    // allows user to mark and unmark flags
    if (cellFlagged[row][col]) {
      cellFlagged[row][col] = false;
    } else {
      cellFlagged[row][col] = true;
    }
  }

  void gameOver() {
    // stop executing draw
    noLoop();
    //if key is pressed, game restarts
    if (keyPressed) {
      gameScreen=0;
    }


    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {

        // if the mine exists
        if (mines[i][j]) {


          // fill cell with mine images
          image(mine, j*distx, i*disty);
        }
      }
    }
    // display game over
    textSize(25);
    textAlign(CENTER);
    fill(255, 0, 0);
    text("  GAME OVER  ", width/2, height/5+10);

    //display restart button
    textSize(25);
    fill(0, 0, 255);
    textAlign(CENTER);
    text("  PRESS ANY KEY TO RESTART  ", width/2, height/5+200);
  }


  void youWon() {
    // stop executing draw
    noLoop();

    // display you won
    textSize(25);
    fill(0, 255, 0);
    textAlign(CENTER);
    text("  YOU WON  ", width/2, height/5+10);

    //display restart button
    textSize(25);
    fill(0, 0, 255);
    textAlign(CENTER);
    text("  RESTART  ", width/2, height/5+200);

    //if user presses restart button, it takes them back to instructions page
    if (mouseX>width/2+40 && mouseX <width/2-40 && mouseY>height/5+220 && mouseY <height/5+180) {
      if (mousePressed) {
        gameScreen = 0;
      }
    }
  }

  void revealSafeCells(int r, int c) {
    // this function is called when a cell has zero adjacent
    // mines. it checks if the adjacent cells to the
    // original cell also has zero adjacent mines.

    for (int row = r-1; row <= r+1; row++) {
      // check for out of bounds row value
      if (row < 0 || row >= rows) continue;

      for (int col = c-1; col <= c+1; col++) {
        // check for out of bounds col value
        if (col < 0 || col >= cols) continue;

        // adjacent cells are marked as checked
        cellClicked[row][col] = true;

        // one of the adjacent cells have zero adjacent mines
        if (adjacentMines(row, col) == 0) {

          // verify the cell has not been checked already
          if (!checkedForZeros[row][col]) {

            // now mark that the cell as checked
            checkedForZeros[row][col] = true;

            // recursively check for zero adjacent mines
            revealSafeCells(row, col);
          }
        }
      }
    }
  }

  void revealCell(int x, int y) {
    int adj, row, col;
    row = y / disty;
    col = x / distx;

    // cell is flagged, do not reveal
    if (cellFlagged[row][col]) return;

    // mark the cell as clicked
    cellClicked[row][col] = true;

    // the cell clicked has a mine
    if (mines[row][col]) {


      // display game over, end game
      gameOver();
    } else {
      // get the number of adjacent mines
      adj = adjacentMines(row, col);
      // cell has zero adjacent mines
      if (adj == 0) {
        // find adjacent mines to current cell
        revealSafeCells(row, col);
      }
    }
    if (allNonMinesFound()) {
      youWon();
    }
  }
}
